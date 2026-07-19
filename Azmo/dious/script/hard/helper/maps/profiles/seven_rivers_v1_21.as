namespace TeamMapProfileData_seven_rivers_v1_21 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(2200, 0, 1430), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10000, 0, 6750), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2200, 0, 6700), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10100, 0, 1500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1500, 0, 4400), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11000, 0, 3700), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5540, 0, 440), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6700, 0, 7700), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8400, 0, 1600), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3900, 0, 6400), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6200, 0, 3000), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6000, 0, 5000), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(600, 0, 2400), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11800, 0, 5800), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(640, 0, 5400), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11800, 0, 2700), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Seven Rivers v1.21", spots));
}

}  // namespace TeamMapProfileData_seven_rivers_v1_21
