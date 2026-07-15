import csv
import time
from utilities.espn_roster_api import fetch_espn_teams, fetch_team_roster, iter_roster_players
from utilities.player_model import Player
from utilities.player_row_builders import build_nfl_attributes_row, build_players_row

# ==================================================
# NFL Active Roster Import (ESPN API -> CSV export)
# ==================================================

limit = 300
output_filename = "data/nfl_active_roster_full.csv"

# Target 17-column schema header layout from image_ae2bec.png
HEADER = [
    "playerID", "sportCode", "team_id", "teamCode", "teamName", "positionCode", "firstName", "lastName",
    "dateOfBirth", "height", "weight", "number", "college", "birthCountry",
    "birthCityState", "draftYear", "playerID", "sacks", "touchdowns"
]

print(f"[*] Initializing complete NFL data extraction agent into: {output_filename}")

# Step 1: Dynamically pull all active NFL team abbreviations and unique lookups from ESPN
try:
    teams_list = fetch_espn_teams("football", "nfl", limit=limit)
except RuntimeError as e:
    print(f"[!] Error discovering teams: {e}")
    exit()

print(f"[+] Successfully mapped {len(teams_list)} active NFL franchises.")

# Step 2: Open target spreadsheet and stream player records row by row
with open(output_filename, mode="w", newline="", encoding="utf-8") as f:
    writer = csv.writer(f)
    writer.writerow(HEADER)
    
    for team_node in teams_list:
        team_id = team_node['team']['id']
        team_abbrev = team_node['team']['abbreviation']
        team_name = team_node['team']['name']
        
        
        print(f"[->] Harvesting active roster data for: {team_abbrev}...")
        roster_data, roster_error = fetch_team_roster(team_id, "football", "nfl")
        if roster_data is None:
            print(f"  [!] Skipping {team_abbrev} - {roster_error}")
            continue
        season_year = roster_data.get('season', {}).get('year')
            
        if 'athletes' not in roster_data:
            continue
            
        # ESPN divides rosters into squad depth blocks (offense, defense, specialteams)
        for player in iter_roster_players(roster_data):
                common = Player.from_espn(player, "NFL", team_id, team_abbrev, team_name, season_year=season_year)
                
                # Compile matching your 17-column relational layouts exactly.
                # Leaves the dynamic metrics (sacks, touchdowns) as NULL just like image_ae2bec.png
                players_row = build_players_row(common)
                sport_attributes_row = build_nfl_attributes_row()
                row = players_row + sport_attributes_row
                
                writer.writerow(row)
                
        # Politeness throttling to protect endpoint servers
        time.sleep(0.2)

print(f"[*] Process complete! Full league dataset exported cleanly to: {output_filename}")