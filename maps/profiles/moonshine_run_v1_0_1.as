namespace TeamMapProfileData_moonshine_run_v1_0_1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(4360, 0, 7200), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7900, 0, 1000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3920, 0, 1850), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8400, 0, 6300), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1050, 0, 3300), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11200, 0, 4600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(650, 0, 7400), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11800, 0, 600), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1700, 0, 850), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10600, 0, 7300), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2300, 0, 5200), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10000, 0, 2900), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Moonshine Run v1.0.1", spots));
}

}  // namespace TeamMapProfileData_moonshine_run_v1_0_1
