namespace TeamMapProfileData_tundra_continents_v2_3_1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(1520, 0, 2154), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6300, 0, 11600), "tech", true),
    TeamMapProfileTypes::StartSpot(AIFloat3(825, 0, 7070), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9845, 0, 4752), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9400, 0, 1500), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1550, 0, 12050), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5566, 0, 4136), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7050, 0, 8525), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1300, 0, 5300), "tech", true),
    TeamMapProfileTypes::StartSpot(AIFloat3(7020, 0, 5335), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6424, 0, 800), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1617, 0, 10500), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5533, 0, 4147), "sea", true),
    TeamMapProfileTypes::StartSpot(AIFloat3(7790, 0, 11253), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(407, 0, 550), "air", true),
    TeamMapProfileTypes::StartSpot(AIFloat3(3278, 0, 5654), "sea", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Tundra Continents v2.3.1", spots));
}

}  // namespace TeamMapProfileData_tundra_continents_v2_3_1

