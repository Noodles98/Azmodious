namespace DefenseHelpers {

bool ShouldBuildExtraDefence()
{
	// The role policy deliberately uses OR: an early sighting needs a cheap
	// response even before the economy reaches its normal expansion income.
	// Do not add a global affordability gate here; it previously overrode all
	// role thresholds and delayed every response until the attack was underway.
	return TeamRole::ShouldMakeDefence();
}

}  // namespace DefenseHelpers
