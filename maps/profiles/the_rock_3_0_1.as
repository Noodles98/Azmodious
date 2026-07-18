namespace TeamMapProfileData_the_rock_3_0_1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(778, 0, 225), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9728, 0, 7680), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(430, 0, 7926), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9789, 0, 246), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(553, 0, 6984), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9748, 0, 1106), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(307, 0, 2130), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9585, 0, 5448), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(512, 0, 5816), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9748, 0, 2376), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2048, 0, 3277), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8253, 0, 4444), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(492, 0, 4076), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9830, 0, 3871), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8397, 0, 1434), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2089, 0, 6697), "sea", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("The Rock", spots));
}

}  // namespace TeamMapProfileData_the_rock_3_0_1
