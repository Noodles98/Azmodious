namespace TeamMapProfileData_cloud9_v2 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(1600, 0, 1600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7600, 0, 7600), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1600, 0, 7600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7600, 0, 1600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1600, 0, 4100), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7600, 0, 4100), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4100, 0, 1600), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4100, 0, 7600), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4100, 0, 4100), "tech", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Cloud9_V2", spots));
}

}  // namespace TeamMapProfileData_cloud9_v2
