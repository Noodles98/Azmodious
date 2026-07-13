#include "lane.as"
#include "terrain_data.as"


namespace LanePathing {

AIFloat3 BiasBuildPos(const AIFloat3& in pos, float baseSpread)
{
	const float spread = baseSpread * TerrainData::GetBuildSpreadScale(pos);
	return TeamLane::BiasPosition(pos, spread);
}

AIFloat3 BiasMovePos(const AIFloat3& in pos, float baseSpread)
{
	const float spread = baseSpread * TerrainData::GetPathSpreadScale(pos);
	return TeamLane::BiasPosition(pos, spread);
}

}  // namespace LanePathing
