namespace TeamMapProfileData_greenhaven_bar_v1_2 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(664, 0, 440), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6488, 0, 6720), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(448, 0, 2800), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6790, 0, 4200), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(740, 0, 6300), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6400, 0, 860), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3000, 0, 230), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3920, 0, 6880), "sea", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Greenhaven BAR v1.2", spots));
}

}  // namespace TeamMapProfileData_greenhaven_bar_v1_2
