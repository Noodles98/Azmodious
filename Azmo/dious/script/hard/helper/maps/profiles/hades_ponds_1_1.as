namespace TeamMapProfileData_hades_ponds_1_1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(1000, 0, 7000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7200, 0, 1200), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1840, 0, 6500), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6350, 0, 1650), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1150, 0, 5550), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7500, 0, 2600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(450, 0, 4400), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7700, 0, 3750), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(975, 0, 3350), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7200, 0, 4800), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1350, 0, 2425), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6850, 0, 5750), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1300, 0, 1350), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6900, 0, 6800), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(550, 0, 675), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7650, 0, 7500), "air", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Hades Ponds", spots));
}

}  // namespace TeamMapProfileData_hades_ponds_1_1
