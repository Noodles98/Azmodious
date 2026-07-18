namespace TeamMapProfileData_glacial_gap_v1_1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(1856, 0, 1912), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8440, 0, 2000), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5100, 0, 7400), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1280, 0, 5608), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8880, 0, 5440), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5264, 0, 1000), "tech", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Glacial Gap v1.1", spots));
}

}  // namespace TeamMapProfileData_glacial_gap_v1_1
