namespace TeamMapProfileData_stronghold_v5_0_1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(1016, 0, 574), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7094, 0, 7651), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(540, 0, 7111), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7634, 0, 1130), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4735, 0, 7602), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3342, 0, 623), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(655, 0, 4800), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7569, 0, 3424), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Stronghold v5.0.1", spots));
}

}  // namespace TeamMapProfileData_stronghold_v5_0_1
