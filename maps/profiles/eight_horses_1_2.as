namespace TeamMapProfileData_eight_horses_1_2 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(819, 0, 803), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7389, 0, 5325), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(803, 0, 5538), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7389, 0, 590), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2408, 0, 4489), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5718, 0, 1638), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3604, 0, 295), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4407, 0, 5816), "sea", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Eight Horses", spots));
}

}  // namespace TeamMapProfileData_eight_horses_1_2
