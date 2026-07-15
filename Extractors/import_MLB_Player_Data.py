import csv
import time
from utilities.espn_roster_api import fetch_espn_teams, fetch_team_roster, iter_roster_players
from utilities.player_model import Player
from utilities.player_row_builders import build_mlb_attributes_row, build_players_row_with_team_meta

# ==================================================
# MLB Active Roster Import (ESPN API -> CSV export)
# ==================================================

output_filename = "data/mlb_active_roster_full.csv"
limit = 300

# Target 22-column schema header layout adapting structural tweaks and image_ca4fe5.png
HEADER = [
    "playerID", "sportCode", "team_id", "team_abbrev", "team_name", "positionCode", "firstName", "lastName",
    "dateOfBirth", "height", "weight", "number", "college", "birthCountry",
    "birthCityState", "draftYear", "playerID", "bats", "throws", "battingAverage", "homeRuns", "ERA"
]

print(f"[*] Initializing complete MLB data extraction agent into: {output_filename}")

# Step 1: Discover all active MLB team names and lookup IDs from ESPN
try:
    teams_list = fetch_espn_teams("baseball", "mlb", limit=limit)
except RuntimeError as e:
    print(f"[!] Error discovering teams: {e}")
    exit()

print(f"[+] Successfully mapped {len(teams_list)} active MLB franchises.")

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
        team_name = team_node['team']['name']
        
        print(f"[->] Harvesting active roster data for the: {team_name}, {team_id}, {team_abbrev}...")
        roster_data, roster_error = fetch_team_roster(team_id, "baseball", "mlb")
        if roster_data is None:
            print(f"  [!] Skipping {team_name} - {roster_error}")
            continue
        season_year = roster_data.get('season', {}).get('year')
            
        if 'athletes' not in roster_data:
            continue
            
        # Handles variations where MLB roster payload can be grouped or flat lists
        players_iter = iter_roster_players(roster_data)

        for player in players_iter:
            common = Player.from_espn(player, "MLB", team_id, team_abbrev, team_name, season_year=season_year)
            
            # Compile matching your 22-column relational layouts exactly
            players_row = build_players_row_with_team_meta(common, team_id, team_abbrev, team_name)
            sport_attributes_row = build_mlb_attributes_row(player)
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
