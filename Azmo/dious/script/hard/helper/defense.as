namespace DefenseHelpers {

const int MID_GAME_FRAME = 10 * MINUTE;
const int LATE_GAME_FRAME = 20 * MINUTE;

const float EARLY_PRESSURE = 10.0f;
const float MEDIUM_PRESSURE = 25.0f;
const float HEAVY_PRESSURE = 55.0f;

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
	return ResourceBonus::GetPlanningMetalIncome();
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

bool ShouldBuildT1LightAA(const string& in side)
{
	return (ai.frame >= 5 * MINUTE && CanAfford(8.0f))
		|| HasPressure(MEDIUM_PRESSURE);
}

bool ShouldBuildT1MediumAA(const string& in side)
{
	return (IsMidGame() && CanAfford(15.0f))
		|| HasPressure(HEAVY_PRESSURE);
}

bool ShouldBuildT1LightTurret(const string& in side)
{
	return HasPressure(EARLY_PRESSURE)
		|| CanAfford(14.0f);
}

bool ShouldBuildT1MediumTurret(const string& in side)
{
	return (IsMidGame() && CanAfford(15.0f))
		|| HasPressure(MEDIUM_PRESSURE);
}

bool ShouldBuildT1Arty(const string& in side)
{
	return (IsMidGame() && CanAfford(18.0f))
		|| HasPressure(HEAVY_PRESSURE);
}

bool ShouldBuildT1Torp(const string& in side)
{
	return false; // T1 Torpedo defense needs to be implemented
}

bool ShouldBuildT2FlakAA(const string& in side)
{
	return (IsMidGame() && CanAfford(18.0f))
		|| (IsLateGame() && HasPressure(MEDIUM_PRESSURE));
}

bool ShouldBuildT2RangeAA(const string& in side)
{
	return (IsLateGame() && CanAfford(32.0f))
		|| (IsMidGame() && HasPressure(HEAVY_PRESSURE));
}

bool ShouldBuildT2MediumTurret(const string& in side)
{
	return (IsMidGame() && CanAfford(20.0f))
		|| HasPressure(HEAVY_PRESSURE);
}

bool ShouldBuildT2Arty(const string& in side)
{
	return (IsLateGame() && CanAfford(30.0f))
		|| (IsMidGame() && HasPressure(HEAVY_PRESSURE));
}

bool ShouldBuildLRPC(const string& in side)
{
	return IsLateGame() && CanAfford(45.0f);
}

bool ShouldBuildLRPCHeavy(const string& in side)
{
	return IsLateGame() && CanAfford(60.0f);
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