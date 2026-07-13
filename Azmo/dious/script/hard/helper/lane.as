#include "ally_slot.as"


namespace TeamLane {

const int LANE_COUNT = 4;

int ResolveSlot()
{
	return TeamSlot::ResolveSlot();
}

int ResolveLane()
{
	return ResolveSlot() % LANE_COUNT;
}

bool IsRestricted()
{
	// Team role mapping reserves slots 0-1 for AIR; those should stay flexible.
	return ResolveSlot() >= 2;
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
	lanePos.x += GetOffset(spread);
	return lanePos;
}

}  // namespace TeamLane
