namespace TeamMapProfileData_sulphur_springs_v1_1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(2101, 0, 5423), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6963, 0, 10043), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1826, 0, 7722), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4499, 0, 10527), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1782, 0, 3200), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9196, 0, 10483), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1000, 0, 300), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(12000, 0, 11000), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(440, 0, 9108), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3322, 0, 11870), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(500, 0, 4200), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8200, 0, 11800), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(500, 0, 1250), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11000, 0, 11800), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(800, 0, 6644), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5600, 0, 11700), "sea", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Sulphur Springs v1.1", spots));
}

}  // namespace TeamMapProfileData_sulphur_springs_v1_1
