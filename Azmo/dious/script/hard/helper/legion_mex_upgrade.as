#include "../../unit.as"
#include "../../task.as"


namespace LegionMexUpgradeFilter {

const float LEGION_MEX_RADIUS = 24.f;
const float LEGION_MEX_RADIUS_SQ = LEGION_MEX_RADIUS * LEGION_MEX_RADIUS;

array<float> legionMexX;
array<float> legionMexZ;

void OnUnitFinished(CCircuitUnit@ unit)
{
	if (!IsLegionMexDef(unit.circuitDef))
		return;

	AIFloat3 pos = unit.GetPos(ai.frame);
	StoreLegionMex(pos.x, pos.z);
}

void OnUnitDestroyed(CCircuitUnit@ unit)
{
	if (!IsLegionMexDef(unit.circuitDef))
		return;

	ForgetLegionMexNear(unit.GetPos(ai.frame));
}

bool ShouldReject(IUnitTask@ task, const CCircuitDef@ builderDef)
{
	if (task is null || task.GetType() != Task::Type::BUILDER || task.GetBuildType() != Task::BuildType::MEX)
		return false;
	if (IsLegionDef(builderDef))
		return false;

	return HasLegionMexNear(task.GetBuildPos());
}

bool IsLegionDef(const CCircuitDef@ cdef)
{
	if (cdef is null)
		return false;

	return cdef.GetName().findFirst("leg") == 0;
}

bool IsLegionMexDef(const CCircuitDef@ cdef)
{
	if (cdef is null)
		return false;

	const string name = cdef.GetName();
	return (name == "legmex") || (name == "leganavalmex") || (name == "legmoho")
		|| (name == "legmohoconct") || (name == "legmext15");
}

void StoreLegionMex(float mexX, float mexZ)
{
	for (uint mexIndex = 0; mexIndex < legionMexX.length(); ++mexIndex) {
		const float dx = legionMexX[mexIndex] - mexX;
		const float dz = legionMexZ[mexIndex] - mexZ;
		if (dx * dx + dz * dz <= LEGION_MEX_RADIUS_SQ) {
			legionMexX[mexIndex] = mexX;
			legionMexZ[mexIndex] = mexZ;
			return;
		}
	}
	legionMexX.insertLast(mexX);
	legionMexZ.insertLast(mexZ);
}

void ForgetLegionMexNear(const AIFloat3& in pos)
{
	for (int mexIndex = int(legionMexX.length()) - 1; mexIndex >= 0; --mexIndex) {
		const float dx = legionMexX[uint(mexIndex)] - pos.x;
		const float dz = legionMexZ[uint(mexIndex)] - pos.z;
		if (dx * dx + dz * dz > LEGION_MEX_RADIUS_SQ)
			continue;
		legionMexX.removeAt(uint(mexIndex));
		legionMexZ.removeAt(uint(mexIndex));
	}
}

bool HasLegionMexNear(const AIFloat3& in pos)
{
	for (uint mexIndex = 0; mexIndex < legionMexX.length(); ++mexIndex) {
		const float dx = legionMexX[mexIndex] - pos.x;
		const float dz = legionMexZ[mexIndex] - pos.z;
		if (dx * dx + dz * dz <= LEGION_MEX_RADIUS_SQ)
			return true;
	}
	return false;
}

}  // namespace LegionMexUpgradeFilter