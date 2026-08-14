#include "registry.as"
#include "metadata_profiles.as"

namespace TeamMapProfileDefaults {

bool isRegistered = false;

void RegisterAll()
{
	if (isRegistered)
		return;
	isRegistered = true;

	TeamMapProfileMetadata::RegisterAll();
}

}  // namespace TeamMapProfileDefaults
