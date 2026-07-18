namespace TeamMapProfileData_the_halite_maze_v1_4 {

void Register()
{
    array<TeamMapProfileTypes::StartSpot> spots = {
    TeamMapProfileTypes::StartSpot(AIFloat3(5600, 0, 600), "air", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(550, 0, 600), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5500, 0, 3500), "sea", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(600, 0, 3500), "front", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(5800, 0, 1900), "tech", false),
    TeamMapProfileTypes::StartSpot(AIFloat3(300, 0, 1900), "sea", false),
    };
    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("The Halite Maze v1.4", spots));
}

}  // namespace TeamMapProfileData_the_halite_maze_v1_4
