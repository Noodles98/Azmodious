namespace TeamMapProfileData_onyx_cauldron_2_2_2 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(1778, 0, 1695), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6482, 0, 6628), "sea", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Onyx Cauldron", spots));
}

}  // namespace TeamMapProfileData_onyx_cauldron_2_2_2
