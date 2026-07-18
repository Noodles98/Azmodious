#include "../../define.as"
#include "../../unit.as"
#include "../helper/role/role.as"
#include "../helper/defense.as"
#include "../helper/frontline_cluster.as"


namespace Military {

IUnitTask@ AiMakeTask(CCircuitUnit@ unit)
{
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

	const AIFloat3 lanePos = FrontlineCluster::UpdateAndGetPos(pos, TeamRole::GetDefenceLaneSpread());
	aiMilitaryMgr.DefaultMakeDefence(cluster, lanePos);
}

}  // namespace Military
