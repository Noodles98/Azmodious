// NOTE: terrain_bridge.as is included transitively through this helper.
#include "terrain_bridge.as"


namespace TerrainRuntime {

// Feed map-scale context into terrain manager at startup so downstream
// placement/pathing systems can use a wider ally-zone horizon.
void Init()
{
	aiTerrainMgr.SetAllyZoneRange(704);
}

bool OnLuaMessage(const string& in data)
{
	return TerrainBridge::OnLuaMessage(data);
}

}  // namespace TerrainRuntime
