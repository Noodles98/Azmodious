#include "../../define.as"
#include "../helper/economy_smooth.as"
#include "../helper/role.as"


namespace Economy {

// To not reset army requirement on factory switch, @see Factory::AiIsSwitchAllowed
bool isSwitchAssist = false;

void AiUnitAdded(CCircuitUnit@ unit, Unit::UseAs usage)
{
}

void AiUnitRemoved(CCircuitUnit@ unit, Unit::UseAs usage)
{
}

void AiLoad(IStream& istream)
{
}

void AiSave(OStream& ostream)
{
}

float GetSmoothedMetalCurrent(float fallback)
{
	return EconomySmooth::GetMetalCurrent(fallback);
}

/*
 * struct SResourceInfo {
 *   const float current;
 *   const float storage;
 *   const float pull;
 *   const float income;
 * }
 */
void AiUpdateEconomy()
{
	const SResourceInfo@ metal = aiEconomyMgr.metal;
	const SResourceInfo@ energy = aiEconomyMgr.energy;
	EconomySmooth::Update(metal, energy);

	const float metalRatio = EconomySmooth::GetMetalRatio();
	const float energyRatio = EconomySmooth::GetEnergyRatio();
	const float energyBalance = EconomySmooth::GetEnergyBalance();

	aiEconomyMgr.isMetalEmpty = metalRatio < 0.2f;
	aiEconomyMgr.isMetalFull = metalRatio > 0.8f;
	aiEconomyMgr.isEnergyEmpty = energyRatio < 0.2f;
	if (aiEconomyMgr.isMetalEmpty) {
		aiEconomyMgr.isEnergyStalling = aiEconomyMgr.isEnergyEmpty
			|| ((energyBalance < 0.f) && (energyRatio < TeamRole::GetEnergyStallRatioWhenMetalEmpty()));
	} else {
		aiEconomyMgr.isEnergyStalling = aiEconomyMgr.isEnergyEmpty
			|| ((energyBalance < 0.f) && (energyRatio < TeamRole::GetEnergyStallRatioDefault()));
	}
	// NOTE: Default energy-to-metal conversion TeamRulesParam "mmLevel" = 0.75
	aiEconomyMgr.isEnergyFull = energyRatio > 0.85f;

	isSwitchAssist = isSwitchAssist && aiFactoryMgr.isAssistRequired;
	if (aiFactoryMgr.GetFactoryCount() == 0) {
		aiFactoryMgr.isAssistRequired = false;
		return;
	}

	aiFactoryMgr.isAssistRequired = isSwitchAssist
		|| ((metalRatio > TeamRole::GetAssistMetalRatio()) && !aiEconomyMgr.isEnergyStalling);
}

}  // namespace Economy
