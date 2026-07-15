# Developer README

## Summary
This project imports active player roster data for major sports leagues and exports normalized CSV files into the data folder. From either the public free ESPN API (NFL, NBA, MLB) or the NHL.COM API (NHL).

Current import scripts:
- import_MLB_Player_Data.py (ESPN public API)
- import_NBA_Player_Data.py (ESPN public API)
- Import_NFL_Player_Data.py (ESPN public API)
- Import_NHL_Player_Data.py (NHL public API)

Shared helpers live under utilities and include ESPN API wrappers plus player normalization utilities.

## Requirements
- Python 3.10+
- Internet access for ESPN and NHL APIs

Install dependencies:
- pip install -r requirements.txt

requirements.txt includes:
- requests
- python-dotenv
- geopy

## Environment Configuration
Create or edit .env in the project root, prototyped in `.sample.env`:

ESPN_BASE_URL=https://site.api.espn.com/apis/site/v2/sports
NHLE_BASE_URL=https://api-web.nhle.com/v1

Notes:
- ESPN_BASE_URL is used by the ESPN import utilities.
- NHLE_BASE_URL is used by the NHL import script.
- Both values have code defaults, but .env is the preferred override.

## Usage
Run each importer from the project root:
```powershell
 python import_MLB_Player_Data.py
 python import_NBA_Player_Data.py
 python Import_NFL_Player_Data.py
 python Import_NHL_Player_Data.py
```

## Output Files
Generated CSV outputs are written to:
- data/mlb_active_roster_full.csv
- data/nba_active_roster_full.csv
- data/nfl_active_roster_full.csv
- data/nhl_active_roster_full.csv

Additional file that may be generated:
- data/exceptions.txt

## Development Notes
- ESPN roster payloads can be grouped or flat; iter_roster_players handles both.
- Scripts include light request throttling to reduce endpoint pressure.
- If API response shapes change, first review utilities/espn_roster_api.py and utilities/player_model.py.

- ESPN_API Utilities
  - `player_model.py` Define the ESPN API player model and the methods to extract data into it.
  - `player_row_builders.py` Write out the player .csv record structure.

- Address-related Utilities
  - `infer_birth_country.py` Logic to attempt to infer the country from other ESPN API fields.
  - `city_country_lookup.py` Dictionary of city/country mappings as a last-resort
  = `geo_address_locator.py` Not in use. References the geopy `geolocator` which is slow, requiring sleep()s.


