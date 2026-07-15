# ==================================================
# Infer birth country from common US/CA addresses
# ==================================================

def infer_birth_country(city_state_str, existing_country):
    """
    Infers birthCountry if it is currently NULL, based on the birthCityState string.
    """
    # If we already have a valid country, keep it!
    if existing_country and existing_country != "NULL" and existing_country.strip():
        return existing_country
        
    if not city_state_str or city_state_str == "NULL":
        return "NULL"
        
    # Clean up string tokens
    clean_target = city_state_str.strip()
    
    # 1. Define geographic boundaries
    us_states = {
        'AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA', 'HI', 'ID', 
        'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 'MA', 'MI', 'MN', 'MS', 
        'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 
        'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY', 
        'DC', 'PR', 'GU', 'VI', 'MP', 'AS'
    }
    
    ca_provinces = {
        'ON', 'QC', 'BC', 'AB', 'MB', 'SK', 'NS', 'NB', 'PE', 'NL', 'YT', 'NT', 'NU'
    }
    
    # 2. Check for trailing state/province indicators (e.g., "San Diego, CA")
    if "," in clean_target:
        parts = [p.strip() for p in clean_target.split(",")]
        suffix = parts[-1].upper() # Get the region code
        
        if suffix in us_states:
            return "USA"
        if suffix in ca_provinces:
            return "Canada"

    # 3. Handle standalone international city fallbacks (e.g., "Berlin", "Moscow")
    city_lower = clean_target.lower()
    
       
    # If it's completely unidentifiable, pass it back out as NULL
    return "NULL"