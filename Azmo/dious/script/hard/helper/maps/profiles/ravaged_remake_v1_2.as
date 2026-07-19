namespace TeamMapProfileData_ravaged_remake_v1_2 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(4411, 0, 803), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(700, 0, 4296), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4720, 0, 3141), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(420, 0, 2300), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3700, 0, 4070), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1617, 0, 880), "sea", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Ravaged Remake v1.2", spots));
}

}  // namespace TeamMapProfileData_ravaged_remake_v1_2
