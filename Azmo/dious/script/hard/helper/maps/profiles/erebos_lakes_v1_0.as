namespace TeamMapProfileData_erebos_lakes_v1_0 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(1695, 0, 5279), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8542, 0, 4948), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2101, 0, 6359), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8152, 0, 3868), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2195, 0, 7655), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8043, 0, 2565), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2169, 0, 9493), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8029, 0, 726), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(705, 0, 4819), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9553, 0, 5408), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(718, 0, 5986), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9560, 0, 4235), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(755, 0, 7543), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9510, 0, 2673), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(921, 0, 8983), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9340, 0, 1236), "air", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Erebos Lakes v1.0", spots));
}

}  // namespace TeamMapProfileData_erebos_lakes_v1_0
