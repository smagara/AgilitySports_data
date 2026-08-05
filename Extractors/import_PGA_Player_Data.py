import csv
import re
import time
import urllib.request
import json

# ==================================================
# PGA Tour 2026 Roster Import (ESPN API -> CSV)
# Builds a current-season roster from ESPN PGA
# statistics leaderboards, enriched with athlete bio
# and season overview (events / majors).
# ==================================================

STATS_URL = (
    "https://site.web.api.espn.com/apis/site/v2/sports/golf/pga/statistics"
    "?region=us&lang=en&contentorigin=espn&limit=50"
)
ATHLETE_URL = "https://sports.core.api.espn.com/v2/sports/golf/leagues/pga/athletes/{athlete_id}?lang=en&region=us"
OVERVIEW_URL = "https://site.web.api.espn.com/apis/common/v3/sports/golf/pga/athletes/{athlete_id}/overview"

sport_code = "PGA"
team_code = "PGA"
team_name = "PGA Tour"
position_code = "G"
season_year = 2026
output_filename = "data/pga_tour_2026_roster_full.csv"

HEADER = [
    "playerID", "sportCode", "team_id", "team_abbrev", "team_name", "positionCode",
    "firstName", "lastName", "dateOfBirth", "height", "weight", "number", "college",
    "birthCountry", "birthCityState", "draftYear", "playerID",
    "wins", "majors", "drivingDistance", "scoringAverage", "eventsPlayed", "cutsMade",
]

CATEGORY_MAP = {
    "wins": "wins",
    "yardsPerDrive": "drivingDistance",
    "scoringAverage": "scoringAverage",
    "cutsMade": "cutsMade",
    "cupPoints": "cupPoints",
    "officialAmount": "earnings",
}


def http_json(url, timeout=60):
    req = urllib.request.Request(url, headers={"User-Agent": "AgilitySports-PGA-Importer/1.0"})
    with urllib.request.urlopen(req, timeout=timeout) as resp:
        return json.load(resp)


def parse_height_inches(display_height):
    if not display_height:
        return "NULL"
    m = re.match(r"^(\d+)\s*'\s*(\d+)\s*\"?\s*$", str(display_height).strip())
    if not m:
        return "NULL"
    return str(int(m.group(1)) * 12 + int(m.group(2)))


def parse_weight(value):
    if value is None:
        return "NULL"
    try:
        w = int(round(float(value)))
        return str(w) if w > 80 else "NULL"
    except (TypeError, ValueError):
        return "NULL"


def split_stat_value(raw):
    if raw is None:
        return None
    text = str(raw).strip().replace(",", "").replace("$", "")
    if text in ("", "--", "NULL", "N/A"):
        return None
    try:
        return float(text)
    except ValueError:
        return None


def overview_split_stats(overview, split_name):
    stats_node = overview.get("statistics") or {}
    names = stats_node.get("names") or []
    for split in stats_node.get("splits") or []:
        if (split.get("displayName") or "").strip().lower() == split_name.lower():
            values = split.get("stats") or []
            mapped = {}
            for idx, name in enumerate(names):
                mapped[name] = values[idx] if idx < len(values) else None
            return mapped
    return {}


print(f"[*] Initializing PGA 2026 extraction into: {output_filename}")
stats_payload = http_json(STATS_URL)
season = (stats_payload.get("season") or {}).get("year")
print(f"[+] ESPN season year: {season}")

players = {}
for category in (stats_payload.get("stats") or {}).get("categories") or []:
    cat_name = category.get("name")
    field = CATEGORY_MAP.get(cat_name)
    if not field:
        continue
    for leader in category.get("leaders") or []:
        athlete = leader.get("athlete") or {}
        athlete_id = str(athlete.get("id") or "").strip()
        if not athlete_id:
            continue
        row = players.setdefault(
            athlete_id,
            {
                "espnId": athlete_id,
                "displayName": athlete.get("displayName") or "",
                "wins": None,
                "drivingDistance": None,
                "scoringAverage": None,
                "cutsMade": None,
                "eventsPlayed": None,
                "majors": None,
            },
        )
        value = leader.get("value")
        if value is None:
            value = split_stat_value(leader.get("displayValue"))
        row[field] = value

print(f"[+] Unique athletes from leaderboards: {len(players)}")

enriched = []
for i, (athlete_id, row) in enumerate(sorted(players.items(), key=lambda kv: kv[1].get("displayName") or "")):
    try:
        bio = http_json(ATHLETE_URL.format(athlete_id=athlete_id))
    except Exception as exc:
        print(f"  [!] Bio failed for {athlete_id}: {exc}")
        bio = {}

    try:
        overview = http_json(OVERVIEW_URL.format(athlete_id=athlete_id))
        tour = overview_split_stats(overview, "PGA TOUR")
        majors = overview_split_stats(overview, "Majors")
        if tour:
            if row.get("eventsPlayed") is None:
                row["eventsPlayed"] = split_stat_value(tour.get("Tournaments Played"))
            if row.get("cutsMade") is None:
                row["cutsMade"] = split_stat_value(tour.get("Cuts Made"))
            if row.get("wins") is None:
                row["wins"] = split_stat_value(tour.get("Wins"))
            if row.get("scoringAverage") is None:
                row["scoringAverage"] = split_stat_value(tour.get("Scoring Average"))
        if majors:
            row["majors"] = split_stat_value(majors.get("Wins"))
    except Exception as exc:
        print(f"  [!] Overview failed for {athlete_id}: {exc}")

    birth_place = bio.get("birthPlace") or {}
    city = birth_place.get("city") or ""
    state = birth_place.get("state") or ""
    birth_city_state = f"{city}, {state}".strip(", ") if state else city
    if not birth_city_state:
        birth_city_state = "NULL"

    country = (
        bio.get("citizenship")
        or bio.get("citizenshipCountry")
        or birth_place.get("country")
        or "NULL"
    )
    if isinstance(country, dict):
        country = country.get("abbreviation") or country.get("name") or "NULL"

    first_name = bio.get("firstName") or ""
    last_name = bio.get("lastName") or ""
    if not first_name and not last_name and row.get("displayName"):
        parts = row["displayName"].split(" ", 1)
        first_name = parts[0]
        last_name = parts[1] if len(parts) > 1 else ""

    raw_dob = bio.get("dateOfBirth") or ""
    date_of_birth = raw_dob[:10] if raw_dob else "NULL"
    draft_year = bio.get("debutYear") or bio.get("turnedPro") or season_year
    college = (bio.get("college") or {})
    if isinstance(college, dict):
        college = college.get("name") or "NULL"
    if not college:
        college = "NULL"

    enriched.append(
        {
            "espnId": athlete_id,
            "firstName": first_name,
            "lastName": last_name,
            "dateOfBirth": date_of_birth,
            "height": parse_height_inches(bio.get("displayHeight")),
            "weight": parse_weight(bio.get("weight")),
            "college": college,
            "birthCountry": country if country else "NULL",
            "birthCityState": birth_city_state,
            "draftYear": draft_year,
            "wins": row.get("wins"),
            "majors": row.get("majors"),
            "drivingDistance": row.get("drivingDistance"),
            "scoringAverage": row.get("scoringAverage"),
            "eventsPlayed": row.get("eventsPlayed"),
            "cutsMade": row.get("cutsMade"),
        }
    )

    if (i + 1) % 25 == 0:
        print(f"  [=] Enriched {i + 1}/{len(players)} athletes...")
    time.sleep(0.12)

print(f"[+] Writing {len(enriched)} rows to {output_filename}")


def csv_val(value):
    if value is None:
        return "NULL"
    return value


with open(output_filename, mode="w", newline="", encoding="utf-8") as f:
    writer = csv.writer(f)
    writer.writerow(HEADER)
    for row in enriched:
        writer.writerow(
            [
                row["espnId"],
                sport_code,
                "1106",
                team_code,
                team_name,
                position_code,
                row["firstName"],
                row["lastName"],
                row["dateOfBirth"],
                row["height"],
                row["weight"],
                "NULL",
                row["college"],
                row["birthCountry"],
                row["birthCityState"],
                row["draftYear"],
                row["espnId"],
                csv_val(row["wins"]),
                csv_val(row["majors"]),
                csv_val(row["drivingDistance"]),
                csv_val(row["scoringAverage"]),
                csv_val(row["eventsPlayed"]),
                csv_val(row["cutsMade"]),
            ]
        )

print(f"[*] Process complete! PGA 2026 dataset exported to: {output_filename}")
print(f"[*] Summary: wrote {len(enriched)} player rows.")
