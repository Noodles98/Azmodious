namespace TeamRoleSea {

// Role tuning constants
const string CONTROL_KEY = "sea_role_control";
const int MID_GAME_FRAME = 11 * MINUTE;
const int LATE_GAME_FRAME = 19 * MINUTE;
const float EARLY_CONVERT_EFF = 2.0f;
const float MID_CONVERT_EFF = 3.3f;
const float LATE_CONVERT_EFF = 5.3f;
const float EARLY_CONVERT_ENERGY_EFF = 20.1f;
const float MID_CONVERT_ENERGY_EFF = 22.1f;
const float LATE_CONVERT_ENERGY_EFF = 24.4f;

const float EARLY_ENERGY_STALL_WHEN_METAL_EMPTY = 0.70f;
const float MID_ENERGY_STALL_WHEN_METAL_EMPTY = 0.74f;
const float LATE_ENERGY_STALL_WHEN_METAL_EMPTY = 0.78f;
const float EARLY_ENERGY_STALL_DEFAULT = 0.72f;
const float MID_ENERGY_STALL_DEFAULT = 0.84f;
const float LATE_ENERGY_STALL_DEFAULT = 0.88f;
const float EARLY_ASSIST_METAL_RATIO = 0.20f;
const float MID_ASSIST_METAL_RATIO = 0.31f;
const float LATE_ASSIST_METAL_RATIO = 0.35f;
const float EARLY_FACTORY_SWITCH_ARMY_MULT = 1.15f;
const float MID_FACTORY_SWITCH_ARMY_MULT = 1.35f;
const float LATE_FACTORY_SWITCH_ARMY_MULT = 1.55f;
const float EARLY_FACTORY_SWITCH_METAL_MULT = 0.80f;
const float MID_FACTORY_SWITCH_METAL_MULT = 0.86f;
const float LATE_FACTORY_SWITCH_METAL_MULT = 0.90f;

const float EARLY_DEFENCE_THREAT_MIN = 14.5f;
const float MID_DEFENCE_THREAT_MIN = 48.0f;
const float LATE_DEFENCE_THREAT_MIN = 86.0f;
const float EARLY_DEFENCE_METAL_INCOME_MIN = 11.f;
const float MID_DEFENCE_METAL_INCOME_MIN = 15.f;
const float LATE_DEFENCE_METAL_INCOME_MIN = 20.f;
const float EARLY_DEFENCE_LANE_SPREAD = 170.f;
const float MID_DEFENCE_LANE_SPREAD = 160.f;
const float LATE_DEFENCE_LANE_SPREAD = 150.f;
const uint MILITARY_SCOUT_CAP = 3;
const float MILITARY_ATTACK_THRESHOLD = 65.f;
const float MILITARY_RAID_MIN_POWER = 20.f;
const float MILITARY_RAID_AVG_POWER = 75.f;
const uint FACTORY_MIN_BUILDER_COUNT = 2;
const uint FACTORY_MIN_BUILDER2_COUNT = 1;
const uint FRONTLINE_CONFIRM_HITS = 8;
const int FRONTLINE_CONFIRM_WINDOW = 60 * SECOND;
const int FRONTLINE_ANCHOR_EXPIRE = 120 * SECOND;

// Economy stage helpers
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

// Factory selection and lifecycle hooks
void FillAllowedFactories(array<string>& out allowed, const string& in sidePrefix)
{
	if (sidePrefix == "arm") {
		allowed.insertLast("armsy");
		allowed.insertLast("armasy");
	} else {
		allowed.insertLast("corsy");
		allowed.insertLast("corasy");
	}
}

int MakeSwitchInterval()
{
	return AiRandom(560, 760) * SECOND;
}

void OnFactoryAdded(CCircuitUnit@ unit)
{
}

void OnSlowUpdate()
{
}

// Economy and military policy
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

void ApplyMilitaryQuota()
{
	aiMilitaryMgr.quota.scout = MILITARY_SCOUT_CAP;
	aiMilitaryMgr.quota.attack = MILITARY_ATTACK_THRESHOLD;
	aiMilitaryMgr.quota.raid.min = MILITARY_RAID_MIN_POWER;
	aiMilitaryMgr.quota.raid.avg = MILITARY_RAID_AVG_POWER;
}

uint GetFactoryMinBuilderCount()
{
	return FACTORY_MIN_BUILDER_COUNT;
}

uint GetFactoryMinBuilder2Count()
{
	return FACTORY_MIN_BUILDER2_COUNT;
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

// Defence and frontline shaping
bool ShouldMakeDefence()
{
	switch (GetEconomyStage()) {
		case EconomyStage::EARLY:
			return (aiEnemyMgr.mobileThreat > EARLY_DEFENCE_THREAT_MIN)
				|| (ResourceBonus::GetPlanningMetalIncome() > EARLY_DEFENCE_METAL_INCOME_MIN);
		case EconomyStage::MID:
			return (aiEnemyMgr.mobileThreat > MID_DEFENCE_THREAT_MIN)
				|| (ResourceBonus::GetPlanningMetalIncome() > MID_DEFENCE_METAL_INCOME_MIN);
		default:
			return (aiEnemyMgr.mobileThreat > LATE_DEFENCE_THREAT_MIN)
				|| (ResourceBonus::GetPlanningMetalIncome() > LATE_DEFENCE_METAL_INCOME_MIN);
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

// Command timing
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

}  // namespace TeamRoleSea
