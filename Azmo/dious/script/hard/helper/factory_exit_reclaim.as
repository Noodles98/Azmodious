#include "../../unit.as"
#include "../../task.as"

namespace FactoryExitReclaim {

array<Id> factoryIds;
array<Id> blockerIds;
array<Id> pendingBlockerIds;
array<int> pendingBlockerFrames;

const int FACTORY_EXIT_RECLAIM_TIMEOUT = 45 * SECOND;
const float FACTORY_EXIT_FRONT_OFFSET = 80.f;
const float FACTORY_EXIT_DEPTH = 18.f;
const float FACTORY_EXIT_HALF_WIDTH = 144.f;
const float FACTORY_EXIT_CENTER_PAD = 48.f;

bool ContainsId(const array<Id>& in ids, Id unitId)
{
	for (uint i = 0; i < ids.length(); ++i) {
		if (ids[i] == unitId)
			return true;
	}
	return false;
}

bool IsFactoryName(const string& in name)
{
	return (name == "armlab") || (name == "corlab") || (name == "leglab")
		|| (name == "armvp") || (name == "corvp") || (name == "legvp")
		|| (name == "armsy") || (name == "corsy") || (name == "legsy")
		|| (name == "armap") || (name == "corap") || (name == "legap")
		|| (name == "armalab") || (name == "coralab") || (name == "legalab")
		|| (name == "armavp") || (name == "coravp") || (name == "legavp")
		|| (name == "armasy") || (name == "corasy") || (name == "legasy")
		|| (name == "armaap") || (name == "coraap") || (name == "legaap")
		|| (name == "armshltx") || (name == "corgant") || (name == "leggant")
		|| (name == "armshltxuw") || (name == "corgantuw") || (name == "leggantuw")
		|| (name == "armamsub") || (name == "coramsub") || (name == "legamsub")
		|| (name == "armplat") || (name == "corplat") || (name == "legplat");
}

bool IsAirFactoryName(const string& in name)
{
	return (name == "armap") || (name == "corap") || (name == "legap")
		|| (name == "armaap") || (name == "coraap") || (name == "legaap");
}

bool IsExitFactoryName(const string& in name)
{
	return IsFactoryName(name) && !IsAirFactoryName(name);
}

bool IsFactory(CCircuitUnit@ unit)
{
	return (unit !is null) && (unit.circuitDef !is null) && IsExitFactoryName(unit.circuitDef.GetName());
}

bool IsEconomyStructureName(const string& in name)
{
	return (name == "armwin") || (name == "corwin") || (name == "legwin")
		|| (name == "armsolar") || (name == "corsolar") || (name == "legsolar")
		|| (name == "armadvsol") || (name == "coradvsol") || (name == "legadvsol")
		|| (name == "armfus") || (name == "corfus") || (name == "legfus")
		|| (name == "armafus") || (name == "corafus") || (name == "legafus")
		|| (name == "armmakr") || (name == "cormakr") || (name == "legeconv")
		|| (name == "armmmkr") || (name == "cormmkr") || (name == "legadveconv")
		|| (name.findFirst("mex") != -1)
		|| (name.findFirst("moho") != -1)
		|| (name.findFirst("geo") != -1)
		|| (name.findFirst("solar") != -1)
		|| (name.findFirst("advsol") != -1)
		|| (name.findFirst("fus") != -1)
		|| (name.findFirst("conv") != -1)
		|| (name.findFirst("stor") != -1)
		|| (name.findFirst("store") != -1)
		|| (name.findFirst("mkr") != -1);
}

bool IsBlockingStructure(CCircuitUnit@ unit)
{
	if (unit is null || unit.circuitDef is null)
		return false;
	if (unit.circuitDef.IsMobile())
		return false;

	const string name = unit.circuitDef.GetName();
	if (IsFactoryName(name) || IsEconomyStructureName(name))
		return false;
	return true;
}

void Track(CCircuitUnit@ unit)
{
	if (unit is null || unit.circuitDef is null)
		return;
	if (IsFactory(unit)) {
		if (!ContainsId(factoryIds, unit.id))
			factoryIds.insertLast(unit.id);
		return;
	}
	if (IsBlockingStructure(unit) && !ContainsId(blockerIds, unit.id))
		blockerIds.insertLast(unit.id);
}

void ForgetFrom(array<Id>& inout ids, Id unitId)
{
	for (int i = int(ids.length()) - 1; i >= 0; --i) {
		if (ids[uint(i)] == unitId)
			ids.removeAt(uint(i));
	}
}

void ForgetPending(Id unitId)
{
	for (int i = int(pendingBlockerIds.length()) - 1; i >= 0; --i) {
		if (pendingBlockerIds[uint(i)] == unitId) {
			pendingBlockerIds.removeAt(uint(i));
			pendingBlockerFrames.removeAt(uint(i));
		}
	}
}

void Forget(Id unitId)
{
	ForgetFrom(factoryIds, unitId);
	ForgetFrom(blockerIds, unitId);
	ForgetPending(unitId);
}

void CleanPending()
{
	for (int i = int(pendingBlockerIds.length()) - 1; i >= 0; --i) {
		const Id unitId = pendingBlockerIds[uint(i)];
		if ((ai.GetTeamUnit(unitId) is null)
				|| (ai.frame - pendingBlockerFrames[uint(i)] > FACTORY_EXIT_RECLAIM_TIMEOUT)) {
			pendingBlockerIds.removeAt(uint(i));
			pendingBlockerFrames.removeAt(uint(i));
		}
	}
}

bool IsPending(Id unitId)
{
	CleanPending();
	return ContainsId(pendingBlockerIds, unitId);
}

void MarkPending(Id unitId)
{
	pendingBlockerIds.insertLast(unitId);
	pendingBlockerFrames.insertLast(ai.frame);
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
	case Task::BuildType::REPAIR:
		return true;
	default:
		return false;
	}
}

bool IsInFactoryExit(CCircuitUnit@ factory, CCircuitUnit@ blocker)
{
	const AIFloat3 factoryPos = factory.GetPos(ai.frame);
	const AIFloat3 blockerPos = blocker.GetPos(ai.frame);
	const float dx = blockerPos.x - factoryPos.x;
	const float dz = blockerPos.z - factoryPos.z;
	float lateral = dx;
	float forward = dz;
	switch (factory.GetBuildingFacing()) {
	case 1:  // East (+X)
		lateral = dz;
		forward = dx;
		break;
	case 2:  // North (-Z)
		lateral = -dx;
		forward = -dz;
		break;
	case 3:  // West (-X)
		lateral = -dz;
		forward = -dx;
		break;
	default:  // South (+Z)
		break;
	}
	return (lateral >= -FACTORY_EXIT_HALF_WIDTH) && (lateral <= FACTORY_EXIT_HALF_WIDTH)
		&& (forward >= FACTORY_EXIT_FRONT_OFFSET - FACTORY_EXIT_CENTER_PAD)
		&& (forward <= FACTORY_EXIT_FRONT_OFFSET + FACTORY_EXIT_DEPTH + FACTORY_EXIT_CENTER_PAD);
}

bool BlocksAnyFactoryExit(CCircuitUnit@ blocker)
{
	for (int i = int(factoryIds.length()) - 1; i >= 0; --i) {
		CCircuitUnit@ factory = ai.GetTeamUnit(factoryIds[uint(i)]);
		if (factory is null) {
			factoryIds.removeAt(uint(i));
			continue;
		}
		if (IsInFactoryExit(factory, blocker))
			return true;
	}
	return false;
}

IUnitTask@ MakeTask(IUnitTask@ task)
{
	if (!IsDeferrableBuildTask(task))
		return null;

	for (int i = int(blockerIds.length()) - 1; i >= 0; --i) {
		CCircuitUnit@ blocker = ai.GetTeamUnit(blockerIds[uint(i)]);
		if (blocker is null) {
			blockerIds.removeAt(uint(i));
			continue;
		}
		if (IsPending(blocker.id) || !BlocksAnyFactoryExit(blocker))
			continue;

		IUnitTask@ reclaimTask = aiBuilderMgr.Enqueue(TaskB::Reclaim(Task::Priority::HIGH, blocker, FACTORY_EXIT_RECLAIM_TIMEOUT));
		if (reclaimTask is null)
			return null;

		MarkPending(blocker.id);
		AiLog("[Builder] reclaiming " + blocker.circuitDef.GetName() + " blocking a factory exit");
		return reclaimTask;
	}

	return null;
}

}  // namespace FactoryExitReclaim