namespace TeamMapProfileData_faster_than_light_1_1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(1856, 0, 1187), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4960, 0, 4287), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Faster Than Light", spots));
}

}  // namespace TeamMapProfileData_faster_than_light_1_1
