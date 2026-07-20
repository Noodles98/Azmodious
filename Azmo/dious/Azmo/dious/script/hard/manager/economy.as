#include "../../define.as"
#include "../helper/economy_smooth.as"
#include "../helper/role/role.as"


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
	// Require real surplus, not just a briefly full battery, before requesting converters.
	aiEconomyMgr.isEnergyFull = (energyRatio > 0.92f) && (energyBalance > 0.f);

	// Consume switch-assist as a one-update signal; Factory::AiIsSwitchAllowed
	// will re-assert it on subsequent failed switch checks.
	const bool switchAssist = isSwitchAssist;
	isSwitchAssist = false;
	if (aiFactoryMgr.GetFactoryCount() == 0) {
		aiFactoryMgr.isAssistRequired = false;
		return;
	}

	aiFactoryMgr.isAssistRequired = switchAssist
		|| ((metalRatio > TeamRole::GetAssistMetalRatio()) && !aiEconomyMgr.isEnergyStalling);
}

}  // namespace Economy
