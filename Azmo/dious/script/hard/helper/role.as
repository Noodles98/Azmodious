#include "ally_slot.as"
#include "command_delay.as"
#include "air.as"
#include "tech.as"
#include "front.as"
#include "lane.as"


namespace TeamRole {

const float PRE_FACTORY_CONVERT_EFF = 0.60f;
const float PRE_FACTORY_CONVERT_ENERGY_EFF = 4.f;

enum Kind {
	AIR = 0,
	TECH,
	FRONT
}

Kind kind = Kind::AIR;
bool isLogged = false;
bool isInitialized = false;

Kind Resolve()
{
	const int slot = TeamSlot::ResolveSlot();
	if (slot < 2)
		return Kind::AIR;
	if (slot < 4)
		return Kind::TECH;
	return Kind::FRONT;
}

void Init()
{
	TeamSlot::Init();
	kind = Resolve();
	isInitialized = true;
}

void Refresh()
{
	if (!isInitialized)
		return;
	kind = Resolve();
}

string GetName()
{
	switch (kind) {
		case Kind::AIR: return "air";
		case Kind::TECH: return "tech";
		default: return "front";
	}
}

void EnsureLogged()
{
	Refresh();
	if (!isLogged) {
		isLogged = true;
		AiLog("Assigned team role: " + GetName()
			+ ", lane: " + TeamLane::GetName()
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
		default: return TeamRoleFront::MakeSwitchInterval();
	}
}

void OnFactoryAdded(CCircuitUnit@ unit)
{
	Refresh();
	switch (kind) {
		case Kind::AIR: TeamRoleAir::OnFactoryAdded(unit); break;
		case Kind::TECH: TeamRoleTech::OnFactoryAdded(unit); break;
		default: TeamRoleFront::OnFactoryAdded(unit); break;
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
		case Kind::FRONT: return TeamRoleFront::GetFactorySwitchMetalMultiplier();
		default: return 1.00f;
	}
}

bool ShouldMakeDefence()
{
	Refresh();
	switch (kind) {
		case Kind::AIR: return TeamRoleAir::ShouldMakeDefence();
		case Kind::TECH: return TeamRoleTech::ShouldMakeDefence();
		case Kind::FRONT: return TeamRoleFront::ShouldMakeDefence();
		default: return (ai.frame > 5 * MINUTE)
			|| (aiEconomyMgr.metal.income > 10.f)
			|| (aiEnemyMgr.mobileThreat > 0.f);
	}
}

float GetDefenceLaneSpread()
{
	Refresh();
	switch (kind) {
		case Kind::AIR: return TeamRoleAir::GetDefenceLaneSpread();
		case Kind::TECH: return TeamRoleTech::GetDefenceLaneSpread();
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
		case Kind::FRONT: return TeamRoleFront::GetFrontlineAnchorExpire();
		default: return 180 * SECOND;
	}
}

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