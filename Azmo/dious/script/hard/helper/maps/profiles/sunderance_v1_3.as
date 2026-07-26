namespace TeamMapProfileData_sunderance_v1_3 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(1463, 0, 7436), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6710, 0, 748), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(451, 0, 1606), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7733, 0, 6611), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1200, 0, 6600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(341, 0, 4845), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7832, 0, 3311), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3003, 0, 539), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5192, 0, 7645), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5687, 0, 372), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2486, 0, 7766), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2079, 0, 2288), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6094, 0, 5896), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5423, 0, 2068), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2794, 0, 6105), "tech", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Sunderance V1.3", spots));
}

}  // namespace TeamMapProfileData_sunderance_v1_3
