namespace TeamMapProfileData_the_tartar_steppe_v1_1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(2140, 0, 1100), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10200, 0, 11150), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2080, 0, 11077), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10200, 0, 1200), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2400, 0, 5500), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9800, 0, 6700), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2300, 0, 8100), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10000, 0, 4200), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2300, 0, 4000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10000, 0, 8080), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2400, 0, 6600), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9900, 0, 5580), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2200, 0, 2700), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10100, 0, 9700), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2200, 0, 9500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10100, 0, 2800), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("The Tartar Steppe v1.1", spots));
}

}  // namespace TeamMapProfileData_the_tartar_steppe_v1_1
