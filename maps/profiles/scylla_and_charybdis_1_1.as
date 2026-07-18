namespace TeamMapProfileData_scylla_and_charybdis_1_1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(1295, 0, 1305), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6910, 0, 8916), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3053, 0, 988), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5147, 0, 8242), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5064, 0, 1024), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3128, 0, 9217), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6666, 0, 1140), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1532, 0, 9089), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1279, 0, 2455), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6915, 0, 7774), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2568, 0, 2246), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5614, 0, 7990), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4620, 0, 2265), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3578, 0, 7960), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6235, 0, 2359), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1975, 0, 7880), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Scylla and Charybdis 1.1", spots));
}

}  // namespace TeamMapProfileData_scylla_and_charybdis_1_1
