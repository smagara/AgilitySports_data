import csv
import time

from utilities.espn_roster_api import fetch_espn_teams, fetch_team_roster, iter_roster_players
from utilities.player_model import Player
from utilities.player_row_builders import build_fif_attributes_row, build_players_row_with_team_meta

# ==================================================
# FIFA World Cup 2026 Roster Import (ESPN API -> CSV)
# ESPN league slug fifa.world surfaces FIFA World Cup
# national-team rosters and tournament totals.
# ==================================================

limit = 100
espn_sport = "soccer"
espn_league = "fifa.world"
sport_code = "FIF"
output_filename = "data/fif_worldcup_2026_roster_full.csv"

HEADER = [
    "playerID", "sportCode", "team_id", "team_abbrev", "team_name", "positionCode", "firstName", "lastName",
    "dateOfBirth", "height", "weight", "number", "college", "birthCountry",
    "birthCityState", "draftYear", "playerID", "totalGoals", "assists", "saves"
]


def resolve_birth_country(player, common: Player) -> str:
    """Prefer ESPN citizenship when birthPlace.country is missing (common for WC squads)."""
    if common.birth_country and common.birth_country != "NULL":
        return common.birth_country

    citizenship = player.get("citizenship") or player.get("citizenshipCountry")
    if isinstance(citizenship, dict):
        citizenship = (
            citizenship.get("abbreviation")
            or citizenship.get("name")
            or citizenship.get("displayName")
        )
    if citizenship:
        return str(citizenship)

    return "NULL"


print(f"[*] Initializing FIFA World Cup 2026 extraction into: {output_filename}")

try:
    teams_list = fetch_espn_teams(espn_sport, espn_league, limit=limit)
except RuntimeError as e:
    print(f"[!] Error discovering national teams: {e}")
    exit()

print(f"[+] Successfully mapped {len(teams_list)} FIFA World Cup national teams.")

players_written = 0
null_draft_year_count = 0
null_birth_country_count = 0
teams_skipped = 0

with open(output_filename, mode="w", newline="", encoding="utf-8") as f:
    writer = csv.writer(f)
    writer.writerow(HEADER)

    for team_node in teams_list:
        team = team_node.get("team", {})
        team_id = team.get("id")
        team_abbrev = team.get("abbreviation", "NULL")
        team_name = team.get("displayName") or team.get("name") or team_abbrev

        print(f"[->] Harvesting World Cup roster for: {team_name}, {team_id}, {team_abbrev}...")
        roster_data, roster_error = fetch_team_roster(team_id, espn_sport, espn_league)
        if roster_data is None:
            print(f"  [!] Skipping {team_name} - {roster_error}")
            teams_skipped += 1
            continue

        season_year = roster_data.get("season", {}).get("year")
        season_name = roster_data.get("season", {}).get("displayName", "")
        if season_name:
            print(f"  [=] Season: {season_name}")

        if "athletes" not in roster_data:
            continue

        for player in iter_roster_players(roster_data):
            common = Player.from_espn(
                player, sport_code, team_id, team_abbrev, team_name, season_year=season_year
            )
            common.birth_country = resolve_birth_country(player, common)

            if common.birth_country == "NULL":
                birth_place = player.get("birthPlace", {})
                with open("data/exceptions.txt", mode="a", newline="", encoding="utf-8") as g:
                    err_writer = csv.writer(g)
                    err_writer.writerow([
                        f"ID:{common.player_id} {common.last_name} {birth_place} "
                        f"Missing country: {common.birth_city_state}"
                    ])

            players_row = build_players_row_with_team_meta(common, team_id, team_abbrev, team_name)
            sport_attributes_row = build_fif_attributes_row(player)
            writer.writerow(players_row + sport_attributes_row)

            players_written += 1
            if common.draft_year == "NULL":
                null_draft_year_count += 1
            if common.birth_country == "NULL":
                null_birth_country_count += 1

        time.sleep(0.2)

print(f"[*] Process complete! FIFA World Cup dataset exported to: {output_filename}")
print(f"[*] Summary: wrote {players_written} player rows across {len(teams_list) - teams_skipped} teams "
      f"({teams_skipped} skipped).")
print(f"[*] Summary: NULL draftYear rows = {null_draft_year_count}")
print(f"[*] Summary: NULL birthCountry rows = {null_birth_country_count}")