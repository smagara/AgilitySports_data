from utilities.player_model import Player
from utilities.espn_roster_api import extract_espn_stat_map

# ===================================================================
# Output .csv file layout.
# ===================================================================

def build_players_row(common: Player):
    """Players-table shape for sports using teamCode directly (e.g., NFL)."""
    return common.to_players_export_row()


def build_players_row_with_team_meta(common: Player, team_id, team_abbrev, team_name):
    """Players projection with team metadata columns used by some export schemas."""
    return [
        common.player_id,
        common.sport_code,
        team_id,
        team_abbrev,
        team_name,
        common.position_code,
        common.first_name,
        common.last_name,
        common.date_of_birth,
        common.height,
        common.weight,
        common.number,
        common.college,
        common.birth_country,
        common.birth_city_state,
        common.draft_year,
        common.player_id,
    ]


def build_nfl_attributes_row():
    return ["NULL", "NULL"]


def build_nba_attributes_row():
    return ["NULL", "NULL", "NULL"]


def build_mlb_attributes_row(player):
    bats_node = player.get("bats", {})
    bats = bats_node.get("abbreviation", "NULL") if isinstance(bats_node, dict) else player.get("bats", "NULL")
    if not bats:
        bats = "NULL"

    throws_node = player.get("throws", {})
    throws = throws_node.get("abbreviation", "NULL") if isinstance(throws_node, dict) else player.get("throws", "NULL")
    if not throws:
        throws = "NULL"

    return [bats, throws, "NULL", "NULL", "NULL"]


def build_fif_attributes_row(player):
    """FIFA/soccer export metrics: total goals, assists, saves."""
    stats = extract_espn_stat_map(player)
    goals = stats.get("totalGoals", stats.get("goals", "NULL"))
    assists = stats.get("goalAssists", stats.get("assists", "NULL"))
    saves = stats.get("saves", "NULL")
    return [goals, assists, saves]