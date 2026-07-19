namespace TeamMapProfileData_sailaway_2 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(100, 0, 2300), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4450, 0, 6550), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(500, 0, 7500), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4900, 0, 1600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1400, 0, 4300), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3900, 0, 3600), "sea", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("SailAway", spots));
}

}  // namespace TeamMapProfileData_sailaway_2
