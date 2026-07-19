namespace TeamMapProfileData_folsomdamr_1_17 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(1577, 0, 3584), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8602, 0, 3604), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(819, 0, 2888), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9277, 0, 3011), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(922, 0, 4301), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9175, 0, 4362), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(983, 0, 5202), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9380, 0, 5222), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(881, 0, 1741), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9318, 0, 1823), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1331, 0, 6267), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8909, 0, 6246), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1495, 0, 942), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8868, 0, 1044), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("FolsomDamR", spots));
}

}  // namespace TeamMapProfileData_folsomdamr_1_17
