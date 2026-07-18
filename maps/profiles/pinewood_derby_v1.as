namespace TeamMapProfileData_pinewood_derby_v1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(600, 0, 700), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5500, 0, 2500), "sea", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Pinewood_Derby_V1", spots));
}

}  // namespace TeamMapProfileData_pinewood_derby_v1
