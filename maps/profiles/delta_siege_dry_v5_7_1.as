namespace TeamMapProfileData_delta_siege_dry_v5_7_1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(819, 0, 1044), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9626, 0, 901), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(455, 0, 4178), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9851, 0, 3707), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(430, 0, 5796), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9871, 0, 5673), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(676, 0, 2478), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9400, 0, 2499), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2560, 0, 5673), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8008, 0, 5612), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Delta Siege Dry v5.7.1", spots));
}

}  // namespace TeamMapProfileData_delta_siege_dry_v5_7_1
