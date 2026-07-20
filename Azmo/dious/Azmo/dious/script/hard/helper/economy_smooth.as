namespace EconomySmooth {

bool isReady = false;

float smoothedMetalRatio = 0.f;
float smoothedEnergyRatio = 0.f;
float smoothedEnergyBalance = 0.f;
float smoothedMetalCurrent = 0.f;

const float RATIO_ALPHA = 0.25f;
const float BALANCE_ALPHA = 0.18f;
const float CURRENT_ALPHA = 0.18f;

float Clamp01(float value)
{
	if (value < 0.f)
		return 0.f;
	if (value > 1.f)
		return 1.f;
	return value;
}

float Smooth(float previous, float value, float alpha)
{
	return previous + (value - previous) * alpha;
}

void Update(const SResourceInfo@ metal, const SResourceInfo@ energy)
{
	const float metalStorage = (metal.storage > 1.f) ? metal.storage : 1.f;
	const float energyStorage = (energy.storage > 1.f) ? energy.storage : 1.f;
	const float metalRatio = Clamp01(metal.current / metalStorage);
	const float energyRatio = Clamp01(energy.current / energyStorage);
	const float energyBalance = energy.income - energy.pull;

	if (!isReady) {
		isReady = true;
		smoothedMetalRatio = metalRatio;
		smoothedEnergyRatio = energyRatio;
		smoothedEnergyBalance = energyBalance;
		smoothedMetalCurrent = metal.current;
		return;
	}

	smoothedMetalRatio = Smooth(smoothedMetalRatio, metalRatio, RATIO_ALPHA);
	smoothedEnergyRatio = Smooth(smoothedEnergyRatio, energyRatio, RATIO_ALPHA);
	smoothedEnergyBalance = Smooth(smoothedEnergyBalance, energyBalance, BALANCE_ALPHA);
	smoothedMetalCurrent = Smooth(smoothedMetalCurrent, metal.current, CURRENT_ALPHA);
}

float GetMetalRatio()
{
	return smoothedMetalRatio;
}

float GetEnergyRatio()
{
	return smoothedEnergyRatio;
}

float GetEnergyBalance()
{
	return smoothedEnergyBalance;
}

float GetMetalCurrent(float fallback)
{
	return isReady ? smoothedMetalCurrent : fallback;
}

}  // namespace EconomySmooth
