namespace TeamMapProfileData_tau12 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(376, 0, 3998), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7946, 0, 4064), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(262, 0, 7242), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7898, 0, 7258), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(360, 0, 2376), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7930, 0, 2294), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(442, 0, 5652), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7832, 0, 5636), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(426, 0, 377), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7799, 0, 312), "air", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Tau12", spots));
}

}  // namespace TeamMapProfileData_tau12
