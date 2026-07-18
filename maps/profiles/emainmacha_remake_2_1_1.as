namespace TeamMapProfileData_emainmacha_remake_2_1_1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(4112, 0, 7700), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4112, 0, 492), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(803, 0, 7750), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7340, 0, 508), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(535, 0, 7717), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(803, 0, 524), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2392, 0, 7733), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5767, 0, 508), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5816, 0, 7782), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2441, 0, 459), "sea", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("EmainMacha Remake", spots));
}

}  // namespace TeamMapProfileData_emainmacha_remake_2_1_1
