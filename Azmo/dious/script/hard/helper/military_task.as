#include "../../unit.as"
#include "../../task.as"
#include "role/role.as"


namespace MilitaryTaskPolicy {

bool IsMainlineCombat(const CCircuitDef@ cdef)
{
	return cdef.IsRoleAny(Unit::Role::ASSAULT.mask)
		|| cdef.IsRoleAny(Unit::Role::RIOT.mask);
}

bool IsMeleeCombat(const CCircuitDef@ cdef)
{
	return cdef.IsAttrAny(Unit::Attr::MELEE.mask);
}

bool IsBacklineCombat(const CCircuitDef@ cdef)
{
	return cdef.IsRoleAny(Unit::Role::SKIRM.mask);
}

float GetDefendPromotePower()
{
	const string role = TeamRole::GetName();
	if (role == "tech")
		return 120.f;
	if (role == "air")
		return 80.f;
	if (role == "sea")
		return 75.f;
	return 45.f;
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
	if (cdef.IsRoleAny(Unit::Role::ARTY.mask))
		return Task::FightType::ARTY;
	if (cdef.IsRoleAny(Unit::Role::SUPPORT.mask))
		return Task::FightType::SUPPORT;
	if (IsBacklineCombat(cdef))
		return Task::FightType::ARTY;
	if (IsMeleeCombat(cdef))
		return Task::FightType::MELEE;

	const string role = TeamRole::GetName();
	if (cdef.IsRoleAny(Unit::Role::RAIDER.mask))
		return (role == "tech") ? Task::FightType::DEFEND : Task::FightType::RAID;
	if (IsMainlineCombat(cdef))
		return ((role == "tech") || (role == "air")) ? Task::FightType::DEFEND : Task::FightType::ATTACK;

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