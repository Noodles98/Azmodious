#include "../../unit.as"
#include "../../task.as"


namespace CommanderMexTravel {

const float PRE_FACTORY_MAX_TRAVEL_SECONDS = 10.f;
const float COMMANDER_TRAVEL_DISTANCE_PER_SECOND = 80.f;
const int MAX_REJECT_FRAMES = 5 * SECOND;

int rejectedCommanderId = -1;
int firstRejectFrame = -1;

void ClearRejectedMex()
{
	rejectedCommanderId = -1;
	firstRejectFrame = -1;
}

bool ShouldKeepRejecting(CCircuitUnit@ unit)
{
	if (unit.id != rejectedCommanderId) {
		rejectedCommanderId = unit.id;
		firstRejectFrame = ai.frame;
		return true;
	}

	if (ai.frame - firstRejectFrame < MAX_REJECT_FRAMES)
		return true;

	AiLog("[CommanderMexTravel] allowing distant pre-factory mex after repeated rejection");
	ClearRejectedMex();
	return false;
}

bool ShouldReject(IUnitTask@ task, CCircuitUnit@ unit)
{
	if (task is null || unit is null) {
		ClearRejectedMex();
		return false;
	}
	if (aiFactoryMgr.GetFactoryCount() > 0) {
		ClearRejectedMex();
		return false;
	}
	if (!unit.circuitDef.IsRoleAny(Unit::Role::COMM.mask))
		return false;
	if (task.GetType() != Task::Type::BUILDER || task.GetBuildType() != Task::BuildType::MEX) {
		ClearRejectedMex();
		return false;
	}

	const AIFloat3 unitPos = unit.GetPos(ai.frame);
	const AIFloat3 buildPos = task.GetBuildPos();
	const float dx = buildPos.x - unitPos.x;
	const float dz = buildPos.z - unitPos.z;
	const float maxDistance = PRE_FACTORY_MAX_TRAVEL_SECONDS * COMMANDER_TRAVEL_DISTANCE_PER_SECOND;
	if ((dx * dx + dz * dz) <= (maxDistance * maxDistance)) {
		ClearRejectedMex();
		return false;
	}

	return ShouldKeepRejecting(unit);
}

}  // namespace CommanderMexTravel
