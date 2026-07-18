namespace TeamMapProfileData_theta_crystals_1_3 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(1864, 0, 5102), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5075, 0, 1860), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(409, 0, 5352), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5392, 0, 406), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2374, 0, 6487), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6486, 0, 2377), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(665, 0, 6421), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6424, 0, 665), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Theta Crystals", spots));
}

}  // namespace TeamMapProfileData_theta_crystals_1_3
