namespace TeamMapProfileData_nine_metal_islands_v1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(1900, 0, 5400), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(15100, 0, 9200), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9400, 0, 1200), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5600, 0, 14000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2037, 0, 10300), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(14440, 0, 5084), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6128, 0, 1528), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9539, 0, 14000), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8181, 0, 8214), "tech", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Nine_Metal_Islands_V1", spots));
}

}  // namespace TeamMapProfileData_nine_metal_islands_v1
