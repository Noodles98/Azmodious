namespace TeamMapProfileData_canis_river_v1_4 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(3426, 0, 464), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3744, 0, 6691), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4636, 0, 1277), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2528, 0, 5868), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5548, 0, 1840), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1633, 0, 5321), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6656, 0, 1252), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(507, 0, 5921), "air", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Canis River v1.4", spots));
}

}  // namespace TeamMapProfileData_canis_river_v1_4
