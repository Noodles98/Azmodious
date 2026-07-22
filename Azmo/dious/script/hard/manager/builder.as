#include "../helper/legion_mex_upgrade.as"
#include "../helper/role/role.as"


namespace Builder {

array<Id> baseBuilderIds;

// AIFloat3 lastPos;
// int gPauseCnt = 0;

void AiTaskAssigned(CCircuitUnit@ unit)
{
// 	if (unit.task.GetType() == Task::Type::BUILDER)
// 		AiLog("build-task for "unit.circuitDef.GetName() + "let's, buildType=" + unit.task.GetBuildType());
// 	else
// 		AiLog("Not a build-task for " + unit.circuitDef.GetName() + ", type=" + unit.task.GetType());
}

IUnitTask@ AiMakeTask(CCircuitUnit@ unit)
{
// 	AiDelPoint(lastPos);
// 	lastPos = unit.GetPos(ai.frame);
// 	AiAddPoint(lastPos, "task");

// 	IUnitTask@ task = aiBuilderMgr.DefaultMakeTask(unit);
// 	if ((task !is null) && (task.GetType() == Task::Type::BUILDER)) {
// 		switch (task.GetBuildType()) {
// 		case Task::BuildType::MEX:
// 			AiAddPoint(task.GetBuildPos(), task.GetBuildDef().GetName());
// 			break;
// 		case Task::BuildType::DEFENCE:
// 			AiAddPoint(task.GetBuildPos(), task.GetBuildDef().GetName());
// 			break;
// 		default:
// 			break;
// 		}
// 	}
//  return task;
	IUnitTask@ task = aiBuilderMgr.DefaultMakeTask(unit);
	if (LegionMexUpgradeFilter::ShouldReject(task)) {
		AIFloat3 buildPos = task.GetBuildPos();
		AiLog("[MexUp] rejected cross-faction Legion mex upgrade at (" + int(buildPos.x) + "," + int(buildPos.z) + ")");
		return null;
	}
	return task;
}

void AiTaskAdded(IUnitTask@ task)
{
// 	if (task.GetType() != Task::Type::BUILDER)
// 		return;
// 	switch (task.GetBuildType()) {
// 	case Task::BuildType::ENERGY: {
// 		if (gPauseCnt == 0) {
// 			string name = task.GetBuildDef().GetName();
// 			if ((name == "armfus") || (name == "armafus") || (name == "corfus") || (name == "corafus")) {
// 				AiPause(true, "energy");
// 				++gPauseCnt;
// 			}
// 			AiAddPoint(task.GetBuildPos(), name);
// 		}
// 	} break;
// 	case Task::BuildType::FACTORY:
// 	case Task::BuildType::NANO:
// 	case Task::BuildType::STORE:
// 	case Task::BuildType::PYLON:
// 	case Task::BuildType::GEO:
// 	case Task::BuildType::GEOUP:
// 	case Task::BuildType::DEFENCE:
// 	case Task::BuildType::BUNKER:
// 	case Task::BuildType::BIG_GUN:
// 	case Task::BuildType::RADAR:
// 	case Task::BuildType::SONAR:
// 	case Task::BuildType::CONVERT:
// 	case Task::BuildType::MEX:
// 	case Task::BuildType::MEXUP:
// 		AiAddPoint(task.GetBuildPos(), task.GetBuildDef().GetName());
// 		break;
// 	case Task::BuildType::REPAIR:
// 		AiAddPoint(task.GetBuildPos(), "rep");
// 		break;
// 	case Task::BuildType::RECLAIM:
// 		AiAddPoint(task.GetBuildPos(), "rec");
// 		break;
// 	case Task::BuildType::RESURRECT:
// 		AiAddPoint(task.GetBuildPos(), "res");
// 		break;
// 	case Task::BuildType::TERRAFORM:
// 		AiAddPoint(task.GetBuildPos(), "ter");
// 		break;
// 	default:
// 		break;
// 	}
}

void AiTaskRemoved(IUnitTask@ task, bool done)
{
// 	if (task.GetType() != Task::Type::BUILDER)
// 		return;
// 	switch (task.GetBuildType()) {
// 	case Task::BuildType::FACTORY:
// 	case Task::BuildType::NANO:
// 	case Task::BuildType::STORE:
// 	case Task::BuildType::PYLON:
// 	case Task::BuildType::ENERGY:
// 	case Task::BuildType::GEO:
// 	case Task::BuildType::GEOUP:
// 	case Task::BuildType::DEFENCE:
// 	case Task::BuildType::BUNKER:
// 	case Task::BuildType::BIG_GUN:
// 	case Task::BuildType::RADAR:
// 	case Task::BuildType::SONAR:
// 	case Task::BuildType::CONVERT:
// 	case Task::BuildType::MEX:
// 	case Task::BuildType::MEXUP:
// 	case Task::BuildType::REPAIR:
// 	case Task::BuildType::RECLAIM:
// 	case Task::BuildType::RESURRECT:
// 	case Task::BuildType::TERRAFORM:
// 		AiDelPoint(task.GetBuildPos());
// 		break;
// 	default:
// 		break;
// 	}
}

void AiUnitAdded(CCircuitUnit@ unit, Unit::UseAs usage)
{
	const CCircuitDef@ cdef = unit.circuitDef;
	if (usage != Unit::UseAs::BUILDER || cdef.IsRoleAny(Unit::Role::COMM.mask))
		return;

	AssignBaseConstructor(unit);
}

void OnMessage(const string& in data)
{
}

void AiUnitFinished(CCircuitUnit@ unit)
{
	LegionMexUpgradeFilter::OnUnitFinished(unit);
}

void AiUnitDestroyed(CCircuitUnit@ unit)
{
	LegionMexUpgradeFilter::OnUnitDestroyed(unit);
}

void AiUnitRemoved(CCircuitUnit@ unit, Unit::UseAs usage)
{
	RemoveBaseConstructor(unit.id);
}

void AiLoad(IStream& istream)
{
	baseBuilderIds.resize(0);
	for (uint i = 0; i < 6; ++i) {
		Id unitId = -1;
		istream >> unitId;
		CCircuitUnit@ unit = ai.GetTeamUnit(unitId);
		if (unit !is null) {
			baseBuilderIds.insertLast(unitId);
			unit.AddAttribute(Unit::Attr::BASE.type);
		}
	}
}

void AiSave(OStream& ostream)
{
	CleanBaseConstructors();
	for (uint i = 0; i < 6; ++i) {
		ostream << Id((i < baseBuilderIds.length()) ? baseBuilderIds[i] : -1);
	}
}

bool ContainsBaseConstructor(Id unitId)
{
	for (uint i = 0; i < baseBuilderIds.length(); ++i) {
		if (baseBuilderIds[i] == unitId)
			return true;
	}
	return false;
}

void RemoveBaseConstructor(Id unitId)
{
	for (uint i = 0; i < baseBuilderIds.length(); ++i) {
		if (baseBuilderIds[i] == unitId) {
			baseBuilderIds.removeAt(i);
			return;
		}
	}
}

void CleanBaseConstructors()
{
	for (int i = int(baseBuilderIds.length()) - 1; i >= 0; --i) {
		if (ai.GetTeamUnit(baseBuilderIds[i]) is null)
			baseBuilderIds.removeAt(uint(i));
	}
}

bool IsBaseConstructorCandidate(const CCircuitDef@ cdef)
{
	if (cdef.costM >= 200.f)
		return true;
	return (uint(cdef.count) > aiMilitaryMgr.GetGuardTaskNum()) || cdef.IsAbleToFly();
}

void AssignBaseConstructor(CCircuitUnit@ unit)
{
	CleanBaseConstructors();
	const uint target = TeamRole::GetBaseConstructorCount();
	if (baseBuilderIds.length() >= target || ContainsBaseConstructor(unit.id))
		return;

	if (!IsBaseConstructorCandidate(unit.circuitDef))
		return;

	baseBuilderIds.insertLast(unit.id);
	unit.AddAttribute(Unit::Attr::BASE.type);
}

}  // namespace Builder
