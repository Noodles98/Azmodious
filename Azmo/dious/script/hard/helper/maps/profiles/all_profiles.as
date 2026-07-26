#include "../registry.as"

#include "coastlines_dry_v2_2_1.as"
#include "darkside_v3_0.as"
#include "flooded_valley_v5.as"
#include "full_metal_plate_1_7.as"
#include "project_sd_129_v1_0.as"
#include "sunderance_v1_3.as"

namespace TeamMapProfileAll {

void RegisterAll()
{
    TeamMapProfileData_coastlines_dry_v2_2_1::Register();
    TeamMapProfileData_darkside_v3_0::Register();
    TeamMapProfileData_flooded_valley_v5::Register();
    TeamMapProfileData_full_metal_plate_1_7::Register();
    TeamMapProfileData_project_sd_129_v1_0::Register();
    TeamMapProfileData_sunderance_v1_3::Register();
}

}  // namespace TeamMapProfileAll

