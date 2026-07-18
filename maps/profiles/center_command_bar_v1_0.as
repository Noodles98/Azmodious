namespace TeamMapProfileData_center_command_bar_v1_0 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(400, 0, 600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7777, 0, 3500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(400, 0, 3700), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7777, 0, 400), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(600, 0, 1600), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7500, 0, 2500), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(600, 0, 2500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7500, 0, 1600), "sea", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Center Command BAR v1.0", spots));
}

}  // namespace TeamMapProfileData_center_command_bar_v1_0
