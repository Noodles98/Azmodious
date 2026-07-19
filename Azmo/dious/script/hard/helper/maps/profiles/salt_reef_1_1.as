namespace TeamMapProfileData_salt_reef_1_1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(1807, 0, 7236), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8439, 0, 942), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(568, 0, 6673), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9682, 0, 1495), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1222, 0, 5596), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9044, 0, 2584), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(835, 0, 4448), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9424, 0, 3736), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1877, 0, 2989), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8358, 0, 5178), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(519, 0, 2826), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9723, 0, 5367), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1455, 0, 1820), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8802, 0, 6347), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(772, 0, 484), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9474, 0, 7688), "air", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Salt Reef", spots));
}

}  // namespace TeamMapProfileData_salt_reef_1_1
