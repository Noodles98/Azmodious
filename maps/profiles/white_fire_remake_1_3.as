namespace TeamMapProfileData_white_fire_remake_1_3 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(4988, 0, 2240), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3212, 0, 5928), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(455, 0, 739), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7715, 0, 7440), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1900, 0, 777), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6264, 0, 7385), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3111, 0, 1061), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5076, 0, 7131), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4296, 0, 349), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3891, 0, 7823), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5984, 0, 566), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2201, 0, 7617), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7580, 0, 1280), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(613, 0, 6883), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5887, 0, 1600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2312, 0, 6599), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("White Fire Remake", spots));
}

}  // namespace TeamMapProfileData_white_fire_remake_1_3
