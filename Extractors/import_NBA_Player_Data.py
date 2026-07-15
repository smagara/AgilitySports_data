import csv
import time

from utilities.espn_roster_api import ESPN_BASE_URL, fetch_espn_teams, fetch_team_roster, iter_roster_players
from utilities.player_model import Player
from utilities.player_row_builders import build_nba_attributes_row, build_players_row_with_team_meta

# ==================================================
# NBA Active Roster Import (ESPN API -> CSV export)
# ==================================================

limit = 300
output_filename = "data/nba_active_roster_full.csv"

# Target 18-column schema header layout from image_bf7cec.png
HEADER = [
    "playerID", "sportCode", "team_id", "team_abbrev", "team_name", "positionCode", "firstName", "lastName",
    "dateOfBirth", "height", "weight", "number", "college", "birthCountry",
    "birthCityState", "draftYear", "playerID", "pointsPerGame", "reboundsPerGame", "assistsPerGame"
]

print(f"[*] Initializing complete NBA data extraction agent into: {output_filename}")

# Step 1: Discover all active NBA team names and lookup IDs from ESPN
try:
    teams_list = fetch_espn_teams("basketball", "nba", limit=limit)
except RuntimeError as e:
    print(f"[!] Error discovering teams: {e}")
    exit()

print(f"[+] Successfully mapped {len(teams_list)} active NBA franchises.")

# Run summary counters
players_written = 0
null_draft_year_count = 0
null_birth_country_count = 0

# Step 2: Open target spreadsheet and stream player records row by row
with open(output_filename, mode="w", newline="", encoding="utf-8") as f:
    writer = csv.writer(f)
    writer.writerow(HEADER)
    
    for team_node in teams_list:
        team_id = team_node['team']['id']
        team_abbrev = team_node['team']['abbreviation']

        # Pulling 'name' (e.g., "Celtics") instead of abbreviation to match image_bf7cec.png
        team_name = team_node['team']['name']
        
        print(f"[->] Harvesting active roster data for the: {team_name}, {team_id}, {team_abbrev}...")
        roster_data, roster_error = fetch_team_roster(team_id, "basketball", "nba")
        if roster_data is None:
            print(f"  [!] Skipping {team_name} - {roster_error}")
            continue
        season_year = roster_data.get('season', {}).get('year')
            
        if 'athletes' not in roster_data:
            continue
            
        # NBA roster payload can be either grouped (with items) or a flat athlete list.
        players_iter = iter_roster_players(roster_data)

        for player in players_iter:
                common = Player.from_espn(player, "NBA", team_id, team_abbrev, season_year=season_year)

                if common.birth_country == "NULL":
                    birth_place = player.get('birthPlace', {})
                    with open("data/exceptions.txt", mode="a", newline="", encoding="utf-8") as g:
                        err_writer = csv.writer(g)
                        err_writer.writerow([f"ID:{common.player_id} {common.last_name} {birth_place} Missing country: {common.birth_city_state}"])
                
                # Compile matching your 18-column relational layouts exactly.
                # Leaves the dynamic metrics (PPG, RPG, APG) as NULL just like image_bf7cec.png
                players_row = build_players_row_with_team_meta(common, team_id, team_abbrev, team_name)
                sport_attributes_row = build_nba_attributes_row()
                row = players_row + sport_attributes_row
                
                writer.writerow(row)
                players_written += 1
                if common.draft_year == "NULL":
                    null_draft_year_count += 1
                if common.birth_country == "NULL":
                    null_birth_country_count += 1
                
        # Politeness throttling to protect endpoint servers
        time.sleep(0.2)

print(f"[*] Process complete! Full league dataset exported cleanly to: {output_filename}")
print(f"[*] Summary: wrote {players_written} player rows.")
print(f"[*] Summary: NULL draftYear rows = {null_draft_year_count}")
print(f"[*] Summary: NULL birthCountry rows = {null_birth_country_count}")