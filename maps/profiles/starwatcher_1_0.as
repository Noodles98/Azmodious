namespace TeamMapProfileData_starwatcher_1_0 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(1127, 0, 6024), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11155, 0, 244), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2103, 0, 6680), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10177, 0, 1468), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(612, 0, 4772), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11674, 0, 3398), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2112, 0, 4990), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10163, 0, 3169), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(782, 0, 2682), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11465, 0, 5489), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2200, 0, 3468), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10071, 0, 4700), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(593, 0, 1110), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11687, 0, 7065), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2573, 0, 600), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9732, 0, 7575), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Starwatcher", spots));
}

}  // namespace TeamMapProfileData_starwatcher_1_0
