namespace TeamMapProfileData_mediterraneum_v1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(5200, 0, 9000), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(13800, 0, 9100), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4500, 0, 15000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10700, 0, 3500), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3200, 0, 2700), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10700, 0, 11700), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(15200, 0, 15500), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1100, 0, 10100), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4900, 0, 6200), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(14600, 0, 4200), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9450, 0, 7230), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7800, 0, 2500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1700, 0, 13200), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5900, 0, 12700), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9800, 0, 15800), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(15600, 0, 600), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11800, 0, 6600), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(14400, 0, 11500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7900, 0, 5100), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3100, 0, 7100), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8900, 0, 14200), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9800, 0, 9900), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1200, 0, 1200), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6700, 0, 11100), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(13200, 0, 13000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(15700, 0, 6900), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4200, 0, 10800), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5800, 0, 900), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7231, 0, 8130), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1100, 0, 7200), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(800, 0, 3800), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(14100, 0, 1600), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Mediterraneum_V1", spots));
}

}  // namespace TeamMapProfileData_mediterraneum_v1
