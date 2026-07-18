namespace TeamMapProfileData_serene_caldera_v1_3 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(2900, 0, 2900), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(12700, 0, 12400), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2500, 0, 12500), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(12800, 0, 2800), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(900, 0, 8000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(14500, 0, 7000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6560, 0, 14200), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8700, 0, 1100), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3400, 0, 6700), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(12288, 0, 8464), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10160, 0, 3200), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5500, 0, 12100), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6500, 0, 1000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11000, 0, 14000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(14100, 0, 9800), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1300, 0, 10700), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3600, 0, 4200), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(12000, 0, 10900), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(14100, 0, 4700), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1450, 0, 5000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10700, 0, 1600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4100, 0, 13900), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4650, 0, 1360), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8900, 0, 14300), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3600, 0, 9700), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(12150, 0, 5500), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7600, 0, 6700), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7600, 0, 8700), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7600, 0, 13000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8600, 0, 3000), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4700, 0, 8300), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10700, 0, 6700), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8100, 0, 10600), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(8400, 0, 4500), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5200, 0, 4700), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(10500, 0, 9600), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9900, 0, 12500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5500, 0, 2700), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(11700, 0, 3400), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4200, 0, 11900), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Serene Caldera v1.3", spots));
}

}  // namespace TeamMapProfileData_serene_caldera_v1_3
