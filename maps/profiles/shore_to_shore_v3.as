namespace TeamMapProfileData_shore_to_shore_v3 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(533, 0, 1500), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(14866, 0, 1500), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(533, 0, 2500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(14866, 0, 2500), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(533, 0, 500), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(14866, 0, 500), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Shore_to_Shore_V3", spots));
}

}  // namespace TeamMapProfileData_shore_to_shore_v3
