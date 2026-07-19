namespace TeamMapProfileData_hellas_basin_v1_4 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(4530, 0, 4200), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7580, 0, 8700), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3600, 0, 4700), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8080, 0, 7750), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1000, 0, 4900), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7400, 0, 11300), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4950, 0, 900), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11400, 0, 7340), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1850, 0, 850), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11400, 0, 10400), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2232, 0, 3616), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8600, 0, 10050), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(560, 0, 2100), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10150, 0, 11700), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4544, 0, 2248), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10032, 0, 7720), "sea", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Hellas Basin v1.4", spots));
}

}  // namespace TeamMapProfileData_hellas_basin_v1_4
