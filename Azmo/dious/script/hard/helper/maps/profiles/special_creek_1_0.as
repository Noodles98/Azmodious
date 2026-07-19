namespace TeamMapProfileData_special_creek_1_0 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Special Creek", spots));
}

}  // namespace TeamMapProfileData_special_creek_1_0
