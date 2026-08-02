#include "../maps/default_profiles.as"

namespace TerrainProfile {

TeamMapProfileTypes::Profile@ activeProfile = null;
bool isResolved = false;

void Resolve()
{
	if (isResolved)
		return;
	isResolved = true;
	TeamMapProfileDefaults::RegisterAll();

	const string mapName = ai.GetMapName();
	TeamMapProfileTypes::Profile@ profile = TeamMapProfileRegistry::FindTerrain(mapName);
	if (profile !is null) {
		@activeProfile = profile;
		AiLog("Terrain profile resolved: map='" + mapName + "', match='"
			+ profile.mapNameMatch + "', minHeight=" + profile.terrain.minHeight
			+ ", maxHeight=" + profile.terrain.maxHeight + ", tidal=" + profile.terrain.tidalStrength
			+ ", waterMap=" + profile.terrain.waterMap);
		return;
	}
}

bool HasProfile()
{
	Resolve();
	return activeProfile !is null;
}

float GetMinHeight()
{
	Resolve();
	return (activeProfile !is null) ? activeProfile.terrain.minHeight : -8.f;
}

float GetMaxHeight()
{
	Resolve();
	return (activeProfile !is null) ? activeProfile.terrain.maxHeight : 140.f;
}

float GetHeightRange()
{
	const float range = GetMaxHeight() - GetMinHeight();
	return (range > 1.f) ? range : 1.f;
}

float GetHeightRatio(const AIFloat3& in pos)
{
	return (pos.y - GetMinHeight()) / GetHeightRange();
}

bool IsWaterMap()
{
	Resolve();
	return (activeProfile !is null) && activeProfile.terrain.waterMap;
}

float GetBuildScale()
{
	Resolve();
	if (activeProfile is null)
		return 1.0f;
	if (activeProfile.terrain.waterMap)
		return 0.92f;
	if (GetHeightRange() > 900.f)
		return 0.90f;
	return 1.0f;
}

float GetPathScale()
{
	Resolve();
	if (activeProfile is null)
		return 1.0f;
	if (activeProfile.terrain.waterMap)
		return 0.88f;
	if (GetHeightRange() > 900.f)
		return 0.85f;
	return 1.0f;
}

}  // namespace TerrainProfile