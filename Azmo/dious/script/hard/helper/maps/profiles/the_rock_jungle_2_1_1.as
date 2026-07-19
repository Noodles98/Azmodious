namespace TeamMapProfileData_the_rock_jungle_2_1_1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(471, 0, 7660), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9789, 0, 573), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(717, 0, 614), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9585, 0, 7537), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(471, 0, 6492), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9810, 0, 1475), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(512, 0, 2970), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9687, 0, 5079), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1331, 0, 4833), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8765, 0, 3297), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(655, 0, 1884), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9216, 0, 6042), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2068, 0, 7107), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8212, 0, 881), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1946, 0, 594), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8131, 0, 7537), "sea", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("The Rock Jungle", spots));
}

}  // namespace TeamMapProfileData_the_rock_jungle_2_1_1
