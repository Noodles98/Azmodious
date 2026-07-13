namespace TeamRoleAir {

const uint MIN_BOMBER_SWARM = 3;
const string CONTROL_KEY = "air_bomber_control";
const int MID_GAME_FRAME = 12 * MINUTE;
const int LATE_GAME_FRAME = 24 * MINUTE;
const float EARLY_CONVERT_EFF = 1.50f;
const float MID_CONVERT_EFF = 2.70f;
const float LATE_CONVERT_EFF = 2.90f;
const float EARLY_CONVERT_ENERGY_EFF = 24.f;
const float MID_CONVERT_ENERGY_EFF = 27.f;
const float LATE_CONVERT_ENERGY_EFF = 30.f;

const float EARLY_ENERGY_STALL_WHEN_METAL_EMPTY = 0.70f;
const float MID_ENERGY_STALL_WHEN_METAL_EMPTY = 0.73f;
const float LATE_ENERGY_STALL_WHEN_METAL_EMPTY = 0.76f;
const float EARLY_ENERGY_STALL_DEFAULT = 0.80f;
const float MID_ENERGY_STALL_DEFAULT = 0.83f;
const float LATE_ENERGY_STALL_DEFAULT = 0.86f;
const float EARLY_ASSIST_METAL_RATIO = 0.28f;
const float MID_ASSIST_METAL_RATIO = 0.31f;
const float LATE_ASSIST_METAL_RATIO = 0.34f;
const float EARLY_FACTORY_SWITCH_ARMY_MULT = 0.92f;
const float MID_FACTORY_SWITCH_ARMY_MULT = 0.98f;
const float LATE_FACTORY_SWITCH_ARMY_MULT = 1.06f;
const float EARLY_FACTORY_SWITCH_METAL_MULT = 0.84f;
const float MID_FACTORY_SWITCH_METAL_MULT = 0.90f;
const float LATE_FACTORY_SWITCH_METAL_MULT = 0.98f;

const float EARLY_DEFENCE_THREAT_MIN = 0.8f;
const float MID_DEFENCE_THREAT_MIN = 0.5f;
const float LATE_DEFENCE_THREAT_MIN = 0.2f;
const float EARLY_DEFENCE_METAL_INCOME_MIN = 9.f;
const float MID_DEFENCE_METAL_INCOME_MIN = 12.f;
const float LATE_DEFENCE_METAL_INCOME_MIN = 16.f;
const float EARLY_DEFENCE_LANE_SPREAD = 160.f;
const float MID_DEFENCE_LANE_SPREAD = 150.f;
const float LATE_DEFENCE_LANE_SPREAD = 140.f;
const uint FRONTLINE_CONFIRM_HITS = 5;
const int FRONTLINE_CONFIRM_WINDOW = 120 * SECOND;
const int FRONTLINE_ANCHOR_EXPIRE = 270 * SECOND;

array<Id> bomberIds;
array<Id> escortIds;
bool isBomberReleased = true;

enum EconomyStage {
	EARLY = 0,
	MID,
	LATE
}

EconomyStage GetEconomyStage()
{
	if (ai.frame >= LATE_GAME_FRAME)
		return EconomyStage::LATE;
	if (ai.frame >= MID_GAME_FRAME)
		return EconomyStage::MID;
	return EconomyStage::EARLY;
}

float GetEnergyStallRatioWhenMetalEmpty()
{
	switch (GetEconomyStage()) {
		case EconomyStage::EARLY: return EARLY_ENERGY_STALL_WHEN_METAL_EMPTY;
		case EconomyStage::MID: return MID_ENERGY_STALL_WHEN_METAL_EMPTY;
		default: return LATE_ENERGY_STALL_WHEN_METAL_EMPTY;
	}
}

float GetEnergyStallRatioDefault()
{
	switch (GetEconomyStage()) {
		case EconomyStage::EARLY: return EARLY_ENERGY_STALL_DEFAULT;
		case EconomyStage::MID: return MID_ENERGY_STALL_DEFAULT;
		default: return LATE_ENERGY_STALL_DEFAULT;
	}
}

float GetAssistMetalRatio()
{
	switch (GetEconomyStage()) {
		case EconomyStage::EARLY: return EARLY_ASSIST_METAL_RATIO;
		case EconomyStage::MID: return MID_ASSIST_METAL_RATIO;
		default: return LATE_ASSIST_METAL_RATIO;
	}
}

float GetFactorySwitchArmyMultiplier()
{
	switch (GetEconomyStage()) {
		case EconomyStage::EARLY: return EARLY_FACTORY_SWITCH_ARMY_MULT;
		case EconomyStage::MID: return MID_FACTORY_SWITCH_ARMY_MULT;
		default: return LATE_FACTORY_SWITCH_ARMY_MULT;
	}
}

float GetFactorySwitchMetalMultiplier()
{
	switch (GetEconomyStage()) {
		case EconomyStage::EARLY: return EARLY_FACTORY_SWITCH_METAL_MULT;
		case EconomyStage::MID: return MID_FACTORY_SWITCH_METAL_MULT;
		default: return LATE_FACTORY_SWITCH_METAL_MULT;
	}
}

void ApplyEconomyBias()
{
	switch (GetEconomyStage()) {
		case EconomyStage::EARLY:
			aiEconomyMgr.reclConvertEff = EARLY_CONVERT_EFF;
			aiEconomyMgr.reclEnergyEff = EARLY_CONVERT_ENERGY_EFF;
			break;
		case EconomyStage::MID:
			aiEconomyMgr.reclConvertEff = MID_CONVERT_EFF;
			aiEconomyMgr.reclEnergyEff = MID_CONVERT_ENERGY_EFF;
			break;
		default:
			aiEconomyMgr.reclConvertEff = LATE_CONVERT_EFF;
			aiEconomyMgr.reclEnergyEff = LATE_CONVERT_ENERGY_EFF;
			break;
	}
}
bool IsEscortFighter(const CCircuitUnit@ unit)
{
	const CCircuitDef@ cdef = unit.circuitDef;
	if (!cdef.IsAbleToFly())
		return false;
	if (cdef.IsRoleAny(Unit::Role::BOMBER.mask))
		return false;
	return cdef.IsRoleAny(Unit::Role::AA.mask);
}

void RefreshAlive(array<Id>& inout ids)
{
	array<Id> alive;
	alive.reserve(ids.length());
	for (uint i = 0; i < ids.length(); ++i) {
		CCircuitUnit@ unit = ai.GetTeamUnit(ids[i]);
		if (unit !is null)
			alive.insertLast(ids[i]);
	}
	ids = alive;
}

bool ContainsId(const array<Id>& in ids, Id unitId)
{
	for (uint i = 0; i < ids.length(); ++i) {
		if (ids[i] == unitId)
			return true;
	}
	return false;
}

void RemoveId(array<Id>& inout ids, Id unitId)
{
	for (uint i = 0; i < ids.length(); ++i) {
		if (ids[i] == unitId) {
			ids.removeAt(i);
			return;
		}
	}
}

void RecomputeBomberControl()
{
	RefreshAlive(bomberIds);
	RefreshAlive(escortIds);

	const bool isRelease = bomberIds.length() >= MIN_BOMBER_SWARM;
	if (!RoleCommandDelay::IsReady(CONTROL_KEY)) {
		return;
	}

	for (uint i = 0; i < bomberIds.length(); ++i)
		ai.UnitControl(bomberIds[i], isRelease);
	for (uint i = 0; i < escortIds.length(); ++i)
		ai.UnitControl(escortIds[i], isRelease);
	RoleCommandDelay::Commit(CONTROL_KEY);

	if (isRelease != isBomberReleased) {
		isBomberReleased = isRelease;
		AiLog("Air bomber hold " + (isRelease ? "released" : "active")
			+ " (bombers=" + bomberIds.length()
			+ ", escorts=" + escortIds.length()
			+ ", min=" + MIN_BOMBER_SWARM + ")");
	}
}

void OnMilitaryUnitAdded(CCircuitUnit@ unit, Unit::UseAs usage)
{
	if (usage != Unit::UseAs::COMBAT)
		return;

	if (unit.circuitDef.IsRoleAny(Unit::Role::BOMBER.mask)) {
		if (!ContainsId(bomberIds, unit.id))
			bomberIds.insertLast(unit.id);
		RecomputeBomberControl();
		return;
	}

	if (IsEscortFighter(unit)) {
		if (!ContainsId(escortIds, unit.id))
			escortIds.insertLast(unit.id);
		RecomputeBomberControl();
	}
}

void OnMilitaryUnitRemoved(CCircuitUnit@ unit, Unit::UseAs usage)
{
	if (usage != Unit::UseAs::COMBAT)
		return;

	if (unit.circuitDef.IsRoleAny(Unit::Role::BOMBER.mask)) {
		RemoveId(bomberIds, unit.id);
		RecomputeBomberControl();
		return;
	}

	if (IsEscortFighter(unit)) {
		RemoveId(escortIds, unit.id);
		RecomputeBomberControl();
	}
}

void OnSlowUpdate()
{
	if (RoleCommandDelay::HasReadyPending(CONTROL_KEY))
		RecomputeBomberControl();
}

bool IsCommandReady(const string& in keySuffix = "")
{
	const string key = (keySuffix.length() == 0) ? CONTROL_KEY : CONTROL_KEY + "_" + keySuffix;
	return RoleCommandDelay::IsReady(key);
}

void CommitCommandDelay(const string& in keySuffix = "", int delay = RoleCommandDelay::DEFAULT_DELAY)
{
	const string key = (keySuffix.length() == 0) ? CONTROL_KEY : CONTROL_KEY + "_" + keySuffix;
	RoleCommandDelay::Commit(key, delay);
}

void FillAllowedFactories(array<string>& out allowed, bool isArmada)
{
	if (isArmada) {
		allowed.insertLast("armap");
		allowed.insertLast("armaap");
	} else {
		allowed.insertLast("corap");
		allowed.insertLast("coraap");
	}
}

int MakeSwitchInterval()
{
	return AiRandom(420, 680) * SECOND;
}

void OnFactoryAdded(CCircuitUnit@ unit)
{
}

bool ShouldMakeDefence()
{
	switch (GetEconomyStage()) {
		case EconomyStage::EARLY:
			return (aiEnemyMgr.mobileThreat > EARLY_DEFENCE_THREAT_MIN)
				|| (aiEconomyMgr.metal.income > EARLY_DEFENCE_METAL_INCOME_MIN);
		case EconomyStage::MID:
			return (aiEnemyMgr.mobileThreat > MID_DEFENCE_THREAT_MIN)
				|| (aiEconomyMgr.metal.income > MID_DEFENCE_METAL_INCOME_MIN);
		default:
			return (aiEnemyMgr.mobileThreat > LATE_DEFENCE_THREAT_MIN)
				|| (aiEconomyMgr.metal.income > LATE_DEFENCE_METAL_INCOME_MIN);
	}
}

float GetDefenceLaneSpread()
{
	switch (GetEconomyStage()) {
		case EconomyStage::EARLY: return EARLY_DEFENCE_LANE_SPREAD;
		case EconomyStage::MID: return MID_DEFENCE_LANE_SPREAD;
		default: return LATE_DEFENCE_LANE_SPREAD;
	}
}

uint GetFrontlineConfirmHits()
{
	return FRONTLINE_CONFIRM_HITS;
}

int GetFrontlineConfirmWindow()
{
	return FRONTLINE_CONFIRM_WINDOW;
}

int GetFrontlineAnchorExpire()
{
	return FRONTLINE_ANCHOR_EXPIRE;
}

}  // namespace TeamRoleAir