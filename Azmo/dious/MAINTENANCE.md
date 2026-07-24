# Azmodious Maintenance Guide

Most future behavior changes should start in `config/hard/*.json`; the AngelScript layer mainly wires profile loading, startup behavior, and manager overrides.

Keep this guide updated when adding major helpers, manager overrides, config domains, or behavior changes that future maintenance will need to find quickly.

## Load Path

1. `AIInfo.lua` and `AIOptions.lua` expose the AI identity and selectable options to the engine.
2. `script/hard/init.as` registers the hard profile and declares the JSON config domains loaded for that profile.
3. `script/hard/main.as` applies a few custom unit attributes at startup and delegates behavior to the manager modules.
4. Shared helpers in `script/*.as` define roles, attributes, constants, map data, and task constructors used by the managers.

## Folder Map

### Metadata

- `AIInfo.lua`: engine-facing AI metadata.
- `AIOptions.lua`: runtime options; currently the only selectable profile is `hard`.

### Shared Script Layer

- `script/common.as`: side masks and armor/category registration.
- `script/define.as`: global timing and geometry constants.
- `script/task.as`: task enums plus helper constructors for build, recruit, and fight tasks.
- `script/unit.as`: role and attribute registration. This is the canonical place to check role names used by config.

### Hard Profile Runtime Hooks

- `script/hard/init.as`: declares the loaded config files. Armada/Cortex behaviour, build-chain, economy, factory, and response overlays load by default; Legion, extra units, and scav units are gated by AI/mod options. If you add or rename a config domain, update this array.
- `script/hard/main.as`: startup mutations on unit defs and ad hoc factory tier tagging via `Factory::userData`.
- `script/hard/helper/ally_slot.as`: discovers allied AI team IDs through `AiSendMessage`, keeps them sorted, and exposes the repeating eight-slot assignment used by roles and lanes.
- `script/hard/helper/role/role.as`: resolves AIR/TECH/SEA/FRONT from a map-profile start-spot role when available, otherwise from the shared ally slot; it also routes role-specific factory restrictions, economy tuning, defence policy, and hooks.
- `script/hard/helper/role/air.as`, `script/hard/helper/role/tech.as`, `script/hard/helper/role/sea.as`, `script/hard/helper/role/front.as`: per-role helper files for special playstyle changes.
- `script/hard/helper/defense.as`: adaptive defence gate helpers modeled as `ShouldBuild...` checks. These currently use game time, metal income, and enemy mobile threat, then let the default military manager choose/place the actual defence from config.
- `script/hard/helper/command_delay.as`: shared command-throttle helper keyed by role/channel.
- `script/hard/helper/economy_smooth.as`: smoothed economy readings used by economy decisions.
- `script/hard/helper/resource_bonus.as`: normalizes engine-reported resource income for planning thresholds when the in-game AI bonus is set around +35%.
- `script/hard/helper/lane.as`: deterministic lane assignment used to spread team behavior.
- `script/hard/helper/lane_pathing.as`: lane-biased positioning with terrain-aware scaling.
- `script/hard/helper/military_task.as`: role-aware military fight-task policy layered before the engine default task selector. It maps unit roles/attributes to fight tasks such as scout, raid, attack, defend, bomber, artillery, support, AA, AH, and super.
- `script/hard/helper/terrain/terrain_data.as`: terrain class and spread scaling for placement/pathing context.
- `script/hard/helper/terrain/terrain_runtime.as`: startup terrain manager setup.
- `script/hard/helper/terrain/terrain_bridge.as`: Lua message parser for runtime terrain hints.
- `script/hard/helper/maps/default_profiles.as`: registers imported profiles first, then generated local profiles.
- `script/hard/helper/maps/imported_profiles.as`: curated map/start-spot role data. These profiles win when their map prefix matches because registry lookup returns the first match.
- `script/hard/helper/maps/profiles/*.as`: generated local map profiles, including extracted start spots and seeded roles. They are used only when no earlier imported profile matches.
- `script/hard/manager/builder.as`: mostly defaults to engine behavior; assigns role-based constructor counts the `BASE` attribute and persists those IDs. Current targets are AIR 6, TECH 4, FRONT 2, and SEA/default 2.
- `script/hard/manager/economy.as`: computes stall/full flags and decides whether factories should require assistants.
- `script/hard/manager/factory.as`: factory task delegation, opener queue seeding, factory switch timing, and T2/T3 metadata.
- `script/hard/manager/military.as`: role-aware combat task assignment plus defence creation gating; unhandled combat units still fall back to engine defaults.
- `script/hard/misc/commander.as`: commander names plus opener definitions used when factories come online.

### Hard Profile Config

- `config/hard/ArmadaBehaviour.json`, `config/hard/CortexBehaviour.json`, `config/hard/LegionBehaviour.json`: faction-specific unit roles, attributes, retreat thresholds, per-unit overrides, and global combat/defence knobs. The old shared `config/hard/unused/behaviour.json` is retained as source/reference but is no longer loaded by `hard/init.as`.
- `config/hard/extraunits.json`: optional extra-unit behaviour overlay loaded when `experimentalextraunits=1`.
- `config/hard/extrascavunits.json`: optional player scav-unit behaviour overlay loaded when `scavunitsforplayers=1`.
- `config/hard/block_map.json`: terrain analysis and building footprint/blocking classes.
- `config/hard/ArmadaBuildChain.json`, `config/hard/CortexBuildChain.json`, `config/hard/LegionBuildChain.json`: faction-specific build-finished follow-up chains, porc rules, and side-specific defence/build helpers. The old shared `config/hard/build_chain.json` is retained as source/reference but is no longer loaded by `hard/init.as`.
- `config/hard/commander.json`: commander hide/assist/morph policy.
- `config/hard/ArmadaEconomy.json`, `config/hard/CortexEconomy.json`, `config/hard/LegionEconomy.json`: faction-specific energy and mex pacing, buildpower ratios, clustering, assistance, and production thresholds. The old shared `config/hard/unused/economy.json` is retained as source/reference but is no longer loaded by `hard/init.as`.
- `config/hard/ArmadaFactory.json`, `config/hard/CortexFactory.json`, `config/hard/LegionFactory.json`: faction-specific factory selection and unit production probability tables. The old shared `config/hard/unused/factory.json` is retained as source/reference but is no longer loaded by `hard/init.as`.
- `config/hard/ArmadaResponse.json`, `config/hard/CortexResponse.json`, `config/hard/LegionResponse.json`: faction response overlays. They currently mirror the shared response policy; if they diverge, remember the response domain is role-based and overlapping keys are merge/override-sensitive. The old shared `config/hard/unused/response.json` is retained as source/reference but is no longer loaded by `hard/init.as`.

## Where To Edit

Start from the narrowest owner for the behavior you want:

- Change what role or attribute a unit has: the faction-specific `config/hard/*Behaviour.json` files, or optional `extraunits.json` / `extrascavunits.json` overlays.
- Change retreat, target threat, fire state, or per-unit combat overrides: the faction-specific `config/hard/*Behaviour.json` files.
- Change production mix inside a factory: the faction-specific `config/hard/*Factory.json` files.
- Change which enemy roles trigger a counter-response: the faction-specific `config/hard/*Response.json` file, keeping in mind response keys are role-based and overlapping keys can override each other when multiple profiles load.
- Change economic pacing, assistant logic, or energy thresholds: the faction-specific `config/hard/*Economy.json` files.
- Change smoothed economy signal behavior (EMA/noise dampening): `script/hard/helper/economy_smooth.as`
- Change in-game resource bonus planning normalization: `script/hard/helper/resource_bonus.as`; JSON `income_tier` values still need direct config edits.
- Change post-build follow-ups like porc, pylon, or hub chains: the faction-specific `config/hard/*BuildChain.json` files.
- Change build footprint spacing or terrain/build blocking rules: `config/hard/block_map.json`
- Change lane assignment and lane restrictions by role: `script/hard/helper/lane.as`
- Change terrain-aware lane/path spread behavior: `script/hard/helper/lane_pathing.as`, `script/hard/helper/terrain/terrain_data.as`
- Change how lane bias is spread across positions instead of a single team slot: `script/hard/helper/lane.as`
- Change startup terrain manager setup: `script/hard/helper/terrain/terrain_runtime.as`
- Change external terrain hints from Lua: `script/hard/helper/terrain/terrain_bridge.as`
- Change commander hide radius, assist behavior, or morph config: `config/hard/commander.json`
- Change the first units queued from a new factory: `script/hard/misc/commander.as`
- Change ally-team discovery, slot ordering, or slot broadcast timing: `script/hard/helper/ally_slot.as`
- Change map/start-position role assignments: `script/hard/helper/maps/imported_profiles.as` (curated data) or `script/hard/helper/maps/profiles/*.as` (generated data)
- Change role resolution, slot fallback, role dispatch, or allowed factory families: `script/hard/helper/role/role.as`
- Change custom military fight-task assignment by role/attribute: `script/hard/helper/military_task.as`, wired through `script/hard/manager/military.as`
- Change Air/Tech/Sea/Front stage tuning (economy bias, stall/assist thresholds, factory-switch multipliers, defence gates, frontline confirmation, or factory timing): `script/hard/helper/role/air.as`, `script/hard/helper/role/tech.as`, `script/hard/helper/role/sea.as`, `script/hard/helper/role/front.as`
- Change adaptive defence gating by game time, metal income, or enemy pressure: `script/hard/helper/defense.as`; keep actual defence unit order in the faction-specific `config/hard/*BuildChain.json` files unless a direct script selector is added.
- Change shared command throttling behavior for role command bursts: `script/hard/helper/command_delay.as`
- Change factory switch timing or custom factory-side logic: `script/hard/manager/factory.as`
- Change builder-specific custom behavior, allied mex-claim rejection, or base constructor retention: `script/hard/manager/builder.as`; role targets are exposed by `TeamRole::GetBaseConstructorCount()` in `script/hard/helper/role/role.as`.
- Change startup `BASE` tagging for static economy structures: `script/hard/main.as`
- Change constructor `BASE` tagging and its save/load state: `script/hard/manager/builder.as`

## Focused Editing Playbooks

### Terrain Editing

Use this when placement/pathing behavior should react to map shape or scripted map hints.

1. Tune static building/blocking assumptions in `config/hard/block_map.json`.
2. Tune heuristic terrain classification and spread factors in `script/hard/helper/terrain/terrain_data.as`.
3. Tune lane path spread integration in `script/hard/helper/lane_pathing.as`.
4. If runtime map hints are available, update parsing/apply logic in `script/hard/helper/terrain/terrain_bridge.as`.
5. Keep startup terrain manager setup aligned in `script/hard/helper/terrain/terrain_runtime.as` and ensure `main.as` still calls runtime init.

Expected Lua hint format for bridge updates:

- `TERRAIN_HINT:build_pct=<int>;path_pct=<int>;ally_zone=<int>;water_map=<0|1>`

### Economic Editing

Use this when economy decisions are too noisy, too passive, or too aggressive.

1. Tune thresholds and production pacing in the relevant `config/hard/*Economy.json` faction overlay.
2. Tune smoothing behavior in `script/hard/helper/economy_smooth.as`.
3. Verify consumers in `script/hard/manager/economy.as` are using smoothed values for stall/assist decisions.
4. Tune `script/hard/helper/resource_bonus.as` when the in-game AI bonus changes. Script income gates should use `ResourceBonus::GetPlanningMetalIncome()` instead of raw `aiEconomyMgr.metal.income`.
5. For allied mex conflicts, keep `calc_mex` and ally-shared `mex_max` aligned across all loaded `config/hard/*Economy.json` faction overlays, and verify every faction's mex variants are listed in `config/hard/block_map.json`.
6. Arm/Cortex cross-upgrading Legion mexes is filtered in `script/hard/helper/legion_mex_upgrade.as`, with `script/hard/manager/builder.as` only forwarding unit-finished/destroyed events and rejected returned `MEXUP` tasks.
7. Tune role-specific economy multipliers/threshold wrappers in `script/hard/helper/role/air.as`, `script/hard/helper/role/tech.as`, `script/hard/helper/role/sea.as`, and `script/hard/helper/role/front.as`.

### Role Selection and Tuning

Use this when the ally-team composition, factory families, pacing, or tactical constraints need to change.

1. Check map-profile data first. `Factory::AiGetFactoryToBuild()` resolves the profile from the requested starting position; if that has not happened, `Factory::AiUnitAdded()` resolves it from the first factory position. The nearest listed `StartSpot` supplies `preferredRole` and `landLocked`.
2. A non-empty profile role overrides ally-slot assignment. `TeamRole::Resolve()` maps exactly `air` to AIR, `tech` to TECH, `sea` to SEA and `front` to FRONT; `landLocked` is recorded and logged but has no runtime consumer yet.
3. When no profile matches, edit ally-slot discovery only in `script/hard/helper/ally_slot.as`. Every AI broadcasts `ALLY_SLOT:<teamId>` every five seconds until ten seconds; IDs are sorted numerically and the local index is reduced modulo 8. Fallback slots 0-1 are AIR, 2-3 are TECH, slot 4 is SEA only when the terrain bridge reports a water map, and all remaining slots are FRONT.
4. Tune per-role, per-stage constants in `script/hard/helper/role/air.as`, `script/hard/helper/role/tech.as`, `script/hard/helper/role/sea.as`, and `script/hard/helper/role/front.as`. Stages are Early (<12 min), Mid (12-24 min), and Late (>=24 min). These files own reclaim conversion/energy efficiency, energy-stall thresholds, assistant threshold, factory-switch thresholds and interval, defence gates/spread, and frontline confirmation lifetime.
5. Edit lane exemptions/restrictions in `script/hard/helper/lane.as`. Restriction now follows resolved role: AIR is unrestricted, while non-AIR roles use lane biasing. Lane index naming still comes from ally slot for diagnostics.
6. If role commands are bursty, use role wrappers `IsCommandReady(...)` and `CommitCommandDelay(...)` with role/channel keys.

### Military Task Editing

Use this when combat units are joining the wrong fight task, defending when they should attack, raiding when they should hold, or falling through to default military behavior.

1. Check the unit's roles and attributes in the relevant `config/hard/*Behaviour.json` faction overlay first. `MilitaryTaskPolicy::GetPreferredFightType()` depends on `Unit::Role` masks and the `MELEE`/`SUPPORT` style attributes registered through `script/unit.as`.
2. Tune role-aware fight-task mapping in `script/hard/helper/military_task.as`. This helper owns the custom priority order for scouts, bombers, supers, AA/AH, artillery/support, skirmish backline, melee, raiders, and brawler attack units.
3. Keep role-specific defensive posture in `GetPreferredFightType()` and `GetDefendPromotePower()`. TECH currently defends more aggressively, AIR defends mainline ground units, SEA has its own defend promotion power, and FRONT defaults to lower promote power.
4. Keep `script/hard/manager/military.as` as the owner that calls `MilitaryTaskPolicy` before falling back to `aiMilitaryMgr.DefaultMakeTask(...)`. Do not scatter task-selection calls into role helpers unless the manager ownership changes.
5. If a new unit category needs a new task behavior, add the role/attribute registration and config assignment alongside the `military_task.as` mapping so future role edits can find the full chain.

### Structure and Placement Editing

Use this when structures are built too close together, too far from base, or with the wrong clearance.

1. Classify or adjust a structure's footprint in `config/hard/block_map.json`. `building.instance` maps unit names to a class; `class_land` supplies the shape, structure type, offset, yard/radius, and collision exceptions. Add water-specific overrides under `class_water` only when water behavior must differ.
2. Treat `yard` and `radius` as placement-clearance tuning, not cosmetic values. The documented unit is 16 elmos; `ignore` and `not_ignore` decide which structure types may overlap the blocker's clearance.
3. Include every faction's mex variants in the `mex` and `mex2` instance lists; Legion variants such as `leganavalmex` and `legmext15` are needed for placement and upgrade filtering. Cross-faction Legion mex upgrade rejection lives in `script/hard/helper/legion_mex_upgrade.as` and is called from `script/hard/manager/builder.as`; use the builder unit definition for faction checks because `IUnitTask` does not expose `GetBuildDef()`.
4. For static economy structures that should stay near the base core, add their exact unit names to `Main::IsBaseEconomyStructure()` in `script/hard/main.as`; startup adds the `BASE` attribute to those non-mobile defs.
5. For mobile constructors that should favor base-local jobs, tune the role target returned by `TeamRole::GetBaseConstructorCount()` and the candidate filter in `script/hard/manager/builder.as`. Current candidates are constructors costing at least 200 metal, constructors beyond the active guard-task count, or flying constructors. Preserve the six-ID `AiLoad`/`AiSave` format if the persisted list changes.
6. Retune `economy.cluster_range` in the relevant `config/hard/*Economy.json` faction overlay alongside `BASE` and footprint changes: it controls economy clustering, while the attributes and block map control task affinity and physical clearance.

### Custom Editing (New Helpers and Overrides)

Use this when JSON tuning is not enough and a script helper/override is required.

1. Add helper under `script/hard/helper/` with a clear namespace and narrow ownership.
2. Include helper in one stable include owner (typically `script/hard/helper/role/role.as` for role helpers) to avoid duplicate symbol issues.
3. Wire helper through the owning manager hook (`economy.as`, `factory.as`, `military.as`, or `main.as`) rather than scattering direct calls.
4. If helper introduces persisted IDs/state, keep `AiLoad`/`AiSave` compatibility in the owning manager.
5. Add a short note in this file under Folder Map / Where To Edit when the helper becomes part of normal maintenance.

### Defence Editing

Use this when the AI is building too little, too much, or the wrong tier of static defence.

1. Tune unit availability, roles, and threat values for static defences in the relevant `config/hard/*Behaviour.json` faction overlay.
2. Tune the porcupine defence order, base defence schedule, superweapon list, and side-specific defence units in the faction-specific `config/hard/*BuildChain.json` files.
3. Tune adaptive build permission in `script/hard/helper/defense.as`. It exposes `ShouldBuildT1LightAA`, `ShouldBuildT1LightTurret`, `ShouldBuildT2FlakAA`, `ShouldBuildLRPC`, and related helpers.
4. Keep `script/hard/manager/military.as` as the owner that combines role defence policy, adaptive defence pressure, lane-biased placement, and `aiMilitaryMgr.DefaultMakeDefence(...)`.
5. If future work needs exact turret selection from script, add or verify a direct build API before bypassing `DefaultMakeDefence`; currently the helper only gates whether defence creation is allowed.

## Important Couplings

- The profile list in `script/hard/init.as` must stay in sync with the JSON files that exist under `config/hard`.
- Role and attribute strings used in `behaviour.json` must match the registrations in `script/unit.as`.
- Factory name constants in `script/hard/manager/factory.as` are reused by opener logic in `script/hard/misc/commander.as` and startup tier tagging in `script/hard/main.as`.
- Map-profile role data has priority over ally-slot assignment. Imported profiles are registered before generated profiles, and the registry returns the first prefix match; update the imported entry when a map exists in both data sets.
- The only map role labels currently interpreted as distinct runtime roles are `air`, `tech`, and `sea`. Any other non-empty label resolves as FRONT, unless `TeamRole::Resolve()` is extended.
- Without a profile role, team role assignment uses each AI's index in the numerically sorted list of discovered allied AI team IDs, then repeats in blocks of 8: slots 0-1 AIR, 2-3 TECH, slot 4 SEA only on a terrain-flagged water map, and slots 4-7 otherwise FRONT. It is not derived from `GetLeadTeamId()`; that value is only retained in diagnostic/fallback side detection.
- Ally-slot discovery broadcasts for the opening ten seconds. The local team ID is always included, and received messages are still accepted afterward, so role/lane assignment can refresh if a previously unseen lower team ID is reported late.
- Lane assignment is position-biased for ground movement, so units do not all inherit the same team-slot lane offset. AIR restriction is resolved by role (including map-profile role), not by slot.
- Terrain helper files live under `script/hard/helper/terrain/`; update include paths when moving terrain parsing, runtime setup, or classification helpers.
- Role helper files live under `script/hard/helper/role/`; manager includes should usually target `script/hard/helper/role/role.as`, not individual role files.
- Terrain tuning now combines static block-map tuning, heuristic terrain scales, and optional Lua hint overrides via `AiLuaMessage`.
- Adaptive defence gating lives in `script/hard/helper/defense.as`, while actual default defence selection still comes from the faction-specific `config/hard/*BuildChain.json` files and `aiMilitaryMgr.DefaultMakeDefence(...)`.
- Military combat task assignment first checks `script/hard/helper/military_task.as` for role/attribute-specific intents such as scout, raid, artillery, support, AA, bomber, and super; unknown or generic units still use `aiMilitaryMgr.DefaultMakeTask(...)`.
- Resource bonus planning normalization lives in `script/hard/helper/resource_bonus.as`; keep it included through `script/hard/helper/role/role.as` to avoid duplicate symbol definitions.
- Economy manager now relies on smoothed signals for key stall/assist behavior to reduce spike-driven thrashing.
- Shared role command throttling is provided by `script/hard/helper/command_delay.as` and consumed via role wrappers.
- `main.as` assigns `BASE` to named static economy structures at startup; `builder.as` assigns `BASE` to a role-sized persisted pool of mobile constructors. AIR keeps up to 6, TECH up to 4, and FRONT/SEA/default up to 2. These are separate from `economy.cluster_range` and `block_map.json` footprint rules, but all three influence economy layout.
- `Factory::userData` tier flags are assigned in `main.as`, then consumed in `factory.as`; if you add a new factory tier concept, both places must change.
- The profile generator seeds roles from extracted start spots plus metadata heuristics (`minHeight`, `tidalStrength`, and map-name water hints), while `imported_profiles.as` preserves curated pre-existing role labels. Generation must not silently overwrite curated imported assignments.
- The `config/hard/*BuildChain.json` files explicitly warn against recursive chains; treat chain additions as potentially unsafe until checked.
- `factory.json` is shared across the allyTeam, so changes there can affect multiple allied AI instances together.
- `builder.as` persists role-based base constructor IDs; AIR currently keeps 6 constructors at base, TECH keeps 4, FRONT keeps 2, and SEA/default keeps 2.

## Practical Change Tracking

To keep future changes easy to audit:

- Prefer one config domain per commit or patch when possible.
- Prefix commit or patch notes with the owning domain, for example: `[behaviour]`, `[factory]`, `[economy]`, `[builder]`.
- If a change crosses config and script, note which script hook consumes the config and why config alone was insufficient.
- When adding a new tuning concept, document the owner file here so future searches stay short.
- When adding a major helper, manager override, persisted state, or config domain, update the Folder Map, Where To Edit, and any relevant editing playbook in this file as part of the same change.

## Safe First Checks

When behavior looks wrong, check these first before deeper changes:

- The relevant unit role/attribute exists in the active `config/hard/*Behaviour.json` faction overlay or optional extra/scav overlay.
- The role name matches `script/unit.as` exactly.
- The intended config file is actually listed by `script/hard/init.as`.
- The behavior is not still delegated to `Default*` logic in the manager hook you are inspecting.
- The change is not opener-driven from `script/hard/misc/commander.as`.

## Current Design Summary

The fastest path for most future edits is:

1. Identify whether the issue is tuning, composition, response, economy, footprinting, or startup sequencing.
2. Edit the matching JSON or the single manager hook that owns that decision.
3. Avoid broad script changes unless the default manager logic is insufficient.

## Map Profile Notes

- Resolution for map profiles lives in `script/hard/helper/map_profile.as`.
- `Resolve()` finds the first registered map-name prefix match, chooses its nearest start spot, and records that spot's preferred role plus land-lock state.
- `default_profiles.as` registers `imported_profiles.as` before `profiles/all_profiles.as`; first-match lookup means imported data overrides generated data for the same map prefix.
- The profile files under `script/hard/helper/maps/profiles/` are generated from metadata JSON and are hand-edited, but the authoritative curated overrides belong in `imported_profiles.as`.
- A profile entry is `StartSpot(AIFloat3(x, 0, z), "role", landLocked)`. Keep spot coordinates aligned with the map's real start positions because selection is nearest-position, not array-index based.
- `landLocked` is currently retained for diagnostics only. It does not alter role selection, lanes, factory selection, or pathing.
