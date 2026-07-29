#include "../../unit.as"
#include "../../task.as"


namespace CommanderMexTravel {

const float PRE_FACTORY_MAX_TRAVEL_SECONDS = 10.f;
const float COMMANDER_TRAVEL_DISTANCE_PER_SECOND = 80.f;

bool ShouldReject(IUnitTask@ task, CCircuitUnit@ unit)
{
	if (task is null || unit is null)
		return false;
	if (aiFactoryMgr.GetFactoryCount() > 0)
		return false;
	if (!unit.circuitDef.IsRoleAny(Unit::Role::COMM.mask))
		return false;
	if (task.GetType() != Task::Type::BUILDER || cast<IBuilderTask>(task).GetBuildType() != Task::BuildType::MEX)
		return false;

	const AIFloat3 unitPos = unit.GetPos(ai.frame);
	const AIFloat3 buildPos = cast<IBuilderTask>(task).GetBuildPos();
	const float dx = buildPos.x - unitPos.x;
	const float dz = buildPos.z - unitPos.z;
	const float maxDistance = PRE_FACTORY_MAX_TRAVEL_SECONDS * COMMANDER_TRAVEL_DISTANCE_PER_SECOND;
	return (dx * dx + dz * dz) > (maxDistance * maxDistance);
}

}  // namespace CommanderMexTravel
