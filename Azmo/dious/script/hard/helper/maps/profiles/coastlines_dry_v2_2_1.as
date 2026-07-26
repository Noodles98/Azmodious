namespace TeamMapProfileData_coastlines_dry_v2_2_1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(2000, 0, 2000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8000, 0, 6000), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1200, 0, 5500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9300, 0, 5500), "air", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Coastlines_Dry_V2.2.1", spots));
}

}  // namespace TeamMapProfileData_coastlines_dry_v2_2_1
