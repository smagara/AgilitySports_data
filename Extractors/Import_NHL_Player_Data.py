import requests
import csv
import time
import os
from dotenv import load_dotenv

load_dotenv()

# ==================================================
# NHL Active Roster Import (NHL API -> CSV export)
# ==================================================

# Utilize the free NHL API
url_base = os.getenv("NHLE_BASE_URL", "https://api-web.nhle.com/v1")
output_filename = "data/nhl_active_roster_full.csv"
limit = 300


# Active 2026 NHL Franchise Keys for ESPN API lookup
TEAMS = [
    "ANA", "BOS", "BUF", "CGY", "CAR", "CHI", "COL", "CBJ",
    "DAL", "DET", "EDM", "FLA", "LAK", "MIN", "MTL", "NSH",
    "NJD", "NYI", "NYR", "OTT", "PHI", "PIT", "SJS", "SEA",
    "STL", "TBL", "TOR", "UTA", "VAN", "VGK", "WSH", "WPG"
]

HEADER = [
    "playerID", "sportCode", "teamCode", "positionCode", "firstName", "lastName",
    "dateOfBirth", "height", "weight", "number", "college", "birthCountry",
    "birthCityState", "draftYear", "playerID", "handed", "goals", "penaltyMinutes", "points", "savePct"
]

print(f"[*] Initializing complete NHL data extraction agent into: {output_filename}")

with open(output_filename, mode="w", newline="", encoding="utf-8") as f:
    writer = csv.writer(f)
    writer.writerow(HEADER)
    
    for team in TEAMS:
        print(f"[->] Scraping active rosters for team: {team}")
        roster_url = f"{url_base}/roster/{team}/current"
        
        try:
            r = requests.get(roster_url, timeout=10)
            if r.status_code != 200:
                continue
            data = r.json()
        except Exception:
            print(f" [!] Connection issue fetching team {team}")
            continue
            
        # Parse through the three main roster divisions 
        for group in ["forwards", "defensemen", "goalies"]:
            if group not in data:
                continue
                
            for p_node in data[group]:
                p_id = p_node.get("id")
                
                # Fetch deeper statistical details from the official player profile landing page
                landing_url = f"{url_base}/player/{p_id}/landing"
                try:
                    p_req = requests.get(landing_url, timeout=10)
                    if p_req.status_code != 200:
                        continue
                    p_data = p_req.json()
                except Exception:
                    p_data = p_node  # Fallback gracefully to roster node variables if individual landing fails
                
                # Core Identifiers
                first_name = p_data.get("firstName", {}).get("default", p_node.get("firstName", {}).get("default", ""))
                last_name = p_data.get("lastName", {}).get("default", p_node.get("lastName", {}).get("default", ""))
                dob = p_data.get("birthDate", "NULL")
                pos = p_data.get("position", p_node.get("positionCode", "UNK"))
                weight = p_data.get("weightInPounds", "NULL")
                number = p_data.get("sweaterNumber", p_node.get("sweaterNumber", "NULL"))
                handed = p_data.get("shootsCatches", "NULL")
                
                # Dynamic Height Conversion (Inches to feet/inch string notation)
                height_inches = p_data.get("heightInInches")
                height_str = "NULL"
                if height_inches:
                    height_str = f"{height_inches // 12}' {height_inches % 12}\""
                
                # Geography tracking
                country = p_data.get("birthCountry", "NULL")
                city = p_data.get("birthCity", {}).get("default", "")
                state = p_data.get("birthStateProvince", {}).get("default", "")
                city_state = f"{city}, {state}".strip(", ") if state else city
                if not city_state: city_state = "NULL"
                
                # College data (Defaults to NULL per standard league pathways unless explicitly verified)
                college = "NULL" 
                
                # Extract Draft Year if present inside historical registry node
                draft_node = p_data.get("draftDetails", None)
                draft_year = draft_node.get("year", "NULL") if draft_node else "NULL"
                
                # Default metrics allocations
                goals, pim, points, save_pct = "NULL", "NULL", "NULL", "NULL"
                
                # Extract statistics fields cleanly
                featured_stats = p_data.get("featuredStats", {})
                regular_season = featured_stats.get("regularSeason", {})
                career_stats = regular_season.get("career", {}) if regular_season else {}
                sub_stats = regular_season.get("subSeason", {}) if regular_season else {}
                
                if pos == "G":
                    # NHL API exposes goalie save percentage as savePctg, with career under regularSeason.career.
                    raw_save_pct = career_stats.get("savePctg", sub_stats.get("savePctg", "NULL"))
                    if raw_save_pct == "NULL":
                        save_pct = "NULL"
                    else:
                        save_pct = f"{float(raw_save_pct):.2f}"
                    goals = 0
                    pim = sub_stats.get("pim", 0)
                    points = 0
                elif sub_stats:
                    goals = sub_stats.get("goals", "NULL")
                    pim = sub_stats.get("pim", "NULL")
                    points = sub_stats.get("points", "NULL")
                    save_pct = "NULL"
                
                # Compile matching your column constraints list array exactly
                row = [
                    p_id, "NHL", team, pos, first_name, last_name,
                    dob, height_str, weight, number, college, country,
                    city_state, draft_year, p_id, handed, goals, pim, points, save_pct
                ]
                
                writer.writerow(row)
                
        # Polite throttling to respect official endpoint servers
        time.sleep(0.2)

print("[*] Process complete! Full dataset exported cleanly.")