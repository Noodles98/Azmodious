namespace TeamMapProfileData_flats_and_forests_v2_2 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(660, 0, 360), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11600, 0, 11900), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(670, 0, 11600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11600, 0, 600), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2000, 0, 7400), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10160, 0, 4400), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6105, 0, 600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6105, 0, 11900), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2200, 0, 4400), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10120, 0, 7600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5400, 0, 4150), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7000, 0, 8000), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(660, 0, 3500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11500, 0, 8899), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7500, 0, 2400), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4774, 0, 9933), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2120, 0, 10600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11600, 0, 4500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2233, 0, 1562), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10170, 0, 10700), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Flats and Forests v2.2", spots));
}

}  // namespace TeamMapProfileData_flats_and_forests_v2_2
