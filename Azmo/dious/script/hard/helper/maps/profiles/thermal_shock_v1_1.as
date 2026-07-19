namespace TeamMapProfileData_thermal_shock_v1_1 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(4600, 0, 7550), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2424, 0, 5568), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(6336, 0, 7185), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(2928, 0, 3832), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7888, 0, 7408), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3072, 0, 2152), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(4112, 0, 9280), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(920, 0, 6080), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9360, 0, 9660), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(768, 0, 420), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5708, 0, 5900), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(976, 0, 4072), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(7368, 0, 9000), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(1624, 0, 2216), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(9250, 0, 7390), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(3135, 0, 1128), "front", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Thermal Shock v1.1", spots));
}

}  // namespace TeamMapProfileData_thermal_shock_v1_1
