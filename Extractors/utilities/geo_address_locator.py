from geopy.geocoders import geolocator, geo_cache
from geopy.exc import GeocoderTimedOut
import time

def plugin_resolve_country(location_string):
    """
    Looks up country via geopy API, utilizing a local cache 
    to respect rate limits and maximize loop speed.
    """
    if not location_string or location_string == "NULL":
        return "NULL"
        
    # 1. Check if we already looked up this exact city/state string earlier
    if location_string in geo_cache:
        return geo_cache[location_string]
        
    # 2. Pre-clean specific shorthand text variations found in player lists
    clean_string = location_string.replace(", PQ", ", Canada").replace(", SA", ", Australia")
    if "San Pedro de Ma" in clean_string:
        clean_string = "San Pedro de Macoris, Dominican Republic"
        
    try:
        print(f"   [GeoAPI] Looking up coordinates for: {clean_string}...")
        
        # Respect Nominatim usage policies: 1-second delay between live network hits
        time.sleep(1.0) 
        
        location = geolocator.geocode(clean_string, language="en", timeout=10)
        if location:
            address_parts = location.address.split(",")
            country_name = address_parts[-1].strip()
            
            # Map common database string variances
            if country_name == "Great Britain": country_name = "United Kingdom"
            
            # Save to memory cache and return
            geo_cache[location_string] = country_name
            return country_name
            
    except GeocoderTimedOut:
        return "NULL" # Pass NULL gracefully on connection hiccups
        
    # If the API can't find it, cache it as NULL so we don't try looking it up again
    geo_cache[location_string] = "NULL"
    return "NULL"