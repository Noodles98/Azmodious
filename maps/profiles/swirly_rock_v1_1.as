namespace TeamMapProfileData_swirly_rock_v1_1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(3200, 0, 3400), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9400, 0, 6200), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2900, 0, 6250), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9100, 0, 3300), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3100, 0, 400), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9300, 0, 400), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2200, 0, 7500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10200, 0, 7600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(800, 0, 1500), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11700, 0, 1600), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(460, 0, 4600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(12000, 0, 4600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3160, 0, 4400), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9160, 0, 4360), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5800, 0, 1600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6300, 0, 5200), "air", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Swirly Rock v1.1", spots));
}

}  // namespace TeamMapProfileData_swirly_rock_v1_1
