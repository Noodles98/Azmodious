namespace TeamMapProfileData_failed_negotiations_1_0 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(3293, 0, 1733), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8993, 0, 10536), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4383, 0, 3235), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7903, 0, 9054), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5228, 0, 2328), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7062, 0, 9948), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7067, 0, 2066), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5231, 0, 10209), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8463, 0, 2226), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3829, 0, 10044), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8248, 0, 3946), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4047, 0, 8309), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9837, 0, 3854), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2460, 0, 8409), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11508, 0, 1214), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(780, 0, 11057), "air", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Failed Negotiations 1.0", spots));
}

}  // namespace TeamMapProfileData_failed_negotiations_1_0
