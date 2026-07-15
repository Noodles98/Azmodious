#include "../../define.as"
#include "../../unit.as"
#include "../../task.as"
#include "../helper/role.as"
#include "../misc/commander.as"
#include "economy.as"


namespace Factory {

enum Attr {
	T1 = 0x0001, T2 = 0x0002, T3 = 0x0004, T4 = 0x0008
}

class SUserData {
	SUserData(int a) {
		attr = a;
	}
	SUserData() {}
	int attr = 0;
}

// Example of userData per UnitDef.
// UnitDef ID starts from 1; 0 is not valid.
array<SUserData> userData(ai.GetDefCount() + 1);

string armlab  ("armlab");
string armalab ("armalab");
string armvp   ("armvp");
string armavp  ("armavp");
string armsy   ("armsy");
string armasy  ("armasy");
string armap   ("armap");
string armaap  ("armaap");
string armshltx("armshltx");
string corlab  ("corlab");
string coralab ("coralab");
string corvp   ("corvp");
string coravp  ("coravp");
string corsy   ("corsy");
string corasy  ("corasy");
string corap   ("corap");
string coraap  ("coraap");
string corgant ("corgant");
string leglab  ("leglab");
string legalab ("legalab");
string legvp   ("legvp");
string legavp  ("legavp");
string legap   ("legap");
string legaap  ("legaap");
string leggant ("leggant");

int switchInterval = TeamRole::MakeSwitchInterval();

bool EnqueueRoleIfAvailable(const CCircuitDef@ facDef, const AIFloat3& in pos,
		Type role, Task::RecruitType recruit, Task::Priority priority, uint count)
{
	CCircuitDef@ buildDef = aiFactoryMgr.GetRoleDef(facDef, role);
	if ((buildDef is null) || !buildDef.IsAvailable(ai.frame))
		return false;

	for (uint i = 0; i < count; ++i)
		aiFactoryMgr.Enqueue(TaskS::Recruit(recruit, priority, buildDef, pos, 64.f));
	return true;
}

void EnqueueFallbackOpeners(const CCircuitDef@ facDef, const AIFloat3& in pos)
{
	bool hasBuilder = EnqueueRoleIfAvailable(facDef, pos,
		RT::BUILDER, Task::RecruitType::BUILDPOWER, Task::Priority::LOW, 1);

	bool hasCombat = EnqueueRoleIfAvailable(facDef, pos,
		RT::RAIDER, Task::RecruitType::FIREPOWER, Task::Priority::HIGH, 2)
		|| EnqueueRoleIfAvailable(facDef, pos,
			RT::SKIRM, Task::RecruitType::FIREPOWER, Task::Priority::HIGH, 2)
		|| EnqueueRoleIfAvailable(facDef, pos,
			RT::RAIDER, Task::RecruitType::FIREPOWER, Task::Priority::NORMAL, 1)
		|| EnqueueRoleIfAvailable(facDef, pos,
			RT::BOMBER, Task::RecruitType::FIREPOWER, Task::Priority::LOW, 1)
		|| EnqueueRoleIfAvailable(facDef, pos,
			RT::SCOUT, Task::RecruitType::FIREPOWER, Task::Priority::HIGH, 1);

	if (!hasBuilder && !hasCombat) {
		AiLog("Factory opener fallback failed for " + facDef.GetName());
	}
}

IUnitTask@ AiMakeTask(CCircuitUnit@ unit)
{
	return aiFactoryMgr.DefaultMakeTask(unit);
}

void AiTaskAdded(IUnitTask@ task)
{
}

void AiTaskRemoved(IUnitTask@ task, bool done)
{
}

void AiUnitAdded(CCircuitUnit@ unit, Unit::UseAs usage)
{
//	if (!factories.empty() || (this->circuit->GetBuilderManager()->GetWorkerCount() > 2)) return;
	if (usage != Unit::UseAs::FACTORY)
		return;

	TeamRole::EnsureLogged();
	TeamRole::OnFactoryAdded(unit);
	TeamRole::ApplyEconomyBias();

	const CCircuitDef@ facDef = unit.circuitDef;
	if (userData[facDef.id].attr & Attr::T3 != 0) {
		// if (ai.teamId != ai.GetLeadTeamId()) then this change affects only target selection,
		// while threatmap still counts "ignored" here units.
// 		AiLog("ignore newly created armpw, corak, armflea, armfav, corfav");
		array<string> spam = {"armpw", "corak", "armflea", "armfav", "corfav"};
		for (uint i = 0; i < spam.length(); ++i)
			ai.GetCircuitDef(spam[i]).SetIgnore(true);
	}

	const array<Opener::SO>@ opener = Opener::GetOpener(facDef);
	if (opener is null)
		return;

	const AIFloat3 pos = unit.GetPos(ai.frame);
	uint queued = 0;
	for (uint i = 0, icount = opener.length(); i < icount; ++i) {
		CCircuitDef@ buildDef = aiFactoryMgr.GetRoleDef(facDef, opener[i].role);
		if ((buildDef is null) || !buildDef.IsAvailable(ai.frame))
			continue;

		Task::Priority priority;
		Task::RecruitType recruit;
		if (opener[i].role == Unit::Role::BUILDER.type) {
			priority = Task::Priority::NORMAL;
			recruit  = Task::RecruitType::BUILDPOWER;
		} else {
			priority = Task::Priority::HIGH;
			recruit  = Task::RecruitType::FIREPOWER;
		}
		for (uint j = 0, jcount = opener[i].count; j < jcount; ++j) {
			aiFactoryMgr.Enqueue(TaskS::Recruit(recruit, priority, buildDef, pos, 64.f));
			++queued;
		}
	}

	if (queued == 0)
		EnqueueFallbackOpeners(facDef, pos);
}

void AiUnitRemoved(CCircuitUnit@ unit, Unit::UseAs usage)
{
	if (usage == Unit::UseAs::FACTORY)
		TeamRole::ApplyEconomyBias();
}

void AiLoad(IStream& istream)
{
}

void AiSave(OStream& ostream)
{
}

/*
 * New factory switch condition; switch event is also based on eco + caretakers.
 */
bool AiIsSwitchTime(int lastSwitchFrame)
{
	if (lastSwitchFrame + switchInterval <= ai.frame) {
		switchInterval = TeamRole::MakeSwitchInterval();
		return true;
	}
	return false;
}

bool AiIsSwitchAllowed(CCircuitDef@ facDef)
{
	const float armyMultiplier = TeamRole::GetFactorySwitchArmyMultiplier();
	const float metalMultiplier = TeamRole::GetFactorySwitchMetalMultiplier();
	const float metalCurrent = Economy::GetSmoothedMetalCurrent(aiEconomyMgr.metal.current);
	const bool isOK = (aiMilitaryMgr.armyCost > armyMultiplier * facDef.costM * aiFactoryMgr.GetFactoryCount())
		|| (metalCurrent > facDef.costM * metalMultiplier);
	aiFactoryMgr.isAssistRequired = Economy::isSwitchAssist = !isOK;
	return isOK;
}

CCircuitDef@ AiGetFactoryToBuild(const AIFloat3& in pos, bool isStart, bool isReset)
{
	TeamRole::EnsureLogged();

	CCircuitDef@ facDef = aiFactoryMgr.DefaultGetFactoryToBuild(pos, isStart, isReset);
	return TeamRole::FilterFactory(facDef, isStart);
}

/* --- Utils --- */

}  // namespace Factory
