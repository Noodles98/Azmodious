#include "../ally_slot.as"
#include "../command_delay.as"
#include "../resource_bonus.as"
#include "air.as"
#include "tech.as"
#include "front.as"
#include "sea.as"
#include "../lane.as"
#include "../terrain/terrain_bridge.as"
#include "../map_profile.as"


namespace TeamRole {

// Dispatcher defaults
const float PRE_FACTORY_CONVERT_EFF = 1.15f;
const float PRE_FACTORY_CONVERT_ENERGY_EFF = 10.0f;

enum Kind {
	AIR = 0,
	TECH,
	SEA,
	FRONT
}

Kind kind = Kind::AIR;
bool isLogged = false;
bool isInitialized = false;

// Role resolution and initialization
Kind Resolve()
{
	if (TeamMapProfile::HasPreferredRole()) {
		const string preferred = TeamMapProfile::GetPreferredRole();
		if (preferred == "air")
			return Kind::AIR;
		if (preferred == "tech")
			return Kind::TECH;
		if (preferred == "sea")
			return Kind::SEA;
		return Kind::FRONT;
	}

	const int slot = TeamSlot::ResolveSlot();
	if (slot < 2)
		return Kind::AIR;
	if (slot < 4)
		return Kind::TECH;
	if ((slot == 4) && TerrainBridge::IsWaterMap())
		return Kind::SEA;
	return Kind::FRONT;
}

void Init()
{
	TeamSlot::Init();
	kind = Resolve();
	TeamLane::SetAirRoleUnrestricted(kind == Kind::AIR);
	ApplyMilitaryQuota();
	isInitialized = true;
}

void Refresh()
{
	if (!isInitialized)
		return;
	kind = Resolve();
	TeamLane::SetAirRoleUnrestricted(kind == Kind::AIR);
	ApplyMilitaryQuota();
}

void ApplyMilitaryQuota()
{
	switch (kind) {
		case Kind::AIR: TeamRoleAir::ApplyMilitaryQuota(); break;
		case Kind::TECH: TeamRoleTech::ApplyMilitaryQuota(); break;
		case Kind::SEA: TeamRoleSea::ApplyMilitaryQuota(); break;
		case Kind::FRONT: TeamRoleFront::ApplyMilitaryQuota(); break;
		default: break;
	}
}

string GetName()
{
	switch (kind) {
		case Kind::AIR: return "air";
		case Kind::TECH: return "tech";
		case Kind::SEA: return "sea";
		default: return "front";
	}
}

string GetRoleSourceName()
{
	return TeamMapProfile::HasPreferredRole() ? "map_profile" : "ally_slot";
}

void EnsureLogged()
{
	Refresh();
	if (!isLogged) {
		isLogged = true;
		AiLog("Assigned team role: " + GetName()
			+ ", source: " + GetRoleSourceName()
			+ ", lane: " + TeamLane::GetName()
			+ ", laneRestriction: " + TeamLane::GetRestrictionName()
			+ ", mapRole='" + TeamMapProfile::GetPreferredRole() + "'"
			+ " (teamId=" + ai.teamId + ", leadTeamId=" + ai.GetLeadTeamId()
			+ ", skirmishAIId=" + ai.skirmishAIId + ", slot=" + TeamSlot::ResolveSlot()
			+ ", knownTeams=" + TeamSlot::GetKnownCount() + ")");
	}
}

int MakeSwitchInterval()
{
	Refresh();
	switch (kind) {
		case Kind::AIR: return TeamRoleAir::MakeSwitchInterval();
		case Kind::TECH: return TeamRoleTech::MakeSwitchInterval();
		case Kind::SEA: return TeamRoleSea::MakeSwitchInterval();
		default: return TeamRoleFront::MakeSwitchInterval();
	}
}

// Role-facing event hooks
void OnFactoryAdded(CCircuitUnit@ unit)
{
	Refresh();
	switch (kind) {
		case Kind::AIR: TeamRoleAir::OnFactoryAdded(unit); break;
		case Kind::TECH: TeamRoleTech::OnFactoryAdded(unit); break;
		case Kind::SEA: TeamRoleSea::OnFactoryAdded(unit); break;
		default: TeamRoleFront::OnFactoryAdded(unit); break;
	}
}

uint GetFactoryMinBuilderCount()
{
	Refresh();
	switch (kind) {
		case Kind::AIR: return TeamRoleAir::GetFactoryMinBuilderCount();
		case Kind::TECH: return TeamRoleTech::GetFactoryMinBuilderCount();
		case Kind::SEA: return TeamRoleSea::GetFactoryMinBuilderCount();
		case Kind::FRONT: return TeamRoleFront::GetFactoryMinBuilderCount();
		default: return 2;
	}
}

uint GetFactoryMinBuilder2Count()
{
	Refresh();
	switch (kind) {
		case Kind::AIR: return TeamRoleAir::GetFactoryMinBuilder2Count();
		case Kind::TECH: return TeamRoleTech::GetFactoryMinBuilder2Count();
		case Kind::SEA: return TeamRoleSea::GetFactoryMinBuilder2Count();
		case Kind::FRONT: return TeamRoleFront::GetFactoryMinBuilder2Count();
		default: return 1;
	}
}

uint GetBaseConstructorCount()
{
	Refresh();
	switch (kind) {
		case Kind::AIR: return 6;
		case Kind::TECH: return 4;
		case Kind::FRONT: return 2;
		default: return 2;
	}
}

void OnMilitaryUnitAdded(CCircuitUnit@ unit, Unit::UseAs usage)
{
	Refresh();
	switch (kind) {
		case Kind::AIR: TeamRoleAir::OnMilitaryUnitAdded(unit, usage); break;
		default: break;
	}
}

void OnMilitaryUnitRemoved(CCircuitUnit@ unit, Unit::UseAs usage)
{
	Refresh();
	switch (kind) {
		case Kind::AIR: TeamRoleAir::OnMilitaryUnitRemoved(unit, usage); break;
		default: break;
	}
}

void OnSlowUpdate()
{
	TeamSlot::OnSlowUpdate();
	Refresh();
	switch (kind) {
		case Kind::AIR: TeamRoleAir::OnSlowUpdate(); break;
		case Kind::TECH: TeamRoleTech::OnSlowUpdate(); break;
		case Kind::SEA: TeamRoleSea::OnSlowUpdate(); break;
		case Kind::FRONT: TeamRoleFront::OnSlowUpdate(); break;
		default: break;
	}
	ApplyEconomyBias();
}

void OnMessage(const string& in data)
{
	TeamSlot::OnMessage(data);
	Refresh();
	isLogged = false;
}

// Economy, factory, and military dispatch
void ApplyEconomyBias()
{
	if (aiFactoryMgr.GetFactoryCount() == 0) {
		aiEconomyMgr.reclConvertEff = PRE_FACTORY_CONVERT_EFF;
		aiEconomyMgr.reclEnergyEff = PRE_FACTORY_CONVERT_ENERGY_EFF;
		return;
	}

	Refresh();
	switch (kind) {
		case Kind::AIR: TeamRoleAir::ApplyEconomyBias(); break;
		case Kind::TECH: TeamRoleTech::ApplyEconomyBias(); break;
		case Kind::SEA: TeamRoleSea::ApplyEconomyBias(); break;
		case Kind::FRONT: TeamRoleFront::ApplyEconomyBias(); break;
		default: break;
	}
}

float GetEnergyStallRatioWhenMetalEmpty()
{
	Refresh();
	switch (kind) {
		case Kind::AIR: return TeamRoleAir::GetEnergyStallRatioWhenMetalEmpty();
		case Kind::TECH: return TeamRoleTech::GetEnergyStallRatioWhenMetalEmpty();
		case Kind::SEA: return TeamRoleSea::GetEnergyStallRatioWhenMetalEmpty();
		case Kind::FRONT: return TeamRoleFront::GetEnergyStallRatioWhenMetalEmpty();
		default: return 0.60f;
	}
}

float GetEnergyStallRatioDefault()
{
	Refresh();
	switch (kind) {
		case Kind::AIR: return TeamRoleAir::GetEnergyStallRatioDefault();
		case Kind::TECH: return TeamRoleTech::GetEnergyStallRatioDefault();
		case Kind::SEA: return TeamRoleSea::GetEnergyStallRatioDefault();
		case Kind::FRONT: return TeamRoleFront::GetEnergyStallRatioDefault();
		default: return 0.70f;
	}
}

float GetAssistMetalRatio()
{
	Refresh();
	switch (kind) {
		case Kind::AIR: return TeamRoleAir::GetAssistMetalRatio();
		case Kind::TECH: return TeamRoleTech::GetAssistMetalRatio();
		case Kind::SEA: return TeamRoleSea::GetAssistMetalRatio();
		case Kind::FRONT: return TeamRoleFront::GetAssistMetalRatio();
		default: return 0.20f;
	}
}

float GetFactorySwitchArmyMultiplier()
{
	Refresh();
	switch (kind) {
		case Kind::AIR: return TeamRoleAir::GetFactorySwitchArmyMultiplier();
		case Kind::TECH: return TeamRoleTech::GetFactorySwitchArmyMultiplier();
		case Kind::SEA: return TeamRoleSea::GetFactorySwitchArmyMultiplier();
		case Kind::FRONT: return TeamRoleFront::GetFactorySwitchArmyMultiplier();
		default: return 1.20f;
	}
}

float GetFactorySwitchMetalMultiplier()
{
	Refresh();
	switch (kind) {
		case Kind::AIR: return TeamRoleAir::GetFactorySwitchMetalMultiplier();
		case Kind::TECH: return TeamRoleTech::GetFactorySwitchMetalMultiplier();
		case Kind::SEA: return TeamRoleSea::GetFactorySwitchMetalMultiplier();
		case Kind::FRONT: return TeamRoleFront::GetFactorySwitchMetalMultiplier();
		default: return 1.00f;
	}
}

// Defence and frontline dispatch
bool ShouldMakeDefence()
{
	Refresh();
	switch (kind) {
		case Kind::AIR: return TeamRoleAir::ShouldMakeDefence();
		case Kind::TECH: return TeamRoleTech::ShouldMakeDefence();
		case Kind::SEA: return TeamRoleSea::ShouldMakeDefence();
		case Kind::FRONT: return TeamRoleFront::ShouldMakeDefence();
		default: return (ai.frame > 5 * MINUTE)
			|| (ResourceBonus::GetPlanningMetalIncome() > 10.f)
			|| (aiEnemyMgr.mobileThreat > 0.f);
	}
}

float GetDefenceLaneSpread()
{
	Refresh();
	switch (kind) {
		case Kind::AIR: return TeamRoleAir::GetDefenceLaneSpread();
		case Kind::TECH: return TeamRoleTech::GetDefenceLaneSpread();
		case Kind::SEA: return TeamRoleSea::GetDefenceLaneSpread();
		case Kind::FRONT: return TeamRoleFront::GetDefenceLaneSpread();
		default: return 220.f;
	}
}

uint GetFrontlineConfirmHits()
{
	Refresh();
	switch (kind) {
		case Kind::AIR: return TeamRoleAir::GetFrontlineConfirmHits();
		case Kind::TECH: return TeamRoleTech::GetFrontlineConfirmHits();
		case Kind::SEA: return TeamRoleSea::GetFrontlineConfirmHits();
		case Kind::FRONT: return TeamRoleFront::GetFrontlineConfirmHits();
		default: return 3;
	}
}

int GetFrontlineConfirmWindow()
{
	Refresh();
	switch (kind) {
		case Kind::AIR: return TeamRoleAir::GetFrontlineConfirmWindow();
		case Kind::TECH: return TeamRoleTech::GetFrontlineConfirmWindow();
		case Kind::SEA: return TeamRoleSea::GetFrontlineConfirmWindow();
		case Kind::FRONT: return TeamRoleFront::GetFrontlineConfirmWindow();
		default: return 75 * SECOND;
	}
}

int GetFrontlineAnchorExpire()
{
	Refresh();
	switch (kind) {
		case Kind::AIR: return TeamRoleAir::GetFrontlineAnchorExpire();
		case Kind::TECH: return TeamRoleTech::GetFrontlineAnchorExpire();
		case Kind::SEA: return TeamRoleSea::GetFrontlineAnchorExpire();
		case Kind::FRONT: return TeamRoleFront::GetFrontlineAnchorExpire();
		default: return 180 * SECOND;
	}
}

// Command timing and factory filtering
bool IsAllowedFactory(const string& in name)
{
	Refresh();
	array<string> allowed;
	FillAllowedFactories(allowed, GetFactorySidePrefix(name));
	for (uint i = 0; i < allowed.length(); ++i) {
		if (allowed[i] == name)
			return true;
	}
	return false;
}

bool IsCommandReady(const string& in keySuffix = "")
{
	Refresh();
	switch (kind) {
		case Kind::AIR: return TeamRoleAir::IsCommandReady(keySuffix);
		case Kind::TECH: return TeamRoleTech::IsCommandReady(keySuffix);
		case Kind::SEA: return TeamRoleSea::IsCommandReady(keySuffix);
		case Kind::FRONT: return TeamRoleFront::IsCommandReady(keySuffix);
		default: return true;
	}
}

void CommitCommandDelay(const string& in keySuffix = "", int delay = RoleCommandDelay::DEFAULT_DELAY)
{
	Refresh();
	switch (kind) {
		case Kind::AIR: TeamRoleAir::CommitCommandDelay(keySuffix, delay); break;
		case Kind::TECH: TeamRoleTech::CommitCommandDelay(keySuffix, delay); break;
		case Kind::SEA: TeamRoleSea::CommitCommandDelay(keySuffix, delay); break;
		case Kind::FRONT: TeamRoleFront::CommitCommandDelay(keySuffix, delay); break;
		default: break;
	}
}

CCircuitDef@ FilterFactory(CCircuitDef@ facDef, bool isStart)
{
	Refresh();
	if ((facDef !is null) && IsAllowedFactory(facDef.GetName()))
		return facDef;

	const string sidePrefix = (facDef !is null) ? GetFactorySidePrefix(facDef.GetName()) : DetectSidePrefix();
	array<string> allowed;
	FillAllowedFactories(allowed, sidePrefix);
	CCircuitDef@ fallback = PickFactory(allowed, isStart);
	return (fallback !is null) ? fallback : facDef;
}

void FillAllowedFactories(array<string>& out allowed, const string& in sidePrefix)
{
	Refresh();
	switch (kind) {
		case Kind::AIR: TeamRoleAir::FillAllowedFactories(allowed, sidePrefix); break;
		case Kind::TECH: TeamRoleTech::FillAllowedFactories(allowed, sidePrefix); break;
		case Kind::SEA: TeamRoleSea::FillAllowedFactories(allowed, sidePrefix); break;
		default: TeamRoleFront::FillAllowedFactories(allowed, sidePrefix); break;
	}
}

CCircuitDef@ PickFactory(const array<string>& in allowed, bool isStart)
{
	if (allowed.length() == 0)
		return null;

	if (isStart) {
		for (uint i = 0; i < allowed.length(); ++i) {
			CCircuitDef@ cdef = ai.GetCircuitDef(allowed[i]);
			if ((cdef !is null) && cdef.IsAvailable(ai.frame))
				return cdef;
		}
	} else {
		for (int i = int(allowed.length()) - 1; i >= 0; --i) {
			CCircuitDef@ cdef = ai.GetCircuitDef(allowed[i]);
			if ((cdef !is null) && cdef.IsAvailable(ai.frame))
				return cdef;
		}
	}

	return ai.GetCircuitDef(allowed[0]);
}

string DetectSidePrefix()
{
	CCircuitDef@ armLab = ai.GetCircuitDef("armlab");
	if ((armLab !is null) && armLab.IsAvailable(ai.frame))
		return "arm";
	CCircuitDef@ corLab = ai.GetCircuitDef("corlab");
	if ((corLab !is null) && corLab.IsAvailable(ai.frame))
		return "cor";
	CCircuitDef@ legLab = ai.GetCircuitDef("leglab");
	if ((legLab !is null) && legLab.IsAvailable(ai.frame))
		return "leg";
	return (ai.teamId <= ai.GetLeadTeamId()) ? "arm" : "cor";
}

string GetFactorySidePrefix(const string& in name)
{
	if (name.findFirst("arm") == 0)
		return "arm";
	if (name.findFirst("cor") == 0)
		return "cor";
	if (name.findFirst("leg") == 0)
		return "leg";
	return DetectSidePrefix();
}

}  // namespace TeamRole