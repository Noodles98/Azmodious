namespace DefenseHelpers {

const float EXTRA_DEFENCE_PRESSURE_MIN = 25.0f;
const float EXTRA_DEFENCE_METAL_INCOME_MIN = 20.0f;

bool ShouldBuildExtraDefence()
{
	return (aiEnemyMgr.mobileThreat >= EXTRA_DEFENCE_PRESSURE_MIN)
		&& (aiEconomyMgr.metal.income >= EXTRA_DEFENCE_METAL_INCOME_MIN);
}

}  // namespace DefenseHelpers