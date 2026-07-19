namespace TeamMapProfileData_red_rock_desert_v2 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(550, 0, 3600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6618, 0, 3600), "sea", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Red Rock Desert", spots));
}

}  // namespace TeamMapProfileData_red_rock_desert_v2
