import requests
import os
from dotenv import load_dotenv

# =====================================================
# ESPN free API interactions, shared by NBA, MLB, NFL
# =====================================================

load_dotenv()


ESPN_BASE_URL = os.getenv("ESPN_BASE_URL", "https://site.api.espn.com/apis/site/v2/sports")


def fetch_espn_teams(sport, league, limit=300, timeout=15, base_url=ESPN_BASE_URL):
    """Return team nodes from ESPN site API for a given sport/league."""
    url = f"{base_url}/{sport}/{league}/teams?limit={limit}"

    try:
        response = requests.get(url, timeout=timeout)
    except requests.RequestException as exc:
        raise RuntimeError(f"Error discovering teams: {exc}") from exc

    if response.status_code != 200:
        raise RuntimeError("Error: Could not reach team discovery endpoint.")

    try:
        discovery_data = response.json()
        return discovery_data["sports"][0]["leagues"][0]["teams"]
    except (ValueError, KeyError, IndexError, TypeError) as exc:
        raise RuntimeError(f"Error parsing team discovery response: {exc}") from exc


def fetch_team_roster(team_id, sport, league, timeout=15, base_url=ESPN_BASE_URL):
    """Return (roster_json, error_message)."""
    url = f"{base_url}/{sport}/{league}/teams/{team_id}/roster"

    try:
        response = requests.get(url, timeout=timeout)
    except requests.RequestException:
        return None, "Connection timed out"

    if response.status_code != 200:
        return None, f"Status: {response.status_code}"

    try:
        return response.json(), None
    except ValueError as exc:
        return None, f"Invalid JSON: {exc}"


def iter_roster_players(roster_data):
    """Yield player dictionaries from grouped or flat ESPN athlete payloads."""
    athletes = roster_data.get("athletes", [])
    if not athletes:
        return

    if isinstance(athletes[0], dict) and "items" in athletes[0]:
        for group in athletes:
            for player in group.get("items", []):
                if isinstance(player, dict):
                    yield player
        return

    for player in athletes:
        if isinstance(player, dict):
            yield player

def extract_espn_stat_map(player):
    """Flatten ESPN athlete statistics.splits.categories into name -> displayValue."""
    stats_map = {}
    statistics = player.get("statistics") or {}
    splits = statistics.get("splits") or {}
    categories = splits.get("categories") or []
    for category in categories:
        for stat in category.get("stats") or []:
            name = stat.get("name")
            if not name:
                continue
            value = stat.get("displayValue", stat.get("value"))
            if value is None or value == "":
                value = "NULL"
            stats_map[name] = value
    return stats_map