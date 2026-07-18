namespace TeamMapProfileData_twin_lakes_park_redux_1_2_2 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(1045, 0, 8118), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11296, 0, 2016), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1960, 0, 1580), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10304, 0, 8670), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6016, 0, 1630), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6272, 0, 8608), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(512, 0, 4416), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11792, 0, 5904), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Twin Lakes Park Redux", spots));
}

}  // namespace TeamMapProfileData_twin_lakes_park_redux_1_2_2
