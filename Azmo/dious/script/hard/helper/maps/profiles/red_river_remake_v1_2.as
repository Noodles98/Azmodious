namespace TeamMapProfileData_red_river_remake_v1_2 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(624, 0, 624), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9680, 0, 13664), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9680, 0, 576), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(384, 0, 13456), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6100, 0, 450), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4224, 0, 13500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(832, 0, 3968), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9616, 0, 9440), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(608, 0, 8160), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9776, 0, 4320), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3024, 0, 9680), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7664, 0, 6416), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3552, 0, 2768), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6672, 0, 11550), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3504, 0, 6656), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5800, 0, 9400), "sea", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Red River Remake v1.2", spots));
}

}  // namespace TeamMapProfileData_red_river_remake_v1_2
