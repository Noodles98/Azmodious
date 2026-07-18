namespace TeamMapProfileData_desolation_v1_0_1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(4500, 0, 5500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(620, 0, 644), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Desolation", spots));
}

}  // namespace TeamMapProfileData_desolation_v1_0_1
