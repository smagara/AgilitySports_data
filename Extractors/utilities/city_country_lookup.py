import re

# =====================================================
# Non-network lookups for common cities, for data scrub
# =====================================================


class CityCountryLookups:
    # Comprehensive mapping derived directly from the image_4749e6.png roster manifest
    _STATIC_MAP = {
        # --- DOMINICAN REPUBLIC ---
        "yaguate": "Dominican Republic",
        "nizao": "Dominican Republic",
        "santo domingo": "Dominican Republic",
        "nagua": "Dominican Republic",
        "san pedro de macoris": "Dominican Republic",
        "san pedro de ma": "Dominican Republic",
        "tenares": "Dominican Republic",
        "esperanza": "Dominican Republic",
        "san cristobal": "Dominican Republic",
        "cotui": "Dominican Republic",
        "azua province": "Dominican Republic",
        "payita": "Dominican Republic",
        "mao": "Dominican Republic",
        "villa mella": "Dominican Republic",
        "moca": "Dominican Republic",
        "yamasa": "Dominican Republic",
        "la romana": "Dominican Republic",
        "bajos de haina": "Dominican Republic",
        "peravia": "Dominican Republic",
        "puerto plata": "Dominican Republic",
        "san francisco de macoris": "Dominican Republic",
        "sanchez": "Dominican Republic",
        "bani": "Dominican Republic",
        "maimon": "Dominican Republic",
        "san juan de la maguana": "Dominican Republic",
        "san juan de la m": "Dominican Republic",
        "baja domingo": "Dominican Republic",
        # --- VENEZUELA ---
        "maracaibo": "Venezuela",
        "valencia": "Venezuela",
        "barquisimeto": "Venezuela",
        "caripito": "Venezuela",
        "puerto cabello": "Venezuela",
        "sabaneta": "Venezuela",
        "naguanagua": "Venezuela",
        "guiria": "Venezuela",
        "san felix": "Venezuela",
        "carora": "Venezuela",
        "maracay": "Venezuela",
        "caracas": "Venezuela",
        "tariba": "Venezuela",
        "puerto ordaz": "Venezuela",
        "santa teresa de del tuy": "Venezuela",
        "santa teresa de": "Venezuela",
        "cumana": "Venezuela",
        "los teques": "Venezuela",
        "san felipe": "Venezuela",
        "nirgua": "Venezuela",
        "guatire": "Venezuela",
        "petare": "Venezuela",
        "el vigia": "Venezuela",
        # --- PUERTO RICO ---
        "mayaguez": "Puerto Rico",
        "arecibo": "Puerto Rico",
        "sabana grande": "Puerto Rico",
        "rio piedras": "Puerto Rico",
        "bayamon": "Puerto Rico",
        "ponce": "Puerto Rico",
        "caguas": "Puerto Rico",
        "humacao": "Puerto Rico",
        "carolina": "Puerto Rico",
        # --- CUBA ---
        "isla de la juventud": "Cuba",
        "havana": "Cuba",
        "holguin": "Cuba",
        "las tunas": "Cuba",
        "matanzas": "Cuba",
        "barcelona": "Cuba",  # Often refers to Cuban/Latin venues in context
        "santiago": "Cuba",
        "villa clara": "Cuba",
        "santa clara": "Cuba",
        # --- MEXICO ---
        "tijuana": "Mexico",
        "hermosillo": "Mexico",
        "ciudad juarez": "Mexico",
        "los mochis": "Mexico",
        "sinaloa": "Mexico",
        "baja california": "Mexico",
        "ahome": "Mexico",
        "sonora": "Mexico",
        # --- JAPAN ---
        "kitakyushu": "Japan",
        "tochigi": "Japan",
        "iwate": "Japan",
        "oshu": "Japan",
        "aichi": "Japan",
        "osaka": "Japan",
        "yokohama": "Japan",
        "nagoya": "Japan",
        "nara": "Japan",
        # --- TAIWAN ---
        "pingtung county": "Taiwan",
        "new taipei": "Taiwan",
        # --- Germany ---
        "frankfurt": "Germany",
        "munich": "Germany",
        "berlin": "Germany",
        # --- Czechia
        "prague": "Czechia",
        "havirov": "Czechia",
        # --- Russia
        "moscow": "Russia",
        # --- Japan
        "tokyo": "Japan",
        # --- Sweden
        "stockholm": "Sweden",
        "gothenburg": "Sweden",
        # --- Finland
        "helsinki": "Finland",
        "tampere": "Finland",
        # --- OTHER GLOBAL SIGNINGS ---
        "managua": "Nicaragua",
        "tolu sucre": "Colombia",
        "bogota": "Colombia",
        "willemstad": "Curacao",
        "oranjestad": "Aruba",
        "san pedro sula": "Honduras",
        "herrera": "Panama",
        "chitre": "Panama",
        "las tablas": "Panama",
        "panama city": "Panama",
        "nassau": "Bahamas",
        "seoul": "South Korea",
        "incheon": "South Korea",
        "bratislava": "Slovakia",
        # --- EXPLICIT REGION SUFFIXES ---
        "quebec city": "Canada",
        "adelaide": "Australia",
        "hornsby": "Australia",
        "middlesex": "United Kingdom",
        "naples": "United States",
    }

    @classmethod
    def resolve(cls, raw_text):
        if not raw_text or raw_text == "NULL":
            return "NULL"

        # Clean string layout tokens (remove punctuation, standard suffixes, accents)
        clean = raw_text.lower().strip()
        clean = re.sub(r"[\.,]", " ", clean)  # Strip commas or periods
        clean = re.sub(r"\s+(pq|sa|pr|dr)$", "", clean)  # Strip trailing region codes
        clean = re.sub(r"[áàäâ]", "a", clean)
        clean = re.sub(r"[éèëê]", "e", clean)
        clean = re.sub(r"[íìïî]", "i", clean)
        clean = re.sub(r"[óòöô]", "o", clean)
        clean = re.sub(r"[úùüû]", "u", clean)
        clean = re.sub(r"ñ", "n", clean)
        clean = " ".join(clean.split())  # Normalize whitespace

        # Match against database registry map
        return cls._STATIC_MAP.get(clean, "NULL")
