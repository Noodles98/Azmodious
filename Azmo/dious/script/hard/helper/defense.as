namespace DefenseHelpers {

const int EARLY_GAME_FRAME = 1 * MINUTE;
const int MID_GAME_FRAME = 18 * MINUTE;
const int LATE_GAME_FRAME = 35 * MINUTE;

const float EARLY_PRESSURE = 10.0f;
const float MEDIUM_PRESSURE = 30.0f;
const float HEAVY_PRESSURE = 65.0f;

bool IsEarlyGame()
{
	return ai.frame >= EARLY_GAME_FRAME;
}
bool IsMidGame()
{
	return ai.frame >= MID_GAME_FRAME;
}

bool IsLateGame()
{
	return ai.frame >= LATE_GAME_FRAME;
}

float GetMetalIncome()
{
	return aiEconomyMgr.metal.income;
}

float GetMobileThreat()
{
	return aiEnemyMgr.mobileThreat;
}

bool HasPressure(float threshold)
{
	return GetMobileThreat() >= threshold;
}

bool CanAfford(float metalIncome)
{
	return GetMetalIncome() >= metalIncome;
}

bool HasFactory()
{
	return aiFactoryMgr.GetFactoryCount() > 0;
}

bool ShouldBuildT1LightAA(const string& in side)
{
	return HasFactory()
		|| (IsEarlyGame() && CanAfford(8.0f))
		|| HasPressure(EARLY_PRESSURE);
}

bool ShouldBuildT1MediumAA(const string& in side)
{
	return (IsEarlyGame() && CanAfford(16.0f))
		|| (HasPressure(EARLY_PRESSURE) && CanAfford(12.0f));
}

bool ShouldBuildT1LightTurret(const string& in side)
{
	return HasFactory()
		|| (IsEarlyGame() && CanAfford(8.0f))
		|| (HasPressure(EARLY_PRESSURE) && CanAfford(8.0f));
}

bool ShouldBuildT1MediumTurret(const string& in side)
{
	return (IsEarlyGame() && CanAfford(19.0f))
		|| (HasPressure(MEDIUM_PRESSURE) && CanAfford(14.0f));
}

bool ShouldBuildT1Arty(const string& in side)
{
	return (IsEarlyGame() && CanAfford(22.0f))
		|| (HasPressure(MEDIUM_PRESSURE) && CanAfford(16.0f));
}

bool ShouldBuildT1Torp(const string& in side)
{
	return false; // T1 Torpedo defense needs to be implemented
}

bool ShouldBuildT2FlakAA(const string& in side)
{
	return (IsMidGame() && CanAfford(25.0f))
		|| (HasPressure(MEDIUM_PRESSURE) && CanAfford(16.0f));
}

bool ShouldBuildT2RangeAA(const string& in side)
{
	return (IsLateGame() && CanAfford(60.0f))
		|| (HasPressure(HEAVY_PRESSURE) && CanAfford(35.0f));
}

bool ShouldBuildT2MediumTurret(const string& in side)
{
	return (IsMidGame() && CanAfford(26.0f))
		|| (HasPressure(MEDIUM_PRESSURE) && CanAfford(18.0f));
}

bool ShouldBuildT2Arty(const string& in side)
{
	return (IsLateGame() && CanAfford(65.0f))
		|| (HasPressure(HEAVY_PRESSURE) && CanAfford(35.0f));
}

bool ShouldBuildLRPC(const string& in side)
{
	return (IsLateGame() && CanAfford(80.0f))
		|| (HasPressure(HEAVY_PRESSURE) && CanAfford(55.0f));
}

bool ShouldBuildLRPCHeavy(const string& in side)
{
	return (IsLateGame() && CanAfford(120.0f))
		|| (HasPressure(HEAVY_PRESSURE) && CanAfford(80.0f));
}

bool ShouldMakeAnyDefence(const string& in side)
{
	return ShouldBuildT1LightTurret(side)
		|| ShouldBuildT1LightAA(side)
		|| ShouldBuildT1MediumTurret(side)
		|| ShouldBuildT1MediumAA(side)
		|| ShouldBuildT1Arty(side)
		|| ShouldBuildT1Torp(side)
		|| ShouldBuildT2MediumTurret(side)
		|| ShouldBuildT2FlakAA(side)
		|| ShouldBuildT2RangeAA(side)
		|| ShouldBuildT2Arty(side)
		|| ShouldBuildLRPC(side)
		|| ShouldBuildLRPCHeavy(side);
}

}  // namespace DefenseHelpers