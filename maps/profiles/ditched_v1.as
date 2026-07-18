namespace TeamMapProfileData_ditched_v1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(270, 0, 1600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8000, 0, 2530), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(270, 0, 3000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8000, 0, 1070), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(270, 0, 930), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8000, 0, 3130), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(270, 0, 2330), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8000, 0, 1670), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(270, 0, 270), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8000, 0, 3870), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(270, 0, 3800), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8000, 0, 270), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1000, 0, 1530), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7000, 0, 2530), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1000, 0, 2600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7130, 0, 1470), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1000, 0, 600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7200, 0, 3470), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1070, 0, 3600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7000, 0, 470), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Ditched_V1", spots));
}

}  // namespace TeamMapProfileData_ditched_v1
