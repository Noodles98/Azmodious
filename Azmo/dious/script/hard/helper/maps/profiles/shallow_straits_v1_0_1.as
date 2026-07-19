namespace TeamMapProfileData_shallow_straits_v1_0_1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(5800, 0, 1900), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(344, 0, 4244), "sea", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Shallow Straits", spots));
}

}  // namespace TeamMapProfileData_shallow_straits_v1_0_1
