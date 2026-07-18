namespace TeamMapProfileData_the_barrier_reef_remake_v1_0 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(2032, 0, 2208), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7100, 0, 8260), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3250, 0, 1750), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7000, 0, 6750), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(250, 0, 2270), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9750, 0, 7400), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1950, 0, 3800), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7800, 0, 5000), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1300, 0, 4750), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8800, 0, 4400), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(500, 0, 6000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9800, 0, 3700), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(400, 0, 500), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9360, 0, 9680), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2888, 0, 568), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6952, 0, 9816), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("The BARrier Reef Remake v1.0", spots));
}

}  // namespace TeamMapProfileData_the_barrier_reef_remake_v1_0
