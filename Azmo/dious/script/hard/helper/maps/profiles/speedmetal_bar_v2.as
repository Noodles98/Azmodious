namespace TeamMapProfileData_speedmetal_bar_v2 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(1000, 0, 250), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(12300, 0, 250), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1000, 0, 900), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(12300, 0, 900), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1000, 0, 1250), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(12300, 0, 1250), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1000, 0, 1800), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(12300, 0, 1800), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("SpeedMetal BAR V2", spots));
}

}  // namespace TeamMapProfileData_speedmetal_bar_v2
