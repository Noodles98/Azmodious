#include "manager/military.as"
#include "manager/builder.as"
#include "manager/factory.as"
#include "manager/economy.as"
#include "helper/terrain/terrain_runtime.as"


namespace Main {

namespace UnitHelpers {

array<string> GetAllT1CombatUnits()
{
	return {
		// Armada T1 bot/veh combat
		"armflea", "armpw", "armrock", "armham", "armwar", "armjeth",
		"armfav", "armflash", "armpincer", "armstump", "armart", "armjanus", "armsam",

		// Cortex T1 bot/veh combat
		"corak", "corstorm", "corthud", "corcrash",
		"corfav", "corgator", "corgarp", "corraid", "corlevlr", "corwolv", "cormist",

		// Legion T1 bot/veh combat
		"leggob", "leglob", "legcen", "legbal", "legkark",
		"legscout", "leghades", "leghelios", "leggat", "legbar", "legrail", "legamphtank"
	};
}

}  // namespace UnitHelpers

bool IsBaseEconomyStructure(const string& in name)
{
	return (name == "armwin") || (name == "corwin")
		|| (name == "legwin")
		|| (name == "armsolar") || (name == "corsolar")
		|| (name == "legsolar")
		|| (name == "armadvsol") || (name == "coradvsol")
		|| (name == "legadvsol")
		|| (name == "armfus") || (name == "corfus")
		|| (name == "legfus")
		|| (name == "armafus") || (name == "corafus")
		|| (name == "legafus")
		|| (name == "armmakr") || (name == "cormakr")
		|| (name == "legeconv")
		|| (name == "armmmkr") || (name == "cormmkr")
		|| (name == "legadveconv");
}

void AiMain()
{
	TerrainRuntime::Init();
	TeamRole::Init();
	TeamRole::ApplyEconomyBias();

	array<string> t1Combat = UnitHelpers::GetAllT1CombatUnits();
	for (uint i = 0; i < t1Combat.length(); ++i) {
		CCircuitDef@ d = ai.GetCircuitDef(t1Combat[i]);
		if (d is null)
			continue;
		// Best-effort profile override for early combat stance.
		d.SetFireState(3);
	}

	// NOTE: Initialize config params
// 	aiTerrainMgr.SetAllyZoneRange(600);  // returns 576: (multiples of 128) div 2
// 	aiEconomyMgr.reclConvertEff = 2.f;
// 	aiEconomyMgr.reclEnergyEff = 20.f;
//
// 	for (Id defId = 1, count = ai.GetDefCount(); defId <= count; ++defId) {
// 		CCircuitDef@ cdef = ai.GetCircuitDef(defId);
// 		AiLog(cdef.GetName() + " | threat = " + cdef.threat + " | power = " + cdef.power +
// 			" | air = " + cdef.GetAirThreat() + " | surf = " + cdef.GetSurfThreat() + " | water = " + cdef.GetWaterThreat());
// 		cdef.SetThreatKernel((cdef.costM + cdef.costE * 0.02f) * 0.001f);
//
// 		if (ai.teamId == ai.GetLeadTeamId()) {
// 			AiLog("minRange = " + cdef.minRange +
// 				", maxRange = " + cdef.GetMaxRange() +
// 				", maxRange[AIR] = " + cdef.GetMaxRange(Unit::RangeType::AIR) +
// 				", maxRange[SURF] = " + cdef.GetMaxRange(Unit::RangeType::SURF) +
// 				", maxRange[WATER] = " + cdef.GetMaxRange(Unit::RangeType::WATER));
// 			cdef.SetRange(cdef.GetMaxRange() * 0.5f);
// 		}
// 	}

	for (Id defId = 1, count = ai.GetDefCount(); defId <= count; ++defId) {
		CCircuitDef@ cdef = ai.GetCircuitDef(defId);
		if (cdef.IsMobile())
			continue;

		const string name = cdef.GetName();
		if (IsBaseEconomyStructure(name))
			cdef.AddAttribute(Unit::Attr::BASE.type);  // Keep economy infrastructure near base
	}

	// Example of user-assigned custom attributes
	array<string> names = {Factory::armalab, Factory::coralab, Factory::armavp, Factory::coravp,
		Factory::armaap, Factory::coraap, Factory::armasy, Factory::corasy,
		Factory::legalab, Factory::legavp, Factory::legaap};
	for (uint i = 0; i < names.length(); ++i)
		Factory::userData[ai.GetCircuitDef(names[i]).id].attr |= Factory::Attr::T2;
	names = {Factory::armshltx, Factory::corgant, Factory::leggant};
	for (uint i = 0; i < names.length(); ++i)
		Factory::userData[ai.GetCircuitDef(names[i]).id].attr |= Factory::Attr::T3;
}

void AiUpdate()  // SlowUpdate, every 30 frames with initial offset of skirmishAIId
{
	TeamRole::OnSlowUpdate();
}

void AiLuaMessage(const string& in data)  // Spring.SendSkirmishAIMessage(teamID, msg) from unsynced lua
{
	if (TerrainRuntime::OnLuaMessage(data))
		return;

	if (data.findLast("DISABLE_CONTROL:", 0) == 0)
		UnitControl(data.substr(16), false);
	else if (data.findLast("ENABLE_CONTROL:", 0) == 0)
		UnitControl(data.substr(15), true);
}

void AiMessage(const string& in data, int fromTeamId)  // AiSendMessage(msg, toTeamId = -1)
{
	TeamRole::OnMessage(data);
}

void AiUnitFinished(CCircuitUnit@ unit)
{
	// NOTE: Experimental. May be deprecated.
	// Duplicates module's AiUnitAdded, but for any unit.
}

void AiUnitDestroyed(CCircuitUnit@ unit)
{
	// NOTE: Experimental. May be deprecated
	// Duplicates module's AiUnitRemoved, but for any unit.
}

}  // namespace Main


void UnitControl(const string& in idList, bool isEnable)
{
	const array<string>@ ids = idList.split(",");
	for (uint i = 0; i < ids.length(); ++i)
		ai.UnitControl(parseInt(ids[i]), isEnable);
}
