#include "../../unit.as"
#include "../../task.as"


namespace T1FactoryReclaim {

array<Id> reclaimableFactoryIds;
array<Id> pendingFactoryReclaimIds;
array<int> pendingFactoryReclaimFrames;

const int T1_FACTORY_RECLAIM_START_FRAME = 24 * MINUTE;
const int T1_FACTORY_RECLAIM_TIMEOUT = 120 * SECOND;
const uint MIN_ADVANCED_FACTORY_COUNT = 2;
const uint KEEP_T1_FACTORY_COUNT = 0;

bool IsT1FactoryName(const string& in name)
{
	return (name == "armlab") || (name == "corlab") || (name == "leglab")
		|| (name == "armvp") || (name == "corvp") || (name == "legvp")
		|| (name == "armsy") || (name == "corsy") || (name == "legsy")
		|| (name == "armap") || (name == "corap") || (name == "legap");
}

bool IsT2FactoryName(const string& in name)
{
	return (name == "armalab") || (name == "coralab") || (name == "legalab")
		|| (name == "armavp") || (name == "coravp") || (name == "legavp")
		|| (name == "armasy") || (name == "corasy") || (name == "legasy")
		|| (name == "armaap") || (name == "coraap") || (name == "legaap");
}

bool IsT3FactoryName(const string& in name)
{
	return (name == "armshltx") || (name == "corgant") || (name == "leggant");
}

bool ContainsId(const array<Id>& in ids, Id unitId)
{
	for (uint i = 0; i < ids.length(); ++i) {
		if (ids[i] == unitId)
			return true;
	}
	return false;
}

uint CountFactories(bool advancedOnly)
{
	uint count = 0;
	for (Id defId = 1, defCount = ai.GetDefCount(); defId <= defCount; ++defId) {
		const CCircuitDef@ cdef = ai.GetCircuitDef(defId);
		if (cdef is null)
			continue;

		const string name = cdef.GetName();
		if (advancedOnly ? (IsT2FactoryName(name) || IsT3FactoryName(name)) : IsT1FactoryName(name))
			count += uint(cdef.count);
	}
	return count;
}

bool HasT3Factory()
{
	for (Id defId = 1, defCount = ai.GetDefCount(); defId <= defCount; ++defId) {
		const CCircuitDef@ cdef = ai.GetCircuitDef(defId);
		if ((cdef !is null) && IsT3FactoryName(cdef.GetName()) && (cdef.count > 0))
			return true;
	}
	return false;
}

void Track(CCircuitUnit@ unit)
{
	if (unit is null || unit.circuitDef is null)
		return;
	if (!IsT1FactoryName(unit.circuitDef.GetName()))
		return;
	if (!ContainsId(reclaimableFactoryIds, unit.id))
		reclaimableFactoryIds.insertLast(unit.id);
}

void ForgetPending(Id unitId)
{
	for (int i = int(pendingFactoryReclaimIds.length()) - 1; i >= 0; --i) {
		if (pendingFactoryReclaimIds[uint(i)] == unitId) {
			pendingFactoryReclaimIds.removeAt(uint(i));
			pendingFactoryReclaimFrames.removeAt(uint(i));
		}
	}
}

void Forget(Id unitId)
{
	for (int i = int(reclaimableFactoryIds.length()) - 1; i >= 0; --i) {
		if (reclaimableFactoryIds[uint(i)] == unitId)
			reclaimableFactoryIds.removeAt(uint(i));
	}
	ForgetPending(unitId);
}

void CleanPending()
{
	for (int i = int(pendingFactoryReclaimIds.length()) - 1; i >= 0; --i) {
		const Id unitId = pendingFactoryReclaimIds[uint(i)];
		if ((ai.GetTeamUnit(unitId) is null)
				|| (ai.frame - pendingFactoryReclaimFrames[uint(i)] > T1_FACTORY_RECLAIM_TIMEOUT)) {
			pendingFactoryReclaimIds.removeAt(uint(i));
			pendingFactoryReclaimFrames.removeAt(uint(i));
		}
	}
}

bool IsPending(Id unitId)
{
	CleanPending();
	return ContainsId(pendingFactoryReclaimIds, unitId);
}

uint CountPendingFactories()
{
	CleanPending();
	return pendingFactoryReclaimIds.length();
}

void MarkPending(Id unitId)
{
	pendingFactoryReclaimIds.insertLast(unitId);
	pendingFactoryReclaimFrames.insertLast(ai.frame);
}

bool IsDeferrableBuildTask(IUnitTask@ task)
{
	if (task is null)
		return true;
	if (task.GetType() != Task::Type::BUILDER)
		return false;
	IBuilderTask@ taskB = cast<IBuilderTask>(task);
	if (taskB is null)
		return false;

	switch (taskB.GetBuildType()) {
	case Task::BuildType::ENERGY:
	case Task::BuildType::CONVERT:
	case Task::BuildType::STORE:
	case Task::BuildType::PYLON:
	case Task::BuildType::NANO:
		return true;
	default:
		return false;
	}
}

bool CanReclaim(IUnitTask@ task)
{
	if (!IsDeferrableBuildTask(task))
		return false;
	if ((ai.frame < T1_FACTORY_RECLAIM_START_FRAME) && !HasT3Factory())
		return false;
	if (CountFactories(true) < MIN_ADVANCED_FACTORY_COUNT && !HasT3Factory())
		return false;
	return CountFactories(false) > KEEP_T1_FACTORY_COUNT + CountPendingFactories();
}

IUnitTask@ MakeTask(IUnitTask@ task)
{
	if (!CanReclaim(task))
		return null;

	for (int i = int(reclaimableFactoryIds.length()) - 1; i >= 0; --i) {
		CCircuitUnit@ factory = ai.GetTeamUnit(reclaimableFactoryIds[uint(i)]);
		if (factory is null) {
			reclaimableFactoryIds.removeAt(uint(i));
			continue;
		}
		if (IsPending(factory.id))
			continue;

		IUnitTask@ reclaimTask = aiBuilderMgr.Enqueue(TaskB::Reclaim(Task::Priority::NORMAL, factory, T1_FACTORY_RECLAIM_TIMEOUT));
		if (reclaimTask is null)
			return null;

		MarkPending(factory.id);
		AiLog("[Builder] reclaiming obsolete T1 factory " + factory.circuitDef.GetName() + " after advanced factory transition");
		return reclaimTask;
	}

	return null;
}

}  // namespace T1FactoryReclaim