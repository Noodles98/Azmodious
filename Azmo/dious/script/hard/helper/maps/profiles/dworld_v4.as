namespace TeamMapProfileData_dworld_v4 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(3700, 0, 2700), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9900, 0, 10000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10600, 0, 4700), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4900, 0, 11400), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5900, 0, 7600), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11300, 0, 8200), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3400, 0, 4500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8400, 0, 3500), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9200, 0, 8000), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2600, 0, 10700), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10600, 0, 3200), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3300, 0, 6200), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5800, 0, 2200), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7600, 0, 11600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6500, 0, 9500), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8500, 0, 6100), "tech", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("DWorld_V4", spots));
}

}  // namespace TeamMapProfileData_dworld_v4
