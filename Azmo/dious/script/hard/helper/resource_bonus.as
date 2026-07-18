namespace ResourceBonus {

const float PLANNING_BONUS_FACTOR = 1.35f;

float NormalizeIncome(float income)
{
	return income / PLANNING_BONUS_FACTOR;
}

float GetPlanningMetalIncome()
{
	return NormalizeIncome(aiEconomyMgr.metal.income);
}

float GetPlanningEnergyIncome()
{
	return NormalizeIncome(aiEconomyMgr.energy.income);
}

}  // namespace ResourceBonus