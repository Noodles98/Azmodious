namespace TeamMapProfileData_greenest_fields_1_3_1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(1200, 0, 1200), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6992, 0, 6992), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1200, 0, 6992), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6992, 0, 1200), "sea", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Greenest Fields", spots));
}

}  // namespace TeamMapProfileData_greenest_fields_1_3_1
