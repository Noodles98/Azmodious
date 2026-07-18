namespace TeamMapProfileData_supreme_isthmus_v1_7 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(7600, 0, 4900), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4600, 0, 7400), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7400, 0, 1200), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4800, 0, 11100), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11600, 0, 5000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(730, 0, 7300), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8300, 0, 3100), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4000, 0, 9300), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11400, 0, 1900), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(900, 0, 10400), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9700, 0, 4300), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2560, 0, 8000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7300, 0, 3700), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5000, 0, 8500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10150, 0, 600), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2200, 0, 11750), "air", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Supreme Isthmus v1.7", spots));
}

}  // namespace TeamMapProfileData_supreme_isthmus_v1_7
