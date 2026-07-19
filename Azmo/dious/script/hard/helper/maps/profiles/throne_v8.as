namespace TeamMapProfileData_throne_v8 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(1524, 0, 2777), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11354, 0, 6660), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4473, 0, 11133), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5210, 0, 909), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8995, 0, 10887), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(836, 0, 7791), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10076, 0, 2089), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4473, 0, 8970), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5603, 0, 2286), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8552, 0, 8184), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2605, 0, 4891), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9339, 0, 4301), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4080, 0, 5726), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6930, 0, 3908), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7176, 0, 7348), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6095, 0, 5579), "tech", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Throne_V8", spots));
}

}  // namespace TeamMapProfileData_throne_v8
