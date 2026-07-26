namespace TeamMapProfileData_project_sd_129_v1_0 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(1330, 0, 5718), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(13000, 0, 8500), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5800, 0, 13000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8500, 0, 1300), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2040, 0, 10200), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2256, 0, 3888), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3950, 0, 2100), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10400, 0, 12160), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2200, 0, 3800), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(12111, 0, 10400), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3380, 0, 11820), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10800, 0, 2400), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1270, 0, 8170), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1377, 0, 6057), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1640, 0, 1240), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8400, 0, 13000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3000, 0, 7080), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11000, 0, 7168), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7200, 0, 10900), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7200, 0, 3000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4072, 0, 4072), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9944, 0, 9808), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4150, 0, 9888), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10240, 0, 4400), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3322, 0, 8723), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10800, 0, 5577), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5511, 0, 3344), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8700, 0, 10400), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3311, 0, 5400), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10700, 0, 8600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8900, 0, 3300), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5390, 0, 10750), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Project SD-129 v1.0", spots));
}

}  // namespace TeamMapProfileData_project_sd_129_v1_0
