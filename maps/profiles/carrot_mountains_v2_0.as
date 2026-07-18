namespace TeamMapProfileData_carrot_mountains_v2_0 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(1000, 0, 1500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(12000, 0, 12000), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11000, 0, 1353), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(470, 0, 10700), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(12000, 0, 5500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(330, 0, 6500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6500, 0, 800), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5200, 0, 11170), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10800, 0, 7300), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4800, 0, 4200), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8700, 0, 6900), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4700, 0, 8000), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6900, 0, 12000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2500, 0, 7200), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11200, 0, 3400), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1300, 0, 3600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2500, 0, 1200), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10000, 0, 11500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2200, 0, 11900), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1000, 0, 8700), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9500, 0, 275), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10700, 0, 7200), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7400, 0, 3500), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8100, 0, 1600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8900, 0, 9000), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4900, 0, 2500), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7100, 0, 8300), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8500, 0, 4800), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6900, 0, 12000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4000, 0, 6400), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4300, 0, 600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6171, 0, 6228), "tech", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Carrot Mountains v2.0", spots));
}

}  // namespace TeamMapProfileData_carrot_mountains_v2_0
