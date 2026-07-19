from dataclasses import dataclass

from utilities.city_country_lookup import CityCountryLookups
from utilities.infer_birth_country import infer_birth_country

# ===================================================================
# Main Player model DTO. Corresponds to the new Players MSSQL table.
# ===================================================================

@dataclass
class Player:
    player_id: str
    sport_code: str
    team_id: str
    team_code: str
    team_name: str
    position_code: str
    first_name: str
    last_name: str
    date_of_birth: str
    height: str
    weight: str
    number: str
    college: str
    birth_country: str
    birth_city_state: str
    draft_year: str

    @classmethod
    def from_espn(cls, player, sport_code, team_id, team_code, team_name, season_year=None):
        player_id = player.get("id", "NULL")

        first_name = player.get("firstName", "")
        last_name = player.get("lastName", "")
        position_code = player.get("position", {}).get("abbreviation", "UNK")

        weight = player.get("weight", "NULL")
        number = player.get("jersey", "NULL")
        height = player.get("displayHeight", "NULL")

        raw_dob = player.get("dateOfBirth", "")
        date_of_birth = raw_dob[:10] if raw_dob else "NULL"

        college = player.get("college", {}).get("name", "NULL")
        if not college:
            college = "NULL"

        birth_place = player.get("birthPlace", {})
        city = birth_place.get("city", "")
        state = birth_place.get("state", "")
        birth_city_state = f"{city}, {state}".strip(", ") if state else city
        if not birth_city_state:
            birth_city_state = "NULL"

        raw_country = birth_place.get("country", player.get("citizenship", "NULL"))
        if not raw_country:
            raw_country = "NULL"

        birth_country = infer_birth_country(birth_city_state, raw_country)
        if birth_country == "NULL":
            birth_country = CityCountryLookups.resolve(birth_city_state)

        draft_year = player.get("draft", {}).get("year")
        if draft_year is None or (isinstance(draft_year, str) and not draft_year.strip()):
            draft_year = player.get("debutYear")

        if draft_year is None or (isinstance(draft_year, str) and not draft_year.strip()):
            exp_years = player.get("experience", {}).get("years")
            if isinstance(exp_years, str):
                exp_years = exp_years.strip()
                exp_years = int(exp_years) if exp_years.isdigit() else None
            elif isinstance(exp_years, float):
                exp_years = int(exp_years)

            if isinstance(exp_years, int) and isinstance(season_year, int):
                draft_year = season_year - exp_years
            else:
                draft_year = "NULL"

        return cls(
            player_id=player_id,
            sport_code=sport_code,
            team_id=team_id,
            team_code=team_code,
            team_name=team_name,
            position_code=position_code,
            first_name=first_name,
            last_name=last_name,
            date_of_birth=date_of_birth,
            height=height,
            weight=weight,
            number=number,
            college=college,
            birth_country=birth_country,
            birth_city_state=birth_city_state,
            draft_year=draft_year,
        )

    def to_players_export_row(self):
        """Common Players-table projection with repeated playerID for join-friendly exports."""
        return [
            self.player_id,
            self.sport_code,
            self.team_id,
            self.team_code,
            self.team_name,
            self.position_code,
            self.first_name,
            self.last_name,
            self.date_of_birth,
            self.height,
            self.weight,
            self.number,
            self.college,
            self.birth_country,
            self.birth_city_state,
            self.draft_year,
            self.player_id,
        ]