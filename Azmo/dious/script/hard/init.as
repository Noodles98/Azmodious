#include "../unit.as"
#include "../common.as"


namespace Init {

SInitInfo AiInit()
{
	AiLog("dev AngelScript Rules!");

	SInitInfo data;
	data.armor = InitArmordef();
	data.category = InitCategories();
	@data.profile = @(array<string> = {
		"ArmadaBehaviour",
		"CortexBehaviour",
		"block_map",
		"ArmadaBuildChain",
		"CortexBuildChain",
		"commander",
		"ArmadaEconomy",
		"CortexEconomy",
		"ArmadaFactory",
		"CortexFactory",
		"ArmadaResponse",
		"CortexResponse"
	});

	if (string(aiSetupMgr.GetModOptions()["experimentallegionfaction"]) == "1") {
		AiLog("Inserting Legion");
		data.profile.insertLast("LegionBehaviour");
		data.profile.insertLast("LegionBuildChain");
		data.profile.insertLast("LegionEconomy");
		data.profile.insertLast("LegionFactory");
		data.profile.insertLast("LegionResponse");
	} else {
		AiLog("Ignoring Legion");
	}
	if (string(aiSetupMgr.GetModOptions()["scavunitsforplayers"]) == "1") {
		AiLog("Inserting Scav Units");
		data.profile.insertLast("extrascavunits");
	} else {
		AiLog("Ignoring Scav Units");
	}
	if (string(aiSetupMgr.GetModOptions()["experimentalextraunits"]) == "1") {
		AiLog("Inserting Extra Units");
		data.profile.insertLast("extraunits");
	} else {
		AiLog("Ignoring Extra Units");
	}
	return data;
}

}
