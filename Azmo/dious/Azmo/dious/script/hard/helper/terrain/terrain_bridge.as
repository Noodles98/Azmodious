namespace TerrainBridge {

bool hasHint = false;
bool isWaterMap = false;
float buildScale = 1.0f;
float pathScale = 1.0f;
int allyZone = -1;

float Clamp(float value, float lo, float hi)
{
	if (value < lo)
		return lo;
	if (value > hi)
		return hi;
	return value;
}

bool ParseBoolFlag(const string& in value)
{
	return value == "1" || value == "true" || value == "yes";
}

void ApplyHintToken(const string& in token)
{
	const int sep = token.findFirst("=");
	if (sep < 1)
		return;

	const string key = token.substr(0, sep);
	const string value = token.substr(sep + 1);

	if (key == "build_pct") {
		const int pct = parseInt(value);
		buildScale = Clamp(float(pct) * 0.01f, 0.35f, 2.20f);
		hasHint = true;
	} else if (key == "path_pct") {
		const int pct = parseInt(value);
		pathScale = Clamp(float(pct) * 0.01f, 0.35f, 2.20f);
		hasHint = true;
	} else if (key == "ally_zone") {
		allyZone = parseInt(value);
		if (allyZone > 0) {
			aiTerrainMgr.SetAllyZoneRange(allyZone);
			hasHint = true;
		}
	} else if (key == "water_map") {
		isWaterMap = ParseBoolFlag(value);
		hasHint = true;
	}
}

bool OnLuaMessage(const string& in data)
{
	if (data.findLast("TERRAIN_HINT:", 0) != 0)
		return false;

	const string payload = data.substr(13);
	const array<string>@ tokens = payload.split(";");
	for (uint i = 0; i < tokens.length(); ++i)
		ApplyHintToken(tokens[i]);

	return true;
}

float GetBuildScale()
{
	if (isWaterMap)
		return buildScale * 0.82f;
	return buildScale;
}

float GetPathScale()
{
	if (isWaterMap)
		return pathScale * 0.72f;
	return pathScale;
}

bool IsWaterMap()
{
	return isWaterMap;
}

}  // namespace TerrainBridge
