namespace TeamMapProfileData_houses_of_tripolis_1_3 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(2800, 0, 2500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9700, 0, 6400), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2800, 0, 10300), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1500, 0, 6300), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6900, 0, 3200), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6900, 0, 9500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5600, 0, 8700), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2800, 0, 5500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6900, 0, 4700), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7000, 0, 7900), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2800, 0, 7100), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5500, 0, 4000), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6900, 0, 6300), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4200, 0, 7900), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4200, 0, 4700), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5600, 0, 7200), "tech", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Houses of Tripolis", spots));
}

}  // namespace TeamMapProfileData_houses_of_tripolis_1_3
