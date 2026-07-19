namespace TeamMapProfileData_silveridge_v1_0_1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(600, 0, 2500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9640, 0, 7740), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9640, 0, 2500), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(600, 0, 7740), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Silveridge", spots));
}

}  // namespace TeamMapProfileData_silveridge_v1_0_1
