#include "terrain_bridge.as"

namespace TerrainData {

// Heuristic terrain classes based on local height. This is lightweight and safe
// to use from manager hooks where full engine terrain queries are unavailable.
enum Kind {
	WATER = 0,
	LOWLAND,
	HIGHLAND
}

Kind Classify(const AIFloat3& in pos)
{
	if (pos.y < -8.f)
		return Kind::WATER;
	if (pos.y > 140.f)
		return Kind::HIGHLAND;
	return Kind::LOWLAND;
}

float GetPathSpreadScale(const AIFloat3& in pos)
{
	const float baseScale = TerrainBridge::GetPathScale();
	switch (Classify(pos)) {
		case Kind::WATER: return 0.45f * baseScale;
		case Kind::HIGHLAND: return 0.70f * baseScale;
		default: return 1.0f * baseScale;
	}
}

float GetBuildSpreadScale(const AIFloat3& in pos)
{
	const float baseScale = TerrainBridge::GetBuildScale();
	switch (Classify(pos)) {
		case Kind::WATER: return 0.55f * baseScale;
		case Kind::HIGHLAND: return 0.80f * baseScale;
		default: return 1.0f * baseScale;
	}
}

string GetName(const AIFloat3& in pos)
{
	switch (Classify(pos)) {
		case Kind::WATER: return "water";
		case Kind::HIGHLAND: return "highland";
		default: return "lowland";
	}
}

}  // namespace TerrainData
