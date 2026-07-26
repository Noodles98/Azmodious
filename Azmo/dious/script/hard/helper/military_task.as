#include "../../unit.as"
#include "../../task.as"
#include "role/role.as"


namespace MilitaryTaskPolicy {

bool IsMainlineCombat(const CCircuitDef@ cdef)
{
	return cdef.IsRoleAny(Unit::Role::ASSAULT.mask)	
		|| cdef.IsRoleAny(Unit::Role::RIOT.mask)
		|| cdef.IsRoleAny(Unit::Role::RAIDER.mask)
		|| cdef.IsRoleAny(Unit::Role::AH.mask);
}

bool IsMeleeCombat(const CCircuitDef@ cdef)
{
	return cdef.IsAttrAny(Unit::Attr::MELEE.mask)
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
		|| cdef.IsRoleAny(Unit::Role::AA.mask)
		;
}
bool IsAirDefenceCombat(const CCircuitDef@ cdef)
{
	return cdef.IsRoleAny(Unit::Role::ASSAULT.mask)
		|| cdef.IsRoleAny(Unit::Role::HEAVY.mask)
		|| cdef.IsRoleAny(Unit::Role::SKIRM.mask);
}

float GetDefendPromotePower()
{
	const string role = TeamRole::GetName();
	if (role == "tech")
		return 100.f;
	if (role == "air")
		return 80.f;
	if (role == "front")
		return 60.f;
	return 50.f;
}

Task::FightType GetPreferredFightType(const CCircuitDef@ cdef)
{
	if (cdef is null)
		return Task::FightType::_SIZE_;

	if (cdef.IsRoleAny(Unit::Role::SCOUT.mask))
		return Task::FightType::SCOUT;
	if (cdef.IsRoleAny(Unit::Role::BOMBER.mask))
		return Task::FightType::BOMB;
	if (cdef.IsRoleAny(Unit::Role::ASSAULT.mask))
		return Task::FightType::ATTACK;
	if (cdef.IsRoleAny(Unit::Role::RIOT.mask))
		return Task::FightType::ATTACK;
	if (cdef.IsRoleAny(Unit::Role::SKIRM.mask))
		return Task::FightType::ATTACK;
	if (cdef.IsRoleAny(Unit::Role::HEAVY.mask))
		return Task::FightType::ATTACK;
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
		return ((role == "tech") || (role == "front")) ? Task::FightType::DEFEND : Task::FightType::ATTACK;
	if (IsMeleeCombat(cdef))
		return ((role == "tech") || (role == "front")) ? Task::FightType::RAID : Task::FightType::ATTACK;
	if (IsBacklineCombat(cdef))
		return ((role == "tech") || (role == "front")) ? Task::FightType::ARTY : Task::FightType::ATTACK;
	if (IsSupportCombat(cdef))
		return ((role == "tech") || (role == "front")) || (role == "air") ? Task::FightType::SUPPORT : Task::FightType::SUPPORT;
	if (IsAirCombat(cdef))
		return (role == "air") ? Task::FightType::ATTACK : Task::FightType::BOMB;
	if (IsAirDefenceCombat(cdef))
		return (role == "air") ? Task::FightType::ATTACK : Task::FightType::AA;
	return Task::FightType::_SIZE_;
}

bool HasPreferredTask(const CCircuitDef@ cdef)
{
	return GetPreferredFightType(cdef) != Task::FightType::_SIZE_;
}

SFightTask MakePreferredTask(const CCircuitDef@ cdef)
{
	const Task::FightType fightType = GetPreferredFightType(cdef);
	if (fightType == Task::FightType::DEFEND)
		return TaskF::Defend(Task::FightType::ATTACK, GetDefendPromotePower());
	return TaskF::Common(fightType);
}

}  // namespace MilitaryTaskPolicy