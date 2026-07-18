namespace TeamMapProfileData_fallendell_v4 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(1150, 0, 800), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5000, 0, 4200), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5000, 0, 1500), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1100, 0, 3600), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Fallendell_V4", spots));
}

}  // namespace TeamMapProfileData_fallendell_v4
