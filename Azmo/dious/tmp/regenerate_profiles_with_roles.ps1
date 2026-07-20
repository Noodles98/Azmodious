$ErrorActionPreference = 'Stop'

$root = 'c:/Users/madma/AppData/Local/Programs/Beyond-All-Reason/data/engine/recoil_2026.06.12/AI/Skirmish/Azmo/dious'
$profilesDir = Join-Path $root 'script/hard/helper/maps/profiles'
$mapsRoot = 'c:/Users/madma/AppData/Local/Programs/Beyond-All-Reason/data/maps'
$jsonPath = Join-Path $root 'tmp/map_metadata_from_sd7.json'
$importedPath = Join-Path $root 'script/hard/helper/maps/imported_profiles.as'
$sevenZip = 'c:/Users/madma/AppData/Local/Programs/Beyond-All-Reason/resources/app.asar.unpacked/node_modules/7zip-bin/win/x64/7za.exe'

function ToDouble([object]$v, [double]$def = 0.0) {
    $s = [string]$v
    if ([string]::IsNullOrWhiteSpace($s)) { return $def }

    $out = 0.0
    if ([double]::TryParse($s, [Globalization.NumberStyles]::Float, [Globalization.CultureInfo]::InvariantCulture, [ref]$out)) {
        return $out
    }
    return $def
}

function Normalize([string]$s) {
    if ([string]::IsNullOrWhiteSpace($s)) { return '' }
    return ($s.ToLower() -replace '[^a-z0-9]+', '')
}

function NormalizeRole([string]$role) {
    if ($role -eq 'hover_sea') { return 'sea' }
    if ($role -eq 'front_tech') { return 'front' }
    return $role
}

# Parse imported profiles into map-name key => ordered list of spots.
$importedText = Get-Content $importedPath -Raw
$imported = @{}
$blockRe = 'array<TeamMapProfileTypes::StartSpot>\s+\w+Spots\s*=\s*\{(?<spots>.*?)\};\s*\s*TeamMapProfileRegistry::Register\(TeamMapProfileTypes::Profile\("(?<map>[^"]+)"\s*,\s*\w+Spots\)\);'
$spotRe = 'StartSpot\(AIFloat3\((?<x>[-\d\.]+),\s*0,\s*(?<z>[-\d\.]+)\),\s*"(?<role>[^"]+)",\s*(?<ll>true|false)\)'
$blocks = [regex]::Matches($importedText, $blockRe, [Text.RegularExpressions.RegexOptions]::Singleline)

foreach ($b in $blocks) {
    $map = [string]$b.Groups['map'].Value
    $k = Normalize $map
    if ([string]::IsNullOrWhiteSpace($k)) { continue }

    $list = New-Object System.Collections.Generic.List[object]
    $sm = [regex]::Matches($b.Groups['spots'].Value, $spotRe, [Text.RegularExpressions.RegexOptions]::IgnoreCase)
    foreach ($m in $sm) {
        $list.Add([pscustomobject]@{
            x = ToDouble $m.Groups['x'].Value
            z = ToDouble $m.Groups['z'].Value
            role = NormalizeRole([string]$m.Groups['role'].Value)
            ll = (([string]$m.Groups['ll'].Value).ToLower() -eq 'true')
        }) | Out-Null
    }

    if ($list.Count -gt 0) {
        $imported[$k] = $list
    }
}

$data = Get-Content $jsonPath -Raw | ConvertFrom-Json

$updated = 0
$withStarts = 0
$mappedImported = 0
$fallbackHeuristic = 0
$waterMapCount = 0

foreach ($row in $data) {
    $archiveName = [string]$row.archive
    if ([string]::IsNullOrWhiteSpace($archiveName)) { continue }

    $archivePath = Join-Path $mapsRoot $archiveName
    if (-not (Test-Path $archivePath)) { continue }

    $archiveBase = [IO.Path]::GetFileNameWithoutExtension($archiveName)
    $safeBase = ($archiveBase -replace '[^A-Za-z0-9_]', '_')
    if ($safeBase -match '^[0-9]') { $safeBase = 'm_' + $safeBase }

    $ns = 'TeamMapProfileData_' + $safeBase
    $filePath = Join-Path $profilesDir ($safeBase.ToLower() + '.as')
    if (-not (Test-Path $filePath)) { continue }

    $mapName = [string]$row.mapName
    if ([string]::IsNullOrWhiteSpace($mapName)) { $mapName = $archiveBase }

    $listText = (& $sevenZip l $archivePath) -join "`n"
    $mapInfoPath = $null
    if ($listText -match '(?im)^\d{4}-\d{2}-\d{2}.*\smapinfo\.lua\s*$') {
        $mapInfoPath = 'mapinfo.lua'
    } elseif ($listText -match '(?im)^\d{4}-\d{2}-\d{2}.*\smaphelper\\mapinfo\.lua\s*$') {
        $mapInfoPath = 'maphelper/mapinfo.lua'
    }

    $mapInfo = ''
    if ($mapInfoPath) {
        $mapInfo = ((& $sevenZip e -so $archivePath $mapInfoPath) -join "`n")
    }

    $spotMatches = [regex]::Matches(
        $mapInfo,
        '\[(\d+)\]\s*=\s*\{\s*startPos\s*=\s*\{\s*x\s*=\s*([\-\d\.]+)\s*,\s*z\s*=\s*([\-\d\.]+)\s*\}',
        [Text.RegularExpressions.RegexOptions]::IgnoreCase
    )

    if ($spotMatches.Count -eq 0) { continue }
    $withStarts++

    $spots = New-Object System.Collections.Generic.List[object]
    $ordered = $spotMatches | Sort-Object { [int]$_.Groups[1].Value }
    foreach ($s in $ordered) {
        $spots.Add([pscustomobject]@{
            x = ToDouble $s.Groups[2].Value
            z = ToDouble $s.Groups[3].Value
            role = 'front'
            ll = $false
        }) | Out-Null
    }

    $mapKey = Normalize $mapName
    $importedSpots = $null

    if ($imported.ContainsKey($mapKey)) {
        $importedSpots = $imported[$mapKey]
    } else {
        foreach ($k in $imported.Keys) {
            if ($mapKey.StartsWith($k) -or $k.StartsWith($mapKey)) {
                $importedSpots = $imported[$k]
                break
            }
        }
    }

    $usedImported = $false
    if ($importedSpots -ne $null -and $importedSpots.Count -gt 0 -and $importedSpots.Count -eq $spots.Count) {
        $used = New-Object 'System.Collections.Generic.HashSet[int]'
        for ($i = 0; $i -lt $spots.Count; $i++) {
            $best = -1
            $bestD = [double]::PositiveInfinity
            for ($j = 0; $j -lt $importedSpots.Count; $j++) {
                if ($used.Contains($j)) { continue }
                $dx = $spots[$i].x - $importedSpots[$j].x
                $dz = $spots[$i].z - $importedSpots[$j].z
                $d = ($dx * $dx) + ($dz * $dz)
                if ($d -lt $bestD) {
                    $bestD = $d
                    $best = $j
                }
            }

            if ($best -ge 0) {
                $used.Add($best) | Out-Null
                $spots[$i].role = [string]$importedSpots[$best].role
                $spots[$i].ll = [bool]$importedSpots[$best].ll
            }
        }

        $usedImported = $true
        $mappedImported++
    }

    if (-not $usedImported) {
        $fallbackHeuristic++

        $minH = ToDouble $row.minHeight
        $maxH = ToDouble $row.maxHeight
        $tidal = ToDouble $row.tidalStrength
        $heightSpan = [Math]::Max(1.0, $maxH - $minH)

        $nameL = ([string]$mapName).ToLower()
        $waterNameBias = ($nameL -match 'sea|shore|coast|isthmus|river|creek|bay|lagoon|strait|delta|estuary|fjord|ocean|naval|mediterr')
        $isWater = ($minH -le -70) -or ($tidal -ge 16) -or ($waterNameBias -and ($minH -lt 0 -or $tidal -ge 8))
        if ($isWater) { $waterMapCount++ }

        # Rank by distance from centroid for stable positional heuristics.
        $cx = 0.0
        $cz = 0.0
        foreach ($p in $spots) {
            $cx += $p.x
            $cz += $p.z
        }
        $cx /= $spots.Count
        $cz /= $spots.Count

        $ranked = @()
        for ($i = 0; $i -lt $spots.Count; $i++) {
            $dx = $spots[$i].x - $cx
            $dz = $spots[$i].z - $cz
            $d = [Math]::Sqrt(($dx * $dx) + ($dz * $dz))
            $ranked += [pscustomobject]@{ idx = $i; dist = $d }
        }

        $sortedDesc = $ranked | Sort-Object dist -Descending
        $sortedAsc = $ranked | Sort-Object dist

        $techCount = 0
        if ($spots.Count -ge 6) { $techCount = 1 }
        if ($spots.Count -ge 10) { $techCount = 2 }
        if ($heightSpan -lt 500 -and $techCount -gt 0) { $techCount-- }

        for ($t = 0; $t -lt $techCount; $t++) {
            $idx = $sortedAsc[$t].idx
            if ($spots[$idx].role -eq 'front') {
                $spots[$idx].role = 'tech'
            }
        }

        $airCount = 0
        if ($spots.Count -ge 4) { $airCount = 1 }
        if ($spots.Count -ge 12) { $airCount = 2 }

        for ($a = 0; $a -lt $airCount; $a++) {
            $idx = $sortedDesc[$a].idx
            if ($spots[$idx].role -eq 'front') {
                $spots[$idx].role = 'air'
            }
        }

        if ($isWater) {
            $seaCount = [Math]::Max(1, [int][Math]::Floor($spots.Count * 0.25))
            if ($tidal -ge 20 -or $minH -le -120) {
                $seaCount = [Math]::Max($seaCount, [int][Math]::Floor($spots.Count * 0.35))
            }

            $seaRole = 'sea'
            $assignOrder = @($sortedAsc) + @($sortedDesc)
            foreach ($entry in $assignOrder) {
                if ($seaCount -le 0) { break }
                $i = $entry.idx
                if ($spots[$i].role -eq 'front') {
                    $spots[$i].role = $seaRole
                    $seaCount--
                }
            }
        }
    }

    $lines = New-Object System.Collections.Generic.List[string]
    $lines.Add([string]::Format('namespace {0} {{', $ns)) | Out-Null
    $lines.Add('') | Out-Null
    $lines.Add('void Register()') | Out-Null
    $lines.Add('{') | Out-Null
    $lines.Add('    array<TeamMapProfileTypes::StartSpot> spots = {') | Out-Null

    foreach ($p in $spots) {
        $ll = if ($p.ll) { 'true' } else { 'false' }
        $line = [string]::Format(
            [Globalization.CultureInfo]::InvariantCulture,
            '    TeamMapProfileTypes::StartSpot(AIFloat3({0:0.###}, 0, {1:0.###}), "{2}", {3}),',
            $p.x,
            $p.z,
            $p.role,
            $ll
        )
        $lines.Add($line) | Out-Null
    }

    $lines.Add('    };') | Out-Null
    $escapedMapName = $mapName.Replace('"', '\"')
    $lines.Add([string]::Format('    TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("{0}", spots));', $escapedMapName)) | Out-Null
    $lines.Add('}') | Out-Null
    $lines.Add('') | Out-Null
    $lines.Add([string]::Format('}}  // namespace {0}', $ns)) | Out-Null

    Set-Content -Path $filePath -Value $lines -Encoding UTF8
    $updated++
}

"UPDATED_FILES=$updated"
"FILES_WITH_EXTRACTED_STARTS=$withStarts"
"MAPPED_FROM_IMPORTED=$mappedImported"
"FALLBACK_HEURISTIC=$fallbackHeuristic"
"WATER_MAP_HEURISTIC=$waterMapCount"
