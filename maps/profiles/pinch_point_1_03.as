namespace TeamMapProfileData_pinch_point_1_03 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(5885, 0, 5035), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4600, 0, 2500), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5675, 0, 7520), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2550, 0, 6430), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1785, 0, 1940), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1020, 0, 560), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1725, 0, 8640), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4270, 0, 7350), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10500, 0, 5200), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11770, 0, 7735), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10700, 0, 2720), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(13820, 0, 3800), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(14580, 0, 8300), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(15350, 0, 9700), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(14650, 0, 1640), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(12100, 0, 2900), "sea", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Pinch Point 1.03", spots));
}

}  // namespace TeamMapProfileData_pinch_point_1_03
