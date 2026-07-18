namespace TeamMapProfileData_tempest_v3 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(4300, 0, 1762), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6021, 0, 8438), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5837, 0, 1762), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4462, 0, 8439), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4424, 0, 225), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5734, 0, 9953), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5693, 0, 266), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4506, 0, 9933), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(451, 0, 492), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9748, 0, 9748), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9564, 0, 266), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(451, 0, 9974), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4055, 0, 2683), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6164, 0, 7639), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5898, 0, 2601), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4465, 0, 7598), "sea", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Tempest_V3", spots));
}

}  // namespace TeamMapProfileData_tempest_v3

