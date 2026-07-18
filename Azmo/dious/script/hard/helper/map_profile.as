#include "maps/default_profiles.as"

namespace TeamMapProfile {

bool isResolved = false;
string mapName = "";
string preferredRole = "";
bool isLandLocked = false;

void Resolve(const AIFloat3& in startPos)
{
	if (isResolved)
		return;

	TeamMapProfileDefaults::RegisterAll();

	mapName = ai.GetMapName();
	TeamMapProfileTypes::Profile@ profile = TeamMapProfileRegistry::Find(mapName);
	if (profile !is null) {
		const int idx = TeamMapProfileRegistry::FindNearestSpotIndex(startPos, profile.spots);
		if ((idx >= 0) && (uint(idx) < profile.spots.length())) {
			preferredRole = profile.spots[idx].role;
			isLandLocked = profile.spots[idx].landLocked;
			AiLog("Map profile resolved: map='" + mapName + "', match='" + profile.mapNameMatch
				+ "', spot=" + idx + ", role='" + preferredRole + "', landLocked=" + isLandLocked
				+ ", startPos=(" + startPos.x + "," + startPos.z + ")");
		} else {
			AiLog("Map profile matched but no nearest spot: map='" + mapName + "', match='"
				+ profile.mapNameMatch + "'");
		}
	} else {
		AiLog("Map profile not found for map='" + mapName + "' (using slot role fallback)");
	}

	isResolved = true;
}

bool IsResolved()
{
	return isResolved;
}

bool HasPreferredRole()
{
	return preferredRole.length() > 0;
}

string GetPreferredRole()
{
	return preferredRole;
}

bool IsLandLocked()
{
	return isLandLocked;
}

string GetMapName()
{
	return mapName;
}

}  // namespace TeamMapProfile
