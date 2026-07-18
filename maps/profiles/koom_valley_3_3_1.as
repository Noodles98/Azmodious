namespace TeamMapProfileData_koom_valley_3_3_1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(1573, 0, 4133), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10764, 0, 4108), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2064, 0, 2337), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10346, 0, 5732), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1942, 0, 5757), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10248, 0, 2435), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3170, 0, 4059), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9118, 0, 4133), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1917, 0, 7503), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10445, 0, 738), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1942, 0, 640), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10371, 0, 7503), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(393, 0, 5461), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11969, 0, 2558), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(393, 0, 2755), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11944, 0, 5560), "air", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Koom Valley 3", spots));
}

}  // namespace TeamMapProfileData_koom_valley_3_3_1
