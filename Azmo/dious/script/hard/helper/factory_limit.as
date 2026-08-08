namespace FactoryLimit {

const float T1_METAL_INCOME_PER_FACTORY = 15.0f;
const float T2_METAL_INCOME_PER_FACTORY = 20.0f;
const uint FREE_FACTORIES_PER_TIER = 1;

uint GetAllowedCount(bool isT2, float metalIncome)
{
	const float incomePerFactory = isT2 ? T2_METAL_INCOME_PER_FACTORY : T1_METAL_INCOME_PER_FACTORY;
	if (metalIncome <= 10.0f)
		return FREE_FACTORIES_PER_TIER;
	return FREE_FACTORIES_PER_TIER + uint(metalIncome / incomePerFactory);
}

bool IsAllowed(bool isT2, uint currentCount, float metalIncome)
{
	return currentCount < GetAllowedCount(isT2, metalIncome);
}

bool HasSwitchIncome(bool isT2, uint factoryCount, float metalIncome)
{
	const float incomePerFactory = isT2 ? T2_METAL_INCOME_PER_FACTORY : T1_METAL_INCOME_PER_FACTORY;
	const uint count = (factoryCount > 0) ? factoryCount : 1;
	return metalIncome >= incomePerFactory * count;
}

}  // namespace FactoryLimit