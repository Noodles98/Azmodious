namespace TeamMapProfileData_sertagatta_v6_0_1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(740, 0, 5231), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7450, 0, 919), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(275, 0, 780), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7923, 0, 5360), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1217, 0, 2077), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6972, 0, 4076), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(718, 0, 3588), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7483, 0, 2566), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Sertagatta v6.0.1", spots));
}

}  // namespace TeamMapProfileData_sertagatta_v6_0_1
