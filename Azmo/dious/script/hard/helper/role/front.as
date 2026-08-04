namespace TeamRoleFront {

// Role tuning constants
const int MID_GAME_FRAME = 11 * MINUTE;
const int LATE_GAME_FRAME = 25 * MINUTE;
const float EARLY_CONVERT_EFF = 6.51f;
const float MID_CONVERT_EFF = 9.12f;
const float LATE_CONVERT_EFF = 13.55f;
const float EARLY_CONVERT_ENERGY_EFF = 19.55f;
const float MID_CONVERT_ENERGY_EFF = 20.15f;
const float LATE_CONVERT_ENERGY_EFF = 21.21f;

const float EARLY_ENERGY_STALL_WHEN_METAL_EMPTY = 0.60f;
const float MID_ENERGY_STALL_WHEN_METAL_EMPTY = 0.62f;
const float LATE_ENERGY_STALL_WHEN_METAL_EMPTY = 0.65f;
const float EARLY_ENERGY_STALL_DEFAULT = 0.86f;
const float MID_ENERGY_STALL_DEFAULT = 0.82f;
const float LATE_ENERGY_STALL_DEFAULT = 0.78f;
const float EARLY_ASSIST_METAL_RATIO = 0.25f;
const float MID_ASSIST_METAL_RATIO = 0.45f;
const float LATE_ASSIST_METAL_RATIO = 0.85f;
const float EARLY_FACTORY_SWITCH_ARMY_MULT = 1.20f;
const float MID_FACTORY_SWITCH_ARMY_MULT = 1.25f;
const float LATE_FACTORY_SWITCH_ARMY_MULT = 1.30f;
const float EARLY_FACTORY_SWITCH_METAL_MULT = 0.90f;
const float MID_FACTORY_SWITCH_METAL_MULT = 0.90f;
const float LATE_FACTORY_SWITCH_METAL_MULT = 0.87f;

const float EARLY_DEFENCE_THREAT_MIN = 10.0f;
const float MID_DEFENCE_THREAT_MIN = 35.0f;
const float LATE_DEFENCE_THREAT_MIN = 90.0f;
const float EARLY_DEFENCE_METAL_INCOME_MIN = 8.0f;
const float MID_DEFENCE_METAL_INCOME_MIN = 22.0f;
const float LATE_DEFENCE_METAL_INCOME_MIN = 28.0f;
const float EARLY_DEFENCE_LANE_SPREAD = 350.0f;
const float MID_DEFENCE_LANE_SPREAD = 460.0f;
const float LATE_DEFENCE_LANE_SPREAD = 610.0f;
const uint MILITARY_SCOUT_CAP = 2;
const float MILITARY_ATTACK_THRESHOLD = 55.0f;
const float MILITARY_RAID_MIN_POWER = 45.0f;
const float MILITARY_RAID_AVG_POWER = 80.0f;
const uint FACTORY_MIN_BUILDER_COUNT = 1;
const uint EARLY_FACTORY_MIN_BUILDER2_COUNT = 2;
const uint MID_FACTORY_MIN_BUILDER2_COUNT = 4;
const uint LATE_FACTORY_MIN_BUILDER2_COUNT = 8;
const uint SCOUT_RUSH_COUNT = 10;
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
		allowed.insertLast("armlab");
		allowed.insertLast("armalab");
		allowed.insertLast("armshltx");
	} else if (sidePrefix == "cor") {
		allowed.insertLast("corlab");
		allowed.insertLast("coralab");
		allowed.insertLast("corgant");
	} else {
		allowed.insertLast("leglab");
		allowed.insertLast("legalab");
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

}  // namespace TeamRoleFront