namespace TeamMapProfileData_esker_creek_1_3 {

void Register()
{
    // Auto-generated from installed .sd7 map metadata.
    // Start spots are extracted from mapinfo.lua teams[].startPos where available.
    // Roles default to front and should be curated map-by-map.
    array<TeamMapProfileTypes::StartSpot> spots = {
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Esker Creek", spots));
}

}  // namespace TeamMapProfileData_esker_creek_1_3
