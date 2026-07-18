namespace TeamMapProfileData_quicksilver_remake_1_24 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(2251, 0, 5691), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4631, 0, 1477), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2107, 0, 2466), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5648, 0, 5175), "air", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Quicksilver Remake", spots));
}

}  // namespace TeamMapProfileData_quicksilver_remake_1_24
