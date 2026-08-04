namespace FactoryLimit {

const float T1_METAL_INCOME_PER_FACTORY = 35.0f;
const float T2_METAL_INCOME_PER_FACTORY = 40.0f;
const uint FREE_FACTORIES_PER_TIER = 2;

uint GetAllowedCount(bool isT2, float metalIncome)
{
	const float incomePerFactory = isT2 ? T2_METAL_INCOME_PER_FACTORY : T1_METAL_INCOME_PER_FACTORY;
	if (metalIncome <= 6.0f)
		return FREE_FACTORIES_PER_TIER;
	return FREE_FACTORIES_PER_TIER + uint(metalIncome / incomePerFactory);
}

bool IsAllowed(bool isT2, uint currentCount, float metalIncome)
{
	return currentCount < GetAllowedCount(isT2, metalIncome);
}

}  // namespace FactoryLimit