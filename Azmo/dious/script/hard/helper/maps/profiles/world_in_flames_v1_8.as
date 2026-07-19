namespace TeamMapProfileData_world_in_flames_v1_8 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(3875, 0, 2315), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5565, 0, 4600), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6490, 0, 650), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9470, 0, 4310), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9270, 0, 1860), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(13770, 0, 1240), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11730, 0, 3075), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(14260, 0, 5160), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3675, 0, 7900), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(13250, 0, 7685), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("World In Flames v1.8", spots));
}

}  // namespace TeamMapProfileData_world_in_flames_v1_8
