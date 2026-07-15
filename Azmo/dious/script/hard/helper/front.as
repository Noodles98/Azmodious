namespace TeamRoleFront {

const string CONTROL_KEY = "front_role_control";
const int MID_GAME_FRAME = 11 * MINUTE;
const int LATE_GAME_FRAME = 21 * MINUTE;
const float EARLY_CONVERT_EFF = 0.80f;
const float MID_CONVERT_EFF = 1.25f;
const float LATE_CONVERT_EFF = 2.52f;
const float EARLY_CONVERT_ENERGY_EFF = 15.0f;
const float MID_CONVERT_ENERGY_EFF = 20.0f;
const float LATE_CONVERT_ENERGY_EFF = 25.0f;

const float EARLY_ENERGY_STALL_WHEN_METAL_EMPTY = 0.53f;
const float MID_ENERGY_STALL_WHEN_METAL_EMPTY = 0.57f;
const float LATE_ENERGY_STALL_WHEN_METAL_EMPTY = 0.60f;
const float EARLY_ENERGY_STALL_DEFAULT = 0.61f;
const float MID_ENERGY_STALL_DEFAULT = 0.65f;
const float LATE_ENERGY_STALL_DEFAULT = 0.68f;
const float EARLY_ASSIST_METAL_RATIO = 0.15f;
const float MID_ASSIST_METAL_RATIO = 0.28f;
const float LATE_ASSIST_METAL_RATIO = 0.36f;
const float EARLY_FACTORY_SWITCH_ARMY_MULT = 1.25f;
const float MID_FACTORY_SWITCH_ARMY_MULT = 1.55f;
const float LATE_FACTORY_SWITCH_ARMY_MULT = 1.75f;
const float EARLY_FACTORY_SWITCH_METAL_MULT = 0.85f;
const float MID_FACTORY_SWITCH_METAL_MULT = 0.90f;
const float LATE_FACTORY_SWITCH_METAL_MULT = 0.95f;

const float EARLY_DEFENCE_THREAT_MIN = 2.5f;
const float MID_DEFENCE_THREAT_MIN = 6.0f;
const float LATE_DEFENCE_THREAT_MIN = 10.0f;
const float EARLY_DEFENCE_METAL_INCOME_MIN = 16.f;
const float MID_DEFENCE_METAL_INCOME_MIN = 22.f;
const float LATE_DEFENCE_METAL_INCOME_MIN = 28.f;
const float EARLY_DEFENCE_LANE_SPREAD = 260.f;
const float MID_DEFENCE_LANE_SPREAD = 220.f;
const float LATE_DEFENCE_LANE_SPREAD = 180.f;
const uint FRONTLINE_CONFIRM_HITS = 3;
const int FRONTLINE_CONFIRM_WINDOW = 45 * SECOND;
const int FRONTLINE_ANCHOR_EXPIRE = 75 * SECOND;

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

void FillAllowedFactories(array<string>& out allowed, const string& in sidePrefix)
{
	if (sidePrefix == "arm") {
		allowed.insertLast("armlab");
		allowed.insertLast("armalab");
	} else if (sidePrefix == "leg") {
		allowed.insertLast("leglab");
		allowed.insertLast("legalab");
	} else {
		allowed.insertLast("corlab");
		allowed.insertLast("coralab");
	}
}

int MakeSwitchInterval()
{
	return AiRandom(600, 780) * SECOND;
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

}  // namespace TeamRoleFront