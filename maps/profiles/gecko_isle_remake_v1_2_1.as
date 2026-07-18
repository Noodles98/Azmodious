namespace TeamMapProfileData_gecko_isle_remake_v1_2_1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(3760, 0, 8070), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(0, 0, 0), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1090, 0, 8090), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(0, 0, 0), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5870, 0, 8230), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(0, 0, 0), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4400, 0, 6670), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(0, 0, 0), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2030, 0, 6460), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(0, 0, 0), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7100, 0, 6800), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(0, 0, 0), "sea", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Gecko Isle Remake v1.2.1", spots));
}

}  // namespace TeamMapProfileData_gecko_isle_remake_v1_2_1
