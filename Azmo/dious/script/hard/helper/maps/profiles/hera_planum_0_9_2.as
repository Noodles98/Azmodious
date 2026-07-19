namespace TeamMapProfileData_hera_planum_0_9_2 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(867, 0, 910), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9359, 0, 7258), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1919, 0, 1863), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8315, 0, 6301), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(651, 0, 2478), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9581, 0, 5685), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1826, 0, 3439), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8404, 0, 4743), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(682, 0, 4545), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9546, 0, 3639), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1910, 0, 5724), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8321, 0, 2458), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(696, 0, 6384), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9537, 0, 1788), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1844, 0, 7314), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8381, 0, 840), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Hera Planum", spots));
}

}  // namespace TeamMapProfileData_hera_planum_0_9_2
