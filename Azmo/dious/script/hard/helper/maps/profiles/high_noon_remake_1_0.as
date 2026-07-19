namespace TeamMapProfileData_high_noon_remake_1_0 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(1531, 0, 5850), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6671, 0, 2317), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(624, 0, 4107), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7540, 0, 4051), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(365, 0, 7523), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7824, 0, 662), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1771, 0, 7652), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6349, 0, 462), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1256, 0, 1176), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6932, 0, 6998), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("High Noon Remake", spots));
}

}  // namespace TeamMapProfileData_high_noon_remake_1_0
