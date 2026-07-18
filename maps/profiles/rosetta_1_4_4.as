namespace TeamMapProfileData_rosetta_1_4_4 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(600, 0, 6600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9600, 0, 1500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(570, 0, 1030), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9650, 0, 7040), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(420, 0, 3700), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2915, 0, 9700), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9800, 0, 4340), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1940, 0, 7410), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8300, 0, 670), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2500, 0, 150), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7730, 0, 7960), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3750, 0, 5050), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6450, 0, 3050), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2030, 0, 2700), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8170, 0, 5440), "sea", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Rosetta", spots));
}

}  // namespace TeamMapProfileData_rosetta_1_4_4
