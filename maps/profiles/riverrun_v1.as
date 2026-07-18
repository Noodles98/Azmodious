namespace TeamMapProfileData_riverrun_v1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(500, 0, 800), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11800, 0, 11500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2400, 0, 900), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9950, 0, 11450), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(526, 0, 2124), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11700, 0, 10158), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Riverrun_V1", spots));
}

}  // namespace TeamMapProfileData_riverrun_v1
