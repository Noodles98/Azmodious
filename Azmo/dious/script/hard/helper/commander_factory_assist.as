#include "../../unit.as"
#include "../../task.as"


namespace CommanderFactoryAssist {

const int ASSIST_RECHECK_FRAMES = 5 * SECOND;

Id factoryId = -1;
Id constructorDefId = -1;

void Clear()
{
	factoryId = -1;
	constructorDefId = -1;
}

void Track(CCircuitUnit@ factory, CCircuitDef@ constructorDef)
{
	if ((factory is null) || (constructorDef is null) || (constructorDef.count != 0))
		return;

	factoryId = factory.id;
	constructorDefId = constructorDef.id;
}

void ForgetFactory(Id unitId)
{
	if (unitId == factoryId)
		Clear();
}

void OnUnitFinished(CCircuitUnit@ unit)
{
	if ((unit !is null) && (unit.circuitDef.id == constructorDefId))
		Clear();
}

IUnitTask@ MakeTask(CCircuitUnit@ unit)
{
	if ((unit is null) || !unit.circuitDef.IsRoleAny(Unit::Role::COMM.mask))
		return null;
	if ((factoryId < 0) || (constructorDefId < 0))
		return null;

	CCircuitUnit@ factory = ai.GetTeamUnit(factoryId);
	if (factory is null) {
		Clear();
		return null;
	}

	return aiBuilderMgr.Enqueue(TaskB::Guard(
		Task::Priority::NOW, factory, false, ASSIST_RECHECK_FRAMES));
}

}  // namespace CommanderFactoryAssist