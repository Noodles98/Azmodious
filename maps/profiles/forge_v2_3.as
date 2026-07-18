namespace TeamMapProfileData_forge_v2_3 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(2000, 0, 4096), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7272, 0, 5240), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5900, 0, 2700), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3300, 0, 6500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3400, 0, 2700), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5900, 0, 6500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(400, 0, 3500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8888, 0, 6000), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2200, 0, 1600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7100, 0, 7600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7100, 0, 1500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2100, 0, 7600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8800, 0, 3500), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(400, 0, 6000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1900, 0, 5300), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7300, 0, 4050), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Forge v2.3", spots));
}

}  // namespace TeamMapProfileData_forge_v2_3

