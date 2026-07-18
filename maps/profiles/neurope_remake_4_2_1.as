namespace TeamMapProfileData_neurope_remake_4_2_1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(4590, 0, 4125), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5825, 0, 7260), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10000, 0, 5275), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1275, 0, 2500), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(13540, 0, 4400), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2060, 0, 6300), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10090, 0, 2810), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7500, 0, 4300), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8875, 0, 7500), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4225, 0, 490), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8410, 0, 1290), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7060, 0, 1660), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(15166, 0, 1539), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(15230, 0, 6854), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(12620, 0, 6490), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11870, 0, 1419), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Neurope_Remake", spots));
}

}  // namespace TeamMapProfileData_neurope_remake_4_2_1
