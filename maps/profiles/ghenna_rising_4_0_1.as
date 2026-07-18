namespace TeamMapProfileData_ghenna_rising_4_0_1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(2360, 0, 2630), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(0, 0, 0), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1780, 0, 3810), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(0, 0, 0), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3752, 0, 1082), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(0, 0, 0), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3147, 0, 3233), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(0, 0, 0), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1651, 0, 1575), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(0, 0, 0), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Ghenna Rising", spots));
}

}  // namespace TeamMapProfileData_ghenna_rising_4_0_1
