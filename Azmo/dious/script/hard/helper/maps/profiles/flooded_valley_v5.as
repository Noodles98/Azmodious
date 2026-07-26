namespace TeamMapProfileData_flooded_valley_v5 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(2396, 0, 205), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2335, 0, 4936), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3010, 0, 4690), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3113, 0, 430), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Flooded_Valley_V5", spots));
}

}  // namespace TeamMapProfileData_flooded_valley_v5
