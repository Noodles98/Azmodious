namespace TeamMapProfileData_darkside_v3_0 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(1600, 0, 800), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11200, 0, 11200), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1800, 0, 11800), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10000, 0, 550), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6000, 0, 3600), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6600, 0, 9000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1150, 0, 7700), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10100, 0, 5150), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7000, 0, 500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5500, 0, 11800), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1900, 0, 3500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11150, 0, 8500), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Darkside v3.0", spots));
}

}  // namespace TeamMapProfileData_darkside_v3_0
