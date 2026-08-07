#include "../../define.as"
#include "../helper/military_task.as"
#include "../helper/defense.as"


namespace Military {

IUnitTask@ MakeRoleTask(CCircuitUnit@ unit)
{
	if (unit is null)
		return null;

	const CCircuitDef@ cdef = unit.circuitDef;
	if (cdef is null || !MilitaryTaskPolicy::HasPreferredTask(cdef))
		return null;

	if ((TeamRole::GetName() != "air")
			&& (aiEnemyMgr.mobileThreat > 0.f)
			&& MilitaryTaskPolicy::IsMainlineCombat(cdef)) {
		FrontlineCluster::ObservePressure(unit.GetPos(ai.frame));
	}

	return aiMilitaryMgr.Enqueue(MilitaryTaskPolicy::MakePreferredTask(unit, cdef));
}

IUnitTask@ AiMakeTask(CCircuitUnit@ unit)
{
	IUnitTask@ task = MakeRoleTask(unit);
	if (task !is null)
		return task;

	return aiMilitaryMgr.DefaultMakeTask(unit);
}

void AiTaskAdded(IUnitTask@ task)
{
}

void AiTaskRemoved(IUnitTask@ task, bool done)
{
}

void AiUnitAdded(CCircuitUnit@ unit, Unit::UseAs usage)
{
	TeamRole::OnMilitaryUnitAdded(unit, usage);
}

void AiUnitRemoved(CCircuitUnit@ unit, Unit::UseAs usage)
{
	TeamRole::OnMilitaryUnitRemoved(unit, usage);
}

void AiLoad(IStream& istream)
{
}

void AiSave(OStream& ostream)
{
}

void AiMakeDefence(int cluster, const AIFloat3& in pos)
{
	const string side = TeamRole::DetectSidePrefix();
	if (!TeamRole::ShouldMakeDefence() && !DefenseHelpers::ShouldMakeAnyDefence(side))
		return;

	AIFloat3 lanePos = FrontlineCluster::UpdateAndGetPos(pos, TeamRole::GetDefenceLaneSpread());
	aiMilitaryMgr.DefaultMakeDefence(cluster, lanePos);
}

}  // namespace Military
