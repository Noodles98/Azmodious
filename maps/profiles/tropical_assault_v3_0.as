namespace TeamMapProfileData_tropical_assault_v3_0 {

void Register()
{
    // Auto-generated from installed .sd7 map metadata.
    // Start spots are extracted from mapinfo.lua teams[].startPos where available.
    // Roles default to front and should be curated map-by-map.
    array<TeamMapProfileTypes::StartSpot> spots = {
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Tropical Assault v3.0", spots));
}

}  // namespace TeamMapProfileData_tropical_assault_v3_0
