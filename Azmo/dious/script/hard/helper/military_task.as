#include "../../unit.as"
#include "../../task.as"
#include "role/role.as"
#include "frontline_cluster.as"


namespace MilitaryTaskPolicy {

const int FOG_PUSH_START_FRAME = 1 * MINUTE;
const uint FOG_PUSH_UNIT_STRIDE = 3;

bool IsMainlineCombat(const CCircuitDef@ cdef)
{
	return cdef.IsRoleAny(Unit::Role::ASSAULT.mask)	
		|| cdef.IsRoleAny(Unit::Role::RIOT.mask)
		|| cdef.IsRoleAny(Unit::Role::RAIDER.mask)
		|| cdef.IsRoleAny(Unit::Role::HEAVY.mask)
		|| cdef.IsRoleAny(Unit::Role::AH.mask);
}

bool IsMeleeCombat(const CCircuitDef@ cdef)
{
	return cdef.IsAttrAny(Unit::Attr::MELEE.mask)
		|| cdef.IsRoleAny(Unit::Role::SUPER.mask);
}

bool IsScout(const CCircuitDef@ cdef)
{
	return cdef.IsRoleAny(Unit::Role::SCOUT.mask);
}

bool IsDefenceCombat (const CCircuitDef@ cdef)
{
	return cdef.IsRoleAny(Unit::Role::ASSAULT.mask)
		|| cdef.IsRoleAny(Unit::Role::RAIDER.mask);
}

bool IsBacklineCombat(const CCircuitDef@ cdef)
{
	return cdef.IsRoleAny(Unit::Role::SKIRM.mask)
		|| cdef.IsRoleAny(Unit::Role::ARTY.mask);
}

bool IsSupportCombat(const CCircuitDef@ cdef)
{
	return cdef.IsRoleAny(Unit::Role::SUPPORT.mask);
}
bool IsAirCombat(const CCircuitDef@ cdef)
{
	return cdef.IsRoleAny(Unit::Role::BOMBER.mask)
		|| cdef.IsRoleAny(Unit::Role::ASSAULT.mask)
		|| cdef.IsRoleAny(Unit::Role::SKIRM.mask)
		|| cdef.IsRoleAny(Unit::Role::HEAVY.mask)
		|| cdef.IsRoleAny(Unit::Role::SUPER.mask)
		|| cdef.IsRoleAny(Unit::Role::AA.mask)
		;
}
bool IsAirDefenceCombat(const CCircuitDef@ cdef)
{
	return cdef.IsRoleAny(Unit::Role::ASSAULT.mask)
		|| cdef.IsRoleAny(Unit::Role::HEAVY.mask);
}

float GetDefendPromotePower()
{
	const string role = TeamRole::GetName();
	if (role == "tech")
		return 120.f;
	if (role == "air")
		return 150.f;
	if (role == "front")
		return 70.f;
	return 50.f;
}

bool IsFogPushCombat(const CCircuitDef@ cdef)
{
	return cdef.IsRoleAny(Unit::Role::RAIDER.mask)
		|| cdef.IsRoleAny(Unit::Role::RIOT.mask)
		|| cdef.IsRoleAny(Unit::Role::ASSAULT.mask);
}

bool ShouldFogPush(CCircuitUnit@ unit, const CCircuitDef@ cdef)
{
	if (unit is null || cdef is null)
		return false;
	if (ai.frame < FOG_PUSH_START_FRAME)
		return false;
	if (TeamRole::GetName() == "air")
		return false;
	if (FrontlineCluster::HasStableAnchor())
		return false;
	if (!IsFogPushCombat(cdef))
		return false;
	return (uint(unit.id) % FOG_PUSH_UNIT_STRIDE) == 0;
}

Task::FightType GetPreferredFightType(const CCircuitDef@ cdef)
{
	if (cdef is null)
		return Task::FightType::_SIZE_;

	if (cdef.IsRoleAny(Unit::Role::SCOUT.mask))
		return Task::FightType::SCOUT;
	if (cdef.IsRoleAny(Unit::Role::BOMBER.mask))
		return Task::FightType::BOMB;
	if (cdef.IsRoleAny(Unit::Role::SUPER.mask))
		return Task::FightType::SUPER;
	if (cdef.IsRoleAny(Unit::Role::AA.mask))
		return Task::FightType::AA;
	if (cdef.IsRoleAny(Unit::Role::AH.mask))
		return Task::FightType::AH;
	if (cdef.IsRoleAny(Unit::Role::RAIDER.mask))
		return Task::FightType::RAID;
	if (cdef.IsRoleAny(Unit::Role::ARTY.mask))
		return Task::FightType::ARTY;
	if (cdef.IsRoleAny(Unit::Role::SUPPORT.mask))
		return Task::FightType::SUPPORT;

	const string role = TeamRole::GetName();
	if (IsMainlineCombat(cdef))
		return ((role == "tech") || (role == "front")) ? Task::FightType::ATTACK : Task::FightType::ATTACK;
	if (IsMeleeCombat(cdef))
		return ((role == "tech") || (role == "front")) ? Task::FightType::RAID : Task::FightType::ATTACK;
	if (IsScout(cdef))
		return ((role == "front") || (role == "tech") || (role == "air")) ? Task::FightType::SCOUT : Task::FightType::SCOUT;
	if (IsBacklineCombat(cdef))
		return ((role == "tech") || (role == "front")) ? Task::FightType::ARTY : Task::FightType::ATTACK;
	if (IsDefenceCombat(cdef))
		return ((role == "tech") || (role == "front")) ? Task::FightType::DEFEND : Task::FightType::ATTACK;
	if (IsSupportCombat(cdef))
		return ((role == "tech") || (role == "front")) || (role == "air") ? Task::FightType::SUPPORT : Task::FightType::SUPPORT;
	if (IsAirCombat(cdef))
		return (role == "air") ? Task::FightType::ATTACK : Task::FightType::BOMB;
	if (IsAirDefenceCombat(cdef))
		return (role == "air") ? Task::FightType::ATTACK : Task::FightType::DEFEND;
	return Task::FightType::_SIZE_;
}

bool HasPreferredTask(const CCircuitDef@ cdef)
{
	return GetPreferredFightType(cdef) != Task::FightType::_SIZE_;
}

SFightTask MakePreferredTask(CCircuitUnit@ unit, const CCircuitDef@ cdef)
{
	if (ShouldFogPush(unit, cdef))
		return TaskF::Common(Task::FightType::SCOUT);

	const Task::FightType fightType = GetPreferredFightType(cdef);
	if (fightType == Task::FightType::DEFEND)
		return TaskF::Defend(Task::FightType::ATTACK, GetDefendPromotePower());
	return TaskF::Common(fightType);
}

}  // namespace MilitaryTaskPolicy