namespace TeamMapProfileData_entrenched_plains_v2 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(400, 0, 2400), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(12000, 0, 3800), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(400, 0, 4500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(12000, 0, 1600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(400, 0, 1400), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(12000, 0, 4700), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(400, 0, 3500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(12000, 0, 2500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(400, 0, 400), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(12000, 0, 5800), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(400, 0, 5700), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(12000, 0, 400), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1500, 0, 2300), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10500, 0, 3800), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1500, 0, 3900), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10700, 0, 2200), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1500, 0, 900), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10800, 0, 5200), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1600, 0, 5400), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10500, 0, 700), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Entrenched_Plains_V2", spots));
}

}  // namespace TeamMapProfileData_entrenched_plains_v2
