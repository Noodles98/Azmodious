namespace TeamRoleAir {

// Role tuning constants
const uint MIN_BOMBER_SWARM = 5;
const int BOMBER_GROUP_RELEASE_INTERVAL = 10 * SECOND;
const uint MAX_ESCORTS_PER_BOMBER = 2;
const int MID_GAME_FRAME = 15 * MINUTE;
const int LATE_GAME_FRAME = 25 * MINUTE;
const int ADV_AIR_MIN_FRAME = 7 * MINUTE;
const int ADV_AIR_FORCE_FRAME = 13 * MINUTE;
const int T3_FACTORY_MIN_FRAME = 28 * MINUTE;
const float ADV_AIR_MIN_METAL_INCOME = 16.0f;
const float ADV_AIR_MIN_METAL_RATIO = 0.05f;
const float EARLY_CONVERT_EFF = 10.21f;
const float MID_CONVERT_EFF = 14.56f;
const float LATE_CONVERT_EFF = 17.50f;
const float CONVERT_ENERGY_EFF = 20.0f;

const float EARLY_ENERGY_STALL_WHEN_METAL_EMPTY = 0.63f;
const float MID_ENERGY_STALL_WHEN_METAL_EMPTY = 0.68f;
const float LATE_ENERGY_STALL_WHEN_METAL_EMPTY = 0.75f;
const float EARLY_ENERGY_STALL_DEFAULT = 0.88f;
const float MID_ENERGY_STALL_DEFAULT = 0.85f;
const float LATE_ENERGY_STALL_DEFAULT = 0.83f;
const float EARLY_ASSIST_METAL_RATIO = 0.25f;
const float MID_ASSIST_METAL_RATIO = 0.65f;
const float LATE_ASSIST_METAL_RATIO = 0.80f;
const float EARLY_FACTORY_SWITCH_ARMY_MULT = 1.20f;
const float MID_FACTORY_SWITCH_ARMY_MULT = 1.25f;
const float LATE_FACTORY_SWITCH_ARMY_MULT = 1.20f;
const float EARLY_FACTORY_SWITCH_METAL_MULT = 0.90f;
const float MID_FACTORY_SWITCH_METAL_MULT = 0.90f;
const float LATE_FACTORY_SWITCH_METAL_MULT = 0.87f;

const float EARLY_DEFENCE_THREAT_MIN = 4.0f;
const float MID_DEFENCE_THREAT_MIN = 18.0f;
const float LATE_DEFENCE_THREAT_MIN = 38.0f;
const float EARLY_DEFENCE_METAL_INCOME_MIN = 7.f;
const float MID_DEFENCE_METAL_INCOME_MIN = 16.f;
const float LATE_DEFENCE_METAL_INCOME_MIN = 50.f;
const float EARLY_DEFENCE_LANE_SPREAD = 500.0f;
const float MID_DEFENCE_LANE_SPREAD = 564.0f;
const float LATE_DEFENCE_LANE_SPREAD = 605.0f;
const uint MILITARY_SCOUT_CAP = 3;
const float MILITARY_ATTACK_THRESHOLD = 105.0f;
const float MILITARY_RAID_MIN_POWER = 55.0f;
const float MILITARY_RAID_AVG_POWER = 150.0f;
const uint FACTORY_MIN_BUILDER_COUNT = 1;
const uint EARLY_FACTORY_MIN_BUILDER2_COUNT = 1;
const uint MID_FACTORY_MIN_BUILDER2_COUNT = 3;
const uint LATE_FACTORY_MIN_BUILDER2_COUNT = 5;
const uint FRONTLINE_CONFIRM_HITS = 2;
const int FRONTLINE_CONFIRM_WINDOW = 45 * SECOND;
const int FRONTLINE_ANCHOR_EXPIRE = 180 * SECOND;
const float FIRST_ADV_AIR_MAX_BASE_DISTANCE = 825.0f;
const float FIRST_ADV_AIR_MAX_BASE_DISTANCE_SQ = FIRST_ADV_AIR_MAX_BASE_DISTANCE * FIRST_ADV_AIR_MAX_BASE_DISTANCE;

array<Id> bomberIds;
array<Id> escortIds;
uint releasedBomberGroupCount = 0;
int nextBomberGroupReleaseFrame = 0;
bool hasBasicAirFactoryAnchor = false;
AIFloat3 basicAirFactoryAnchor;
IUnitTask@ advancedAirPlacementTask = null;

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

// Economy, factory, and military policy
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
	return false;
}

uint GetScoutRushCount()
{
	return 0;
}

// Bomber swarm control
bool IsEscortFighter(const CCircuitUnit@ unit)
{
	const CCircuitDef@ cdef = unit.circuitDef;
	if (cdef.IsRoleAny(Unit::Role::BOMBER.mask))
		return false;
	return cdef.IsRoleAny(Unit::Role::AA.mask) || cdef.IsRoleAny(Unit::Role::ASSAULT.mask);
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

	const uint readyBomberGroups = bomberIds.length() / MIN_BOMBER_SWARM;
	if (releasedBomberGroupCount > readyBomberGroups)
		releasedBomberGroupCount = readyBomberGroups;

	const uint previousReleasedGroups = releasedBomberGroupCount;
	if ((readyBomberGroups > releasedBomberGroupCount) && (ai.frame >= nextBomberGroupReleaseFrame)) {
		++releasedBomberGroupCount;
		nextBomberGroupReleaseFrame = ai.frame + BOMBER_GROUP_RELEASE_INTERVAL;
	}

	const uint releasedBomberCount = releasedBomberGroupCount * MIN_BOMBER_SWARM;
	const uint escortLimit = releasedBomberCount * MAX_ESCORTS_PER_BOMBER;
	const uint activeEscorts = (escortIds.length() < escortLimit) ? escortIds.length() : escortLimit;

	for (uint i = 0; i < bomberIds.length(); ++i)
		ai.UnitControl(bomberIds[i], i < releasedBomberCount);
	for (uint i = 0; i < escortIds.length(); ++i)
		ai.UnitControl(escortIds[i], true);

	if (releasedBomberGroupCount != previousReleasedGroups) {
		AiLog("Air bomber groups released=" + releasedBomberGroupCount + "/" + readyBomberGroups
			+ " (bombers=" + bomberIds.length()
			+ ", releasedBombers=" + releasedBomberCount
			+ ", escorts=" + activeEscorts + "/" + escortIds.length()
			+ ", min=" + MIN_BOMBER_SWARM + ")");
	}
}

// Role lifecycle hooks
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
	RecomputeBomberControl();
}

// Factory selection
bool ShouldAllowAdvancedAir()
{
	if (ai.frame >= ADV_AIR_FORCE_FRAME)
		return true;

	return (ai.frame >= ADV_AIR_MIN_FRAME)
		&& (aiEconomyMgr.metal.income >= ADV_AIR_MIN_METAL_INCOME)
		&& (EconomySmooth::GetMetalRatio() >= ADV_AIR_MIN_METAL_RATIO)
		&& !aiEconomyMgr.isEnergyStalling;
}

string GetBasicFactoryName(const string& in sidePrefix)
{
	if (sidePrefix == "arm")
		return "armap";
	if (sidePrefix == "cor")
		return "corap";
	return "legap";
}

bool IsBasicFactoryName(const string& in name)
{
	return (name == "armap") || (name == "corap") || (name == "legap");
}

string GetAdvancedFactoryName(const string& in sidePrefix)
{
	if (sidePrefix == "arm")
		return "armaap";
	if (sidePrefix == "cor")
		return "coraap";
	return "legaap";
}

bool IsAdvancedFactoryName(const string& in name)
{
	return (name == "armaap") || (name == "coraap") || (name == "legaap");
}

bool HasAnyAirFactory(const string& in sidePrefix)
{
	CCircuitDef@ basicDef = ai.GetCircuitDef(GetBasicFactoryName(sidePrefix));
	CCircuitDef@ advancedDef = ai.GetCircuitDef(GetAdvancedFactoryName(sidePrefix));
	return ((basicDef !is null) && (basicDef.count > 0))
		|| ((advancedDef !is null) && (advancedDef.count > 0));
}

string GetT3FactoryName(const string& in sidePrefix)
{
	if (sidePrefix == "arm")
		return "armshltx";
	if (sidePrefix == "cor")
		return "corgant";
	return "leggant";
}

bool IsT3FactoryName(const string& in name)
{
	return (name == "armshltx") || (name == "corgant") || (name == "leggant");
}

bool ShouldAllowT3Factory(const string& in sidePrefix)
{
	if (ai.frame < T3_FACTORY_MIN_FRAME)
		return false;

	CCircuitDef@ advancedDef = ai.GetCircuitDef(GetAdvancedFactoryName(sidePrefix));
	return (advancedDef !is null) && (advancedDef.count > 0);
}

bool ShouldPreferAdvancedFactory(const string& in sidePrefix)
{
	if (!ShouldAllowAdvancedAir())
		return false;

	CCircuitDef@ basicDef = ai.GetCircuitDef(GetBasicFactoryName(sidePrefix));
	CCircuitDef@ advancedDef = ai.GetCircuitDef(GetAdvancedFactoryName(sidePrefix));
	return (basicDef !is null) && (advancedDef !is null)
		&& (basicDef.count > 0) && (advancedDef.count == 0);
}

CCircuitDef@ PickPreferredFactory(const string& in sidePrefix, CCircuitDef@ facDef, bool isStart)
{
	if (!HasAnyAirFactory(sidePrefix)) {
		CCircuitDef@ basicDef = ai.GetCircuitDef(GetBasicFactoryName(sidePrefix));
		if ((basicDef !is null) && basicDef.IsAvailable(ai.frame))
			return basicDef;
	}

	if (isStart || !ShouldPreferAdvancedFactory(sidePrefix))
		return facDef;

	CCircuitDef@ advancedDef = ai.GetCircuitDef(GetAdvancedFactoryName(sidePrefix));
	if ((advancedDef !is null) && advancedDef.IsAvailable(ai.frame))
	{
		return advancedDef;
	}

	return facDef;
}

void FillAllowedFactories(array<string>& out allowed, const string& in sidePrefix)
{
	const bool allowAdvancedAir = ShouldAllowAdvancedAir();
	const bool preferAdvancedAir = ShouldPreferAdvancedFactory(sidePrefix);
	const bool allowT3 = ShouldAllowT3Factory(sidePrefix);

	if (sidePrefix == "arm") {
		if (!preferAdvancedAir)
			allowed.insertLast("armap");
		if (allowAdvancedAir)
			allowed.insertLast("armaap");
		if (allowT3)
			allowed.insertLast("armshltx");
	} else if (sidePrefix == "cor") {
		if (!preferAdvancedAir)
			allowed.insertLast("corap");
		if (allowAdvancedAir)
			allowed.insertLast("coraap");
		if (allowT3)
			allowed.insertLast("corgant");
	} else {
		if (!preferAdvancedAir)
			allowed.insertLast("legap");
		if (allowAdvancedAir)
			allowed.insertLast("legaap");
		if (allowT3)
			allowed.insertLast("leggant");
	}
}

bool ShouldRejectFactoryPosition(const CCircuitDef@ facDef, const AIFloat3& in pos, bool isStart)
{
	if (isStart || facDef is null || !hasBasicAirFactoryAnchor)
		return false;
	if (!IsAdvancedFactoryName(facDef.GetName()) || facDef.count > 0)
		return false;

	const float dx = pos.x - basicAirFactoryAnchor.x;
	const float dz = pos.z - basicAirFactoryAnchor.z;
	if ((dx * dx + dz * dz) <= FIRST_ADV_AIR_MAX_BASE_DISTANCE_SQ)
		return false;

	AiLog("[Air] rejecting first T2 air factory forward position at (" + int(pos.x) + "," + int(pos.z)
		+ "), anchor=(" + int(basicAirFactoryAnchor.x) + "," + int(basicAirFactoryAnchor.z) + ")");
	return true;
}

IUnitTask@ RequestAdvancedFactoryNearAnchor(CCircuitDef@ facDef)
{
	if (facDef is null || !hasBasicAirFactoryAnchor)
		return null;
	if (advancedAirPlacementTask !is null)
		return advancedAirPlacementTask;

	@advancedAirPlacementTask = aiBuilderMgr.Enqueue(TaskB::Factory(
		Task::Priority::HIGH, facDef, basicAirFactoryAnchor, null,
		FIRST_ADV_AIR_MAX_BASE_DISTANCE));
	if (advancedAirPlacementTask !is null) {
		AiLog("[Air] requested replacement T2 air factory position near anchor=("
			+ int(basicAirFactoryAnchor.x) + "," + int(basicAirFactoryAnchor.z) + ")");
	}
	return advancedAirPlacementTask;
}

void OnBuilderTaskRemoved(IUnitTask@ task)
{
	if (task is advancedAirPlacementTask)
		@advancedAirPlacementTask = null;
}

int MakeSwitchInterval()
{
	return AiRandom(520, 600) * SECOND;
}

void OnFactoryAdded(CCircuitUnit@ unit)
{
	if (unit is null || unit.circuitDef is null)
		return;
	if (IsAdvancedFactoryName(unit.circuitDef.GetName()))
		@advancedAirPlacementTask = null;
	if (!hasBasicAirFactoryAnchor && IsBasicFactoryName(unit.circuitDef.GetName())) {
		basicAirFactoryAnchor = unit.GetPos(ai.frame);
		hasBasicAirFactoryAnchor = true;
	}
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

}  // namespace TeamRoleAir
