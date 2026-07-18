namespace TeamMapProfileData_eye_of_horus_1_7_1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(2836, 0, 1176), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3308, 0, 5992), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5170, 0, 989), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1003, 0, 6207), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(573, 0, 1075), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5557, 0, 6078), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Eye Of Horus", spots));
}

}  // namespace TeamMapProfileData_eye_of_horus_1_7_1
