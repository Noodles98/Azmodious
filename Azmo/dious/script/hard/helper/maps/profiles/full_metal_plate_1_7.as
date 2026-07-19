namespace TeamMapProfileData_full_metal_plate_1_7 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(2400, 0, 850), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9650, 0, 11400), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(830, 0, 7350), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11400, 0, 4800), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(850, 0, 11400), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11200, 0, 800), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4700, 0, 2500), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7350, 0, 9750), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7200, 0, 850), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4850, 0, 11400), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2550, 0, 4850), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9750, 0, 7350), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(850, 0, 2500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11400, 0, 9650), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9500, 0, 2550), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2550, 0, 9650), "sea", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Full Metal Plate", spots));
}

}  // namespace TeamMapProfileData_full_metal_plate_1_7
