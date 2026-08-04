#include "../../unit.as"
#include "../../task.as"


namespace EnergySpaceReclaim {

array<Id> reclaimableEnergyIds;
array<Id> pendingEnergyReclaimIds;
array<int> pendingEnergyReclaimFrames;

const int ENERGY_SPACE_RECLAIM_START_FRAME = 18 * MINUTE;
const int ADVANCED_SOLAR_SPACE_RECLAIM_START_FRAME = 25 * MINUTE;
const int ENERGY_SPACE_RECLAIM_TIMEOUT = 90 * SECOND;
const float ENERGY_SPACE_RECLAIM_RADIUS = 128.f;

void Clear()
{
	reclaimableEnergyIds.resize(0);
	pendingEnergyReclaimIds.resize(0);
	pendingEnergyReclaimFrames.resize(0);
}

bool IsT1SpaceEnergy(const string& in name)
{
	return (name == "armwin") || (name == "corwin") || (name == "legwin")
		|| (name == "armsolar") || (name == "corsolar") || (name == "legsolar")
		|| (name == "armmakr") || (name == "cormakr") || (name == "legeconv");
}

bool IsAdvancedSolar(const string& in name)
{
	return (name == "armadvsol") || (name == "coradvsol")
		|| (name == "legadvsol") || (name == "legadvsolar");
}

bool IsReclaimableEnergy(const string& in name)
{
	return IsT1SpaceEnergy(name) || IsAdvancedSolar(name);
}

bool ContainsId(const array<Id>& in ids, Id unitId)
{
	for (uint i = 0; i < ids.length(); ++i) {
		if (ids[i] == unitId)
			return true;
	}
	return false;
}

void Track(CCircuitUnit@ unit)
{
	if (unit is null || unit.circuitDef is null)
		return;
	if (!IsReclaimableEnergy(unit.circuitDef.GetName()))
		return;
	if (!ContainsId(reclaimableEnergyIds, unit.id))
		reclaimableEnergyIds.insertLast(unit.id);
}

void ForgetPending(Id unitId)
{
	for (int i = int(pendingEnergyReclaimIds.length()) - 1; i >= 0; --i) {
		if (pendingEnergyReclaimIds[uint(i)] == unitId) {
			pendingEnergyReclaimIds.removeAt(uint(i));
			pendingEnergyReclaimFrames.removeAt(uint(i));
		}
	}
}

void Forget(Id unitId)
{
	for (int i = int(reclaimableEnergyIds.length()) - 1; i >= 0; --i) {
		if (reclaimableEnergyIds[uint(i)] == unitId)
			reclaimableEnergyIds.removeAt(uint(i));
	}
	ForgetPending(unitId);
}

void CleanPending()
{
	for (int i = int(pendingEnergyReclaimIds.length()) - 1; i >= 0; --i) {
		const Id unitId = pendingEnergyReclaimIds[uint(i)];
		if ((ai.GetTeamUnit(unitId) is null)
				|| (ai.frame - pendingEnergyReclaimFrames[uint(i)] > ENERGY_SPACE_RECLAIM_TIMEOUT)) {
			pendingEnergyReclaimIds.removeAt(uint(i));
			pendingEnergyReclaimFrames.removeAt(uint(i));
		}
	}
}

bool IsPending(Id unitId)
{
	CleanPending();
	return ContainsId(pendingEnergyReclaimIds, unitId);
}

void MarkPending(Id unitId)
{
	pendingEnergyReclaimIds.insertLast(unitId);
	pendingEnergyReclaimFrames.insertLast(ai.frame);
}

bool IsSpaceHungryBuild(int buildType)
{
	switch (buildType) {
	case Task::BuildType::FACTORY:
	case Task::BuildType::NANO:
	case Task::BuildType::PYLON:
	case Task::BuildType::ENERGY:
	case Task::BuildType::DEFENCE:
	case Task::BuildType::BUNKER:
	case Task::BuildType::BIG_GUN:
	case Task::BuildType::CONVERT:
		return true;
	default:
		return false;
	}
}

bool ShouldReclaimAdvancedSolar(IUnitTask@ task)
{
	if (task is null || ai.frame < ADVANCED_SOLAR_SPACE_RECLAIM_START_FRAME)
		return false;
	return task.GetBuildType() == Task::BuildType::ENERGY;
}

bool CanReclaim(IUnitTask@ task)
{
	if (task is null || task.GetType() != Task::Type::BUILDER)
		return false;
	if (ai.frame < ENERGY_SPACE_RECLAIM_START_FRAME)
		return false;
	if (aiEconomyMgr.isEnergyEmpty || aiEconomyMgr.isEnergyStalling)
		return false;
	return IsSpaceHungryBuild(task.GetBuildType());
}

IUnitTask@ MakeReclaimTask(IUnitTask@ task, bool reclaimAdvancedSolar)
{
	const AIFloat3 buildPos = task.GetBuildPos();
	const float radiusSq = ENERGY_SPACE_RECLAIM_RADIUS * ENERGY_SPACE_RECLAIM_RADIUS;
	for (int i = int(reclaimableEnergyIds.length()) - 1; i >= 0; --i) {
		CCircuitUnit@ energy = ai.GetTeamUnit(reclaimableEnergyIds[uint(i)]);
		if (energy is null) {
			reclaimableEnergyIds.removeAt(uint(i));
			continue;
		}
		if (IsPending(energy.id))
			continue;

		const string energyName = energy.circuitDef.GetName();
		if (IsAdvancedSolar(energyName) != reclaimAdvancedSolar)
			continue;

		const AIFloat3 energyPos = energy.GetPos(ai.frame);
		const float dx = buildPos.x - energyPos.x;
		const float dz = buildPos.z - energyPos.z;
		if ((dx * dx + dz * dz) > radiusSq)
			continue;

		IUnitTask@ reclaimTask = aiBuilderMgr.Enqueue(TaskB::Reclaim(Task::Priority::HIGH, energy, ENERGY_SPACE_RECLAIM_TIMEOUT));
		if (reclaimTask is null)
			return null;

		MarkPending(energy.id);
		AiLog("[Builder] reclaiming " + energyName + " to clear late-game base space");
		return reclaimTask;
	}

	return null;
}

IUnitTask@ MakeTask(IUnitTask@ task)
{
	if (!CanReclaim(task))
		return null;

	IUnitTask@ reclaimTask = MakeReclaimTask(task, false);
	if (reclaimTask !is null)
		return reclaimTask;

	if (ShouldReclaimAdvancedSolar(task))
		return MakeReclaimTask(task, true);
	return null;
}

}  // namespace EnergySpaceReclaim