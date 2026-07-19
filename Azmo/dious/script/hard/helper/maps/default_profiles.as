#include "registry.as"
#include "imported_profiles.as"
#include "profiles/all_profiles.as"

namespace TeamMapProfileDefaults {

bool isRegistered = false;

void RegisterAll()
{
	if (isRegistered)
		return;
	isRegistered = true;

	TeamMapProfileImported::RegisterAll();
	TeamMapProfileAll::RegisterAll();
}

}  // namespace TeamMapProfileDefaults
