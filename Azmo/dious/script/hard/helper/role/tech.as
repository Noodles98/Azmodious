namespace TeamRoleTech {

// Role tuning constants
const int MID_GAME_FRAME = 14 * MINUTE;
const int LATE_GAME_FRAME = 24 * MINUTE;
const float EARLY_CONVERT_EFF = 12.22f;
const float MID_CONVERT_EFF = 14.73f;
const float LATE_CONVERT_EFF = 17.25f;
const float CONVERT_ENERGY_EFF = 20.0f;

const float EARLY_ENERGY_STALL_WHEN_METAL_EMPTY = 0.88f;
const float MID_ENERGY_STALL_WHEN_METAL_EMPTY = 0.85f;
const float LATE_ENERGY_STALL_WHEN_METAL_EMPTY = 0.81f;
const float EARLY_ENERGY_STALL_DEFAULT = 0.82f;
const float MID_ENERGY_STALL_DEFAULT = 0.84f;
const float LATE_ENERGY_STALL_DEFAULT = 0.92f;
const float EARLY_ASSIST_METAL_RATIO = 0.15f;
const float MID_ASSIST_METAL_RATIO = 0.25f;
const float LATE_ASSIST_METAL_RATIO = 0.45f;
const float EARLY_FACTORY_SWITCH_ARMY_MULT = 1.20f;
const float MID_FACTORY_SWITCH_ARMY_MULT = 1.25f;
const float LATE_FACTORY_SWITCH_ARMY_MULT = 1.25f;
const float EARLY_FACTORY_SWITCH_METAL_MULT = 0.90f;
const float MID_FACTORY_SWITCH_METAL_MULT = 0.90f;
const float LATE_FACTORY_SWITCH_METAL_MULT = 0.87f;

const float EARLY_DEFENCE_THREAT_MIN = 4.0f;
const float MID_DEFENCE_THREAT_MIN = 18.0f;
const float LATE_DEFENCE_THREAT_MIN = 38.0f;
const float EARLY_DEFENCE_METAL_INCOME_MIN = 11.0f;
const float MID_DEFENCE_METAL_INCOME_MIN = 15.0f;
const float LATE_DEFENCE_METAL_INCOME_MIN = 20.0f;
const float EARLY_DEFENCE_LANE_SPREAD = 475.0f;
const float MID_DEFENCE_LANE_SPREAD = 525.0f;
const float LATE_DEFENCE_LANE_SPREAD = 580.0f;
const uint MILITARY_SCOUT_CAP = 3;
const float MILITARY_ATTACK_THRESHOLD = 190.0f;
const float MILITARY_RAID_MIN_POWER = 25.0f;
const float MILITARY_RAID_AVG_POWER = 85.0f;
const uint FACTORY_MIN_BUILDER_COUNT = 2;
const uint EARLY_FACTORY_MIN_BUILDER2_COUNT = 0;
const uint MID_FACTORY_MIN_BUILDER2_COUNT = 1;
const uint LATE_FACTORY_MIN_BUILDER2_COUNT = 3;
const uint SCOUT_RUSH_COUNT = 10;
const uint FRONTLINE_CONFIRM_HITS = 2;
const int FRONTLINE_CONFIRM_WINDOW = 60 * SECOND;
const int FRONTLINE_ANCHOR_EXPIRE = 240 * SECOND;

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

// Economy, factory, and military policy
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
			aiEconomyMgr.reclEnergyEff = CONVERT_ENERGY_EFF;
			break;
		case EconomyStage::MID:
			aiEconomyMgr.reclConvertEff = MID_CONVERT_EFF;
			aiEconomyMgr.reclEnergyEff = CONVERT_ENERGY_EFF;
			break;
		default:
			aiEconomyMgr.reclConvertEff = LATE_CONVERT_EFF;
			aiEconomyMgr.reclEnergyEff = CONVERT_ENERGY_EFF;
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
	switch (GetEconomyStage()) {
		case EconomyStage::EARLY: return EARLY_FACTORY_MIN_BUILDER2_COUNT;
		case EconomyStage::MID: return MID_FACTORY_MIN_BUILDER2_COUNT;
		default: return LATE_FACTORY_MIN_BUILDER2_COUNT;
	}
}

bool IsScoutRushEnabled()
{
	return true;
}

uint GetScoutRushCount()
{
	return SCOUT_RUSH_COUNT;
}

void FillAllowedFactories(array<string>& out allowed, const string& in sidePrefix)
{
	if (sidePrefix == "arm") {
		allowed.insertLast("armvp");
		allowed.insertLast("armavp");
		allowed.insertLast("armshltx");
	} else if (sidePrefix == "cor") {
		allowed.insertLast("corvp");
		allowed.insertLast("coravp");
		allowed.insertLast("corgant");
	} else {
		allowed.insertLast("legvp");
		allowed.insertLast("legavp");
		allowed.insertLast("leggant");
	}
}

int MakeSwitchInterval()
{
	return AiRandom(520, 720) * SECOND;
}

void OnFactoryAdded(CCircuitUnit@ unit)
{
}

void OnSlowUpdate()
{
}

// Defence and frontline shaping
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

}  // namespace TeamRoleTech
