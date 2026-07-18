namespace TeamMapProfileData_titanduel_v3 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(522, 0, 399), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4628, 0, 4618), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1280, 0, 389), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3994, 0, 4751), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(328, 0, 901), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4915, 0, 4035), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("TitanDuel_V3", spots));
}

}  // namespace TeamMapProfileData_titanduel_v3
