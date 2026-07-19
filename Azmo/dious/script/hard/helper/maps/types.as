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

class Profile {
	string mapNameMatch;
	array<StartSpot> spots;

	Profile()
	{
		mapNameMatch = "";
	}

	Profile(const string& in mapMatch, const array<StartSpot>& in startSpots)
	{
		mapNameMatch = mapMatch;
		spots = startSpots;
	}

	bool CheckMatch(const string& in mapName) const
	{
		if (mapNameMatch.length() == 0)
			return false;
		return mapName.findFirst(mapNameMatch) == 0;
	}
}

}  // namespace TeamMapProfileTypes
