namespace TeamMapProfileData_sector_318c_v1_0 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(1750, 0, 3550), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8500, 0, 4620), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2200, 0, 4850), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8100, 0, 3440), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2100, 0, 6500), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8200, 0, 1600), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1400, 0, 1960), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8888, 0, 6216), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(550, 0, 512), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9880, 0, 7820), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(400, 0, 4576), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9880, 0, 3632), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(440, 0, 7000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9900, 0, 730), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1600, 0, 8000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8400, 0, 500), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Sector 318C v1.0", spots));
}

}  // namespace TeamMapProfileData_sector_318c_v1_0
