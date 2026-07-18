namespace TeamMapProfileData_comet_catcher_remake_1_8 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(819, 0, 803), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7389, 0, 5325), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(803, 0, 5538), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7389, 0, 590), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2408, 0, 4489), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5718, 0, 1638), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3604, 0, 295), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4407, 0, 5816), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Comet Catcher Remake", spots));
}

}  // namespace TeamMapProfileData_comet_catcher_remake_1_8
