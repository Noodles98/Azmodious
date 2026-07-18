namespace TeamMapProfileData_melting_glacier_v1_1_2 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(1617, 0, 1155), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8000, 0, 8000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2000, 0, 9000), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8800, 0, 900), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1500, 0, 4600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8900, 0, 4400), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5100, 0, 810), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4600, 0, 3000), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5800, 0, 3000), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4870, 0, 8910), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4110, 0, 620), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6900, 0, 5600), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(730, 0, 7788), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9600, 0, 6000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3000, 0, 2200), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8000, 0, 3000), "sea", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Melting Glacier v1.1.2", spots));
}

}  // namespace TeamMapProfileData_melting_glacier_v1_1_2
