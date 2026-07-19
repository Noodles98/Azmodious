namespace TeamMapProfileData_plains_and_passes_v1_0 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(1632, 0, 4344), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8544, 0, 5904), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1700, 0, 5800), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8560, 0, 4416), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(520, 0, 660), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9700, 0, 9500), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(660, 0, 9500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9600, 0, 660), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1950, 0, 2700), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8200, 0, 7500), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1900, 0, 7300), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8300, 0, 2850), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(280, 0, 3750), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10000, 0, 6500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(250, 0, 6500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10000, 0, 3700), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Plains and Passes v1.0", spots));
}

}  // namespace TeamMapProfileData_plains_and_passes_v1_0
