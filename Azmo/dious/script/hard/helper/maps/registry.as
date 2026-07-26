#include "types.as"

namespace TeamMapProfileRegistry {

array<TeamMapProfileTypes::Profile@> profiles;

float SqDist(const AIFloat3& in a, const AIFloat3& in b)
{
	const float dx = a.x - b.x;
	const float dz = a.z - b.z;
	return dx * dx + dz * dz;
}

void Register(TeamMapProfileTypes::Profile@ profile)
{
	if (profile is null)
		return;
	profiles.insertLast(profile);
}

TeamMapProfileTypes::Profile@ Find(const string& in mapName)
{
	for (uint i = 0; i < profiles.length(); ++i) {
		TeamMapProfileTypes::Profile@ profile = profiles[i];
		if ((profile !is null) && profile.CheckMatch(mapName))
			return profile;
	}
	return null;
}

int FindNearestSpotIndex(const AIFloat3& in startPos, const array<TeamMapProfileTypes::StartSpot>& in spots)
{
	float best = 1e30f;
	int bestIdx = -1;
	for (uint i = 0; i < spots.length(); ++i) {
		const float d = SqDist(startPos, spots[i].pos);
		if (d < best) {
			best = d;
			bestIdx = int(i);
		}
	}
	return bestIdx;
}

}  // namespace TeamMapProfileRegistry
