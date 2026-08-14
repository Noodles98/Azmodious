namespace TeamMapProfileTypes {

class StartSpot {
	AIFloat3 pos;
	string role;
	bool landLocked;

	StartSpot()
	{
		role = "front";
		landLocked = false;
	}

	StartSpot(const AIFloat3& in p, const string& in r, bool ll = false)
	{
		pos = p;
		role = r;
		landLocked = ll;
	}
}

class TerrainInfo {
	bool present;
	float minHeight;
	float maxHeight;
	float tidalStrength;
	bool waterMap;

	TerrainInfo()
	{
		present = false;
		minHeight = 0.f;
		maxHeight = 256.f;
		tidalStrength = 0.f;
		waterMap = false;
	}

	TerrainInfo(float minH, float maxH, float tidal, bool water)
	{
		present = true;
		minHeight = minH;
		maxHeight = maxH;
		tidalStrength = tidal;
		waterMap = water;
	}
}

class Profile {
	string mapNameMatch;
	array<StartSpot> spots;
	TerrainInfo terrain;

	Profile()
	{
		mapNameMatch = "";
	}

	Profile(const string& in mapMatch, const array<StartSpot>& in startSpots)
	{
		mapNameMatch = mapMatch;
		spots = startSpots;
	}

	Profile(const string& in mapMatch, const array<StartSpot>& in startSpots, const TerrainInfo& in terrainInfo)
	{
		mapNameMatch = mapMatch;
		spots = startSpots;
		terrain = terrainInfo;
	}

	bool CheckMatch(const string& in mapName) const
	{
		if (mapNameMatch.length() == 0)
			return false;
		return mapName.findFirst(mapNameMatch) == 0;
	}
}

}  // namespace TeamMapProfileTypes
