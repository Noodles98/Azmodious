namespace TeamMapProfileData_blindside_remake_v1_0 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(1623, 0, 3893), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(14900, 0, 2742), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8973, 0, 6520), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9072, 0, 1228), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3288, 0, 1209), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(13722, 0, 6504), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10803, 0, 3349), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6026, 0, 4427), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6420, 0, 6655), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(12798, 0, 1294), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5871, 0, 1328), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10945, 0, 6098), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8245, 0, 4063), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3969, 0, 3436), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(12887, 0, 4018), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3403, 0, 6206), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Blindside Remake v1.0", spots));
}

}  // namespace TeamMapProfileData_blindside_remake_v1_0
