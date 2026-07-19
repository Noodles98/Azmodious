namespace TeamMapProfileData_kings_assault_v1_3 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(7250, 0, 4086), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3000, 0, 4086), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8650, 0, 7400), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1500, 0, 7400), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7850, 0, 950), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2400, 0, 950), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9450, 0, 3000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(750, 0, 3000), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Kings Assault v1.3", spots));
}

}  // namespace TeamMapProfileData_kings_assault_v1_3
