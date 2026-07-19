namespace TeamMapProfileData_knockoutr_1_5 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(2544, 0, 7815), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6728, 0, 1364), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1419, 0, 2507), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7852, 0, 6691), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(793, 0, 5401), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8423, 0, 3797), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3815, 0, 829), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5437, 0, 8313), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1401, 0, 6691), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7834, 0, 2544), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2525, 0, 1327), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6728, 0, 7815), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3815, 0, 8294), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5419, 0, 811), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(866, 0, 3779), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8387, 0, 5382), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("KnockoutR", spots));
}

}  // namespace TeamMapProfileData_knockoutr_1_5
