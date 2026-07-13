# Azmodious Maintenance Guide

This folder is split cleanly between data tuning and light script overrides. Most future behavior changes should start in `config/hard/*.json`; the AngelScript layer mainly wires profile loading, startup behavior, and a few manager overrides.

## Load Path

1. `AIInfo.lua` and `AIOptions.lua` expose the AI identity and selectable options to the engine.
2. `script/hard/init.as` registers the hard profile and declares the JSON config domains loaded for that profile.
3. `script/hard/main.as` applies a few custom unit attributes at startup and delegates behavior to the manager modules.
4. Shared helpers in `script/*.as` define roles, attributes, constants, and task constructors used by the managers.

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

- `script/hard/init.as`: declares the loaded config files. If you add or rename a config domain, update this array.
- `script/hard/main.as`: startup mutations on unit defs and ad hoc factory tier tagging via `Factory::userData`.
- `script/hard/helper/ally_slot.as`: discovers allied AI team IDs through `AiSendMessage`, keeps them sorted, and exposes the repeating eight-slot assignment used by roles and lanes.
- `script/hard/helper/role.as`: resolves AIR/TECH/FRONT from the shared ally slot and routes role-specific factory restrictions, economy tuning, defence policy, and hooks.
- `script/hard/helper/air.as`, `script/hard/helper/tech.as`, `script/hard/helper/front.as`: per-role helper files for special playstyle changes.
- `script/hard/helper/command_delay.as`: shared command-throttle helper keyed by role/channel.
- `script/hard/helper/economy_smooth.as`: smoothed economy readings used by economy decisions.
- `script/hard/helper/lane.as`: deterministic lane assignment used to spread team behavior.
- `script/hard/helper/lane_pathing.as`: lane-biased positioning with terrain-aware scaling.
- `script/hard/helper/terrain_data.as`: terrain class and spread scaling for placement/pathing context.
- `script/hard/helper/terrain_runtime.as`: startup terrain manager setup.
- `script/hard/helper/terrain_bridge.as`: Lua message parser for runtime terrain hints.
- `script/hard/manager/builder.as`: mostly defaults to engine behavior; assigns up to two constructors the `BASE` attribute and persists those IDs.
- `script/hard/manager/economy.as`: computes stall/full flags and decides whether factories should require assistants.
- `script/hard/manager/factory.as`: factory task delegation, opener queue seeding, factory switch timing, and T2/T3 metadata.
- `script/hard/manager/military.as`: mostly default behavior; only overrides defence creation gating.
- `script/hard/misc/commander.as`: commander names plus opener definitions used when factories come online.

### Hard Profile Config

- `config/hard/behaviour.json`: unit roles, attributes, retreat thresholds, per-unit overrides, and global combat/defence knobs.
- `config/hard/block_map.json`: terrain analysis and building footprint/blocking classes.
- `config/hard/build_chain.json`: build-finished follow-up chains, porc rules, and side-specific defence/build helpers.
- `config/hard/commander.json`: commander hide/assist/morph policy.
- `config/hard/economy.json`: energy and mex pacing, buildpower ratios, clustering, assistance, and production thresholds.
- `config/hard/factory.json`: factory selection and unit production probability tables.
- `config/hard/response.json`: role-vs-role counter logic and response weights.

## Where To Edit

Start from the narrowest owner for the behavior you want:

- Change what role or attribute a unit has: `config/hard/behaviour.json`
- Change retreat, target threat, fire state, or per-unit combat overrides: `config/hard/behaviour.json`
- Change production mix inside a factory: `config/hard/factory.json`
- Change which enemy roles trigger a counter-response: `config/hard/response.json`
- Change economic pacing, assistant logic, or energy thresholds: `config/hard/economy.json`
- Change smoothed economy signal behavior (EMA/noise dampening): `script/hard/helper/economy_smooth.as`
- Change post-build follow-ups like porc, pylon, or hub chains: `config/hard/build_chain.json`
- Change build footprint spacing or terrain/build blocking rules: `config/hard/block_map.json`
- Change lane assignment and lane restrictions by role: `script/hard/helper/lane.as`
- Change terrain-aware lane/path spread behavior: `script/hard/helper/lane_pathing.as`, `script/hard/helper/terrain_data.as`
- Change startup terrain manager setup: `script/hard/helper/terrain_runtime.as`
- Change external terrain hints from Lua: `script/hard/helper/terrain_bridge.as`
- Change commander hide radius, assist behavior, or morph config: `config/hard/commander.json`
- Change the first units queued from a new factory: `script/hard/misc/commander.as`
- Change ally-team discovery, slot ordering, or slot broadcast timing: `script/hard/helper/ally_slot.as`
- Change role-to-slot mapping, role dispatch, or allowed factory families: `script/hard/helper/role.as`
- Change Air/Tech/Front stage tuning (economy bias, stall/assist thresholds, factory-switch multipliers, defence gates, frontline confirmation, or factory timing): `script/hard/helper/air.as`, `script/hard/helper/tech.as`, `script/hard/helper/front.as`
- Change shared command throttling behavior for role command bursts: `script/hard/helper/command_delay.as`
- Change factory switch timing or custom factory-side logic: `script/hard/manager/factory.as`
- Change builder-specific custom behavior: `script/hard/manager/builder.as`
- Change startup `BASE` tagging for static economy structures: `script/hard/main.as`
- Change constructor `BASE` tagging and its save/load state: `script/hard/manager/builder.as`

## Focused Editing Playbooks

### Terrain Editing

Use this when placement/pathing behavior should react to map shape or scripted map hints.

1. Tune static building/blocking assumptions in `config/hard/block_map.json`.
2. Tune heuristic terrain classification and spread factors in `script/hard/helper/terrain_data.as`.
3. Tune lane path spread integration in `script/hard/helper/lane_pathing.as`.
4. If runtime map hints are available, update parsing/apply logic in `script/hard/helper/terrain_bridge.as`.
5. Keep startup terrain manager setup aligned in `script/hard/helper/terrain_runtime.as` and ensure `main.as` still calls runtime init.

Expected Lua hint format for bridge updates:

- `TERRAIN_HINT:build_pct=<int>;path_pct=<int>;ally_zone=<int>;water_map=<0|1>`

### Economic Editing

Use this when economy decisions are too noisy, too passive, or too aggressive.

1. Tune thresholds and production pacing in `config/hard/economy.json`.
2. Tune smoothing behavior in `script/hard/helper/economy_smooth.as`.
3. Verify consumers in `script/hard/manager/economy.as` are using smoothed values for stall/assist decisions.
4. Tune role-specific economy multipliers/threshold wrappers in `script/hard/helper/air.as`, `script/hard/helper/tech.as`, and `script/hard/helper/front.as`.

### Role Selection and Tuning

Use this when the ally-team composition, factory families, pacing, or tactical constraints need to change.

1. Edit ally-slot discovery only in `script/hard/helper/ally_slot.as`. Every AI broadcasts `ALLY_SLOT:<teamId>` every five seconds until ten seconds; IDs are sorted numerically and the local index is reduced modulo 8.
2. Edit the mapping in `TeamRole::Resolve()` in `script/hard/helper/role.as`: slots 0-1 are AIR, 2-3 are TECH, and 4-7 are FRONT. The role is refreshed after slow updates and ally messages, so a newly discovered lower team ID can change an already-running AI's role.
3. Tune per-role, per-stage constants in `air.as`, `tech.as`, and `front.as`. Stages are Early (<12 min), Mid (12-24 min), and Late (>=24 min). These files own reclaim conversion/energy efficiency, energy-stall thresholds, assistant threshold, factory-switch thresholds and interval, defence gates/spread, and frontline confirmation lifetime.
4. Edit lane exemptions/restrictions in `script/hard/helper/lane.as`. Slots 0-1 (AIR) are unrestricted; all other slots use their slot modulo four to choose a lane.
5. If role commands are bursty, use role wrappers `IsCommandReady(...)` and `CommitCommandDelay(...)` with role/channel keys.

### Structure and Placement Editing

Use this when structures are built too close together, too far from base, or with the wrong clearance.

1. Classify or adjust a structure's footprint in `config/hard/block_map.json`. `building.instance` maps unit names to a class; `class_land` supplies the shape, structure type, offset, yard/radius, and collision exceptions. Add water-specific overrides under `class_water` only when water behavior must differ.
2. Treat `yard` and `radius` as placement-clearance tuning, not cosmetic values. The documented unit is 16 elmos; `ignore` and `not_ignore` decide which structure types may overlap the blocker's clearance.
3. For static economy structures that should stay near the base core, add their exact unit names to `Main::IsBaseEconomyStructure()` in `script/hard/main.as`; startup adds the `BASE` attribute to those non-mobile defs.
4. For mobile constructors that should favor base-local jobs, tune the two `BASE` assignments in `script/hard/manager/builder.as`. Preserve the `energizer1`/`energizer2` save-load IDs if that ownership logic changes.
5. Retune `economy.cluster_range` in `config/hard/economy.json` alongside `BASE` and footprint changes: it controls economy clustering, while the attributes and block map control task affinity and physical clearance.

### Custom Editing (New Helpers and Overrides)

Use this when JSON tuning is not enough and a script helper/override is required.

1. Add helper under `script/hard/helper/` with a clear namespace and narrow ownership.
2. Include helper in one stable include owner (typically `script/hard/helper/role.as` for role helpers) to avoid duplicate symbol issues.
3. Wire helper through the owning manager hook (`economy.as`, `factory.as`, `military.as`, or `main.as`) rather than scattering direct calls.
4. If helper introduces persisted IDs/state, keep `AiLoad`/`AiSave` compatibility in the owning manager.
5. Add a short note in this file under Folder Map / Where To Edit when the helper becomes part of normal maintenance.

## Important Couplings

- The profile list in `script/hard/init.as` must stay in sync with the JSON files that exist under `config/hard`.
- Role and attribute strings used in `behaviour.json` must match the registrations in `script/unit.as`.
- Factory name constants in `script/hard/manager/factory.as` are reused by opener logic in `script/hard/misc/commander.as` and startup tier tagging in `script/hard/main.as`.
- Team role assignment uses each AI's index in the numerically sorted list of discovered allied AI team IDs, then repeats in blocks of 8: slots 0-1 AIR, 2-3 TECH, and 4-7 FRONT. It is not derived from `GetLeadTeamId()`; that value is only retained in diagnostic/fallback side detection.
- Ally-slot discovery broadcasts for the opening ten seconds. The local team ID is always included, and received messages are still accepted afterward, so role/lane assignment can refresh if a previously unseen lower team ID is reported late.
- Lane assignment is deterministic from the same slot: AIR slots are lane-unrestricted, while other slots use `slot % 4` for their lane.
- Terrain tuning now combines static block-map tuning, heuristic terrain scales, and optional Lua hint overrides via `AiLuaMessage`.
- Economy manager now relies on smoothed signals for key stall/assist behavior to reduce spike-driven thrashing.
- Shared role command throttling is provided by `script/hard/helper/command_delay.as` and consumed via role wrappers.
- `main.as` assigns `BASE` to named static economy structures at startup; `builder.as` assigns it to up to two constructors. These are separate from `economy.cluster_range` and `block_map.json` footprint rules, but all three influence economy layout.
- `Factory::userData` tier flags are assigned in `main.as`, then consumed in `factory.as`; if you add a new factory tier concept, both places must change.
- `build_chain.json` explicitly warns against recursive chains; treat chain additions as potentially unsafe until checked.
- `factory.json` is shared across the allyTeam, so changes there can affect multiple allied AI instances together.
- `builder.as` persists `energizer1` and `energizer2`; any change to that assignment logic should preserve `AiLoad` and `AiSave` compatibility.

## Practical Change Tracking

To keep future changes easy to audit:

- Prefer one config domain per commit or patch when possible.
- Prefix commit or patch notes with the owning domain, for example: `[behaviour]`, `[factory]`, `[economy]`, `[builder]`.
- If a change crosses config and script, note which script hook consumes the config and why config alone was insufficient.
- When adding a new tuning concept, document the owner file here so future searches stay short.

## Safe First Checks

When behavior looks wrong, check these first before deeper changes:

- The relevant unit role/attribute exists in `config/hard/behaviour.json`.
- The role name matches `script/unit.as` exactly.
- The intended config file is actually listed by `script/hard/init.as`.
- The behavior is not still delegated to `Default*` logic in the manager hook you are inspecting.
- The change is not opener-driven from `script/hard/misc/commander.as`.

## Current Design Summary

This profile is data-heavy and script-light. The fastest path for most future edits is:

1. Identify whether the issue is tuning, composition, response, economy, footprinting, or startup sequencing.
2. Edit the matching JSON or the single manager hook that owns that decision.
3. Avoid broad script changes unless the default manager logic is insufficient.
