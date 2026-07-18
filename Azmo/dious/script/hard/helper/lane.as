#include "ally_slot.as"


namespace TeamLane {

const int LANE_COUNT = 4;
bool isAirRoleUnrestricted = true;

int ResolveSlot()
{
	return TeamSlot::ResolveSlot();
}

int ResolveLane()
{
	return ResolveSlot() % LANE_COUNT;
}

int ResolveBiasLane(const AIFloat3& in pos, float spread)
{
	const float cellSize = (spread > 0.f) ? (spread * 2.f) : 512.f;
	const int cellX = int(pos.x / cellSize);
	const int cellZ = int(pos.z / cellSize);
	int lane = (cellX * 31) + (cellZ * 17) + ai.teamId;
	if (lane < 0)
		lane = -lane;
	return lane % LANE_COUNT;
}

bool IsRestricted()
{
	// Restriction is tied to resolved role.
	return !isAirRoleUnrestricted;
}

bool IsAirRoleUnrestricted()
{
	return isAirRoleUnrestricted;
}

string GetRestrictionName()
{
	return IsRestricted() ? "biased" : "unrestricted";
}

void SetAirRoleUnrestricted(bool isUnrestricted)
{
	isAirRoleUnrestricted = isUnrestricted;
}

string GetName()
{
	switch (ResolveLane()) {
		case 0: return "outer-left";
		case 1: return "inner-left";
		case 2: return "inner-right";
		default: return "outer-right";
	}
}

float GetOffset(float spread)
{
	switch (ResolveLane()) {
		case 0: return -1.5f * spread;
		case 1: return -0.5f * spread;
		case 2: return 0.5f * spread;
		default: return 1.5f * spread;
	}
}

AIFloat3 BiasPosition(const AIFloat3& in pos, float spread)
{
	if (!IsRestricted())
		return pos;

	AIFloat3 lanePos = pos;
	switch (ResolveBiasLane(pos, spread)) {
		case 0: lanePos.x += -1.5f * spread; break;
		case 1: lanePos.x += -0.5f * spread; break;
		case 2: lanePos.x += 0.5f * spread; break;
		default: lanePos.x += 1.5f * spread; break;
	}
	return lanePos;
}

AIFloat3 BiasMovePosition(const AIFloat3& in pos, float spread)
{
	if (!IsRestricted())
		return pos;

	AIFloat3 lanePos = pos;
	switch (ResolveBiasLane(pos, spread)) {
		case 0: lanePos.x += -0.45f * spread; break;
		case 1: lanePos.x += -0.15f * spread; break;
		case 2: lanePos.x += 0.15f * spread; break;
		default: lanePos.x += 0.45f * spread; break;
	}
	return lanePos;
}

}  // namespace TeamLane
