param(
  [Parameter(Mandatory = $true)]
  [string]$SvgPath
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $SvgPath)) {
  Write-Error "SVG not found: $SvgPath"
}

$map = [ordered]@{
  "#ebedf0" = "#161b22"
  "#9be9a8" = "#2a1212"
  "#40c463" = "#6b1515"
  "#30a14e" = "#d41414"
  "#216e39" = "#ff2020"
  "#ffffff" = "#080808"
  "#fff"    = "#080808"
}

$content = Get-Content -Raw $SvgPath

foreach ($entry in $map.GetEnumerator()) {
  $pattern = [regex]::Escape($entry.Key)
  $content = [regex]::Replace($content, $pattern, $entry.Value, "IgnoreCase")
}

$content = $content -replace "--color-calendar-graph-day-bg:#ebedf0", "--color-calendar-graph-day-bg:#161b22"
$content = $content -replace "--color-calendar-graph-day-L1-bg:#9be9a8", "--color-calendar-graph-day-L1-bg:#2a1212"
$content = $content -replace "--color-calendar-graph-day-L2-bg:#40c463", "--color-calendar-graph-day-L2-bg:#6b1515"
$content = $content -replace "--color-calendar-graph-day-L3-bg:#30a14e", "--color-calendar-graph-day-L3-bg:#d41414"
$content = $content -replace "--color-calendar-graph-day-L4-bg:#216e39", "--color-calendar-graph-day-L4-bg:#ff2020"

Set-Content -Path $SvgPath -Value $content -Encoding UTF8

try {
  [xml]$content | Out-Null
  Write-Host "Recolored $SvgPath (valid XML)"
} catch {
  Write-Error "Invalid SVG after recolor: $($_.Exception.Message)"
}
