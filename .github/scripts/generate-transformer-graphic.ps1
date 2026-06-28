# I-JEPA architecture graphic in GitHub contribution-grid pixel style
param(
  [string]$OutPath = "assets/transformer-architecture.svg"
)

$ErrorActionPreference = "Stop"
$root = Resolve-Path (Join-Path $PSScriptRoot "../..")
Set-Location $root

$cell = 8
$gap = 2
$levels = @("#161b22", "#2a1212", "#6b1515", "#d41414", "#ff2020")
$stroke = "#3a1212"
$W = 920
$H = 318

function Get-Cell([int]$x, [int]$y, [int]$level, [double]$delay = 0, [switch]$Animate) {
  $fill = $levels[[Math]::Min(4, [Math]::Max(0, $level))]
  $px = $x * ($cell + $gap)
  $py = $y * ($cell + $gap)
  if ($Animate -and $level -gt 0) {
    $l0 = $levels[[Math]::Max(0, $level - 1)]
    $l1 = $fill
    $l2 = $levels[[Math]::Min(4, $level + 1)]
    $dur = [Math]::Round(2 + (($x + $y) % 4) * 0.2, 1)
    return @(
      "  <rect x=`"$px`" y=`"$py`" width=`"$cell`" height=`"$cell`" rx=`"2`" fill=`"$fill`" stroke=`"$stroke`" stroke-width=`"0.5`">",
      "    <animate attributeName=`"fill`" values=`"$l0;$l1;$l2;$l1`" dur=`"${dur}s`" begin=`"${delay}s`" repeatCount=`"indefinite`"/>",
      "  </rect>"
    ) -join "`n"
  }
  return "  <rect x=`"$px`" y=`"$py`" width=`"$cell`" height=`"$cell`" rx=`"2`" fill=`"$fill`" stroke=`"$stroke`" stroke-width=`"0.5`"/>"
}

function Get-GridLevel([int]$x, [int]$y, [string]$Region) {
  switch ($Region) {
    "input-context" {
      if ($x -ge 0 -and $x -le 7 -and $y -ge 1 -and $y -le 4) { return 2 + (($x + $y) % 3) }
      if ($x -ge 8 -and $x -le 9 -and $y -ge 1 -and $y -le 2) { return 3 }
      if ($x -ge 10 -and $x -le 11 -and $y -ge 2 -and $y -le 4) { return 4 }
      if ($x -ge 9 -and $x -le 10 -and $y -ge 4 -and $y -le 5) { return 3 }
      if ($y -eq 0 -or $y -ge 6) { return 0 }
      return 1
    }
    "input-full" {
      $base = if ($y -ge 1 -and $y -le 4) { 1 + (($x + $y) % 2) } else { 0 }
      if ($x -ge 9 -and $x -le 11 -and $y -ge 1 -and $y -le 5) { return [Math]::Min(4, $base + 1) }
      return $base
    }
    "encoder" { return 1 + (($x + $y * 2) % 4) }
    "predictor" { return 2 + (($x * $y + $x) % 3) }
    "latent-pred" { return 2 + (($x + $y) % 3) }
    "latent-tgt" { return 1 + (($x * 2 + $y) % 3) }
    default { return 0 }
  }
}

function Add-Label([System.Text.StringBuilder]$sb, [int]$x, [int]$y, [string]$text, [string]$color = "#7d8590", [int]$size = 9, [switch]$Bold) {
  $weight = if ($Bold) { ' font-weight="600"' } else { "" }
  [void]$sb.AppendLine("  <text x=`"$x`" y=`"$y`" fill=`"$color`" font-family=`"Segoe UI, Arial, sans-serif`" font-size=`"$size`"$weight text-anchor=`"middle`">$text</text>")
}

function Add-LabelGroup([System.Text.StringBuilder]$sb, [int]$x, [int]$y, [string[]]$lines, [string]$color = "#7d8590", [int]$size = 9, [switch]$Bold) {
  for ($i = 0; $i -lt $lines.Count; $i++) {
    Add-Label $sb $x ($y + ($i * 11)) $lines[$i] $color $size -Bold:$Bold
  }
}

function Add-Grid([System.Text.StringBuilder]$sb, [int]$gx, [int]$gy, [int]$cols, [int]$rows, [string]$region, [switch]$Animate, [int]$levelOffset = 0) {
  [void]$sb.AppendLine("  <g transform=`"translate($gx,$gy)`">")
  for ($y = 0; $y -lt $rows; $y++) {
    for ($x = 0; $x -lt $cols; $x++) {
      $lvl = [Math]::Max(0, (Get-GridLevel -x $x -y $y -Region $region) - $levelOffset)
      $delay = [Math]::Round(($x * 0.05 + $y * 0.07) % 2.5, 2)
      [void]$sb.AppendLine((Get-Cell -x $x -y $y -level $lvl -delay $delay -Animate:($Animate -and $lvl -gt 0)))
    }
  }
  [void]$sb.AppendLine('  </g>')
}

$sb = New-Object System.Text.StringBuilder
[void]$sb.AppendLine("<svg xmlns=`"http://www.w3.org/2000/svg`" viewBox=`"0 0 $W $H`" role=`"img`" aria-label=`"Contribution-grid architecture diagram`">")
[void]$sb.AppendLine("  <rect width=`"$W`" height=`"$H`" fill=`"#080808`"/>")
[void]$sb.AppendLine('  <defs>')
[void]$sb.AppendLine('    <marker id="arr" markerWidth="6" markerHeight="6" refX="5" refY="3" orient="auto"><path d="M0,0 L6,3 L0,6 Z" fill="#ff2020"/></marker>')
[void]$sb.AppendLine('    <marker id="arrDim" markerWidth="6" markerHeight="6" refX="5" refY="3" orient="auto"><path d="M0,0 L6,3 L0,6 Z" fill="#484f58"/></marker>')
[void]$sb.AppendLine('  </defs>')

# Column anchors
$colInput = 78
$colCtx = 198
$colPred = 312
$colZhat = 434
$colLoss = 548
$colSemantic = 742

$rowStudentLabel = 28
$rowStudentGrid = 54
$rowStudentFoot = 144
$rowDivider = 162
$rowTeacherLabel = 174
$rowTeacherGrid = 192
$rowTeacherFoot = 284
$emaX = $colCtx - 46
$ctxEncBottom = $rowStudentGrid + 90
$tgtEncTop = $rowTeacherGrid - 2
$emaLabelY = [int](($ctxEncBottom + $tgtEncTop) / 2)

Add-Label $sb $colInput $rowStudentLabel "Input patches"
Add-LabelGroup $sb $colCtx $rowStudentLabel @("Context", "Encoder")
Add-Label $sb $colPred $rowStudentLabel "Predictor"
Add-Label $sb $colZhat $rowStudentLabel "z-hat predicted" "#ff2020" 8 -Bold
Add-Label $sb $colLoss ($rowStudentLabel + 5) "L2 loss"
Add-Label $sb $colSemantic ($rowStudentLabel - 2) "Abstract prediction | no pixel decode" "#7d8590" 8

# Student path grids
$inputW = 12 * ($cell + $gap) - $gap
[void]$sb.AppendLine("  <g transform=`"translate($([int]($colInput - $inputW / 2)),$rowStudentGrid)`">")
for ($y = 0; $y -lt 7; $y++) {
  for ($x = 0; $x -lt 12; $x++) {
    $lvl = Get-GridLevel -x $x -y $y -Region "input-context"
    $delay = [Math]::Round(($x * 0.05 + $y * 0.07) % 2.5, 2)
    [void]$sb.AppendLine((Get-Cell -x $x -y $y -level $lvl -delay $delay -Animate:($lvl -gt 1)))
  }
}
[void]$sb.AppendLine('    <rect x="-2" y="10" width="74" height="46" rx="3" fill="none" stroke="#ff2020" stroke-width="1" stroke-dasharray="3 2" opacity="0.85"/>')
[void]$sb.AppendLine('  </g>')
Add-Label $sb ($colInput - 22) $rowStudentFoot "context" "#ff2020" 7
Add-Label $sb ($colInput + 24) $rowStudentFoot "targets" "#484f58" 7

Add-Grid $sb ($colCtx - 22) $rowStudentGrid 5 10 "encoder" -Animate
Add-Label $sb $colCtx $rowStudentFoot "z_ctx" "#484f58" 7

Add-Grid $sb ($colPred - 35) ($rowStudentGrid + 6) 8 8 "predictor" -Animate
Add-Label $sb $colPred $rowStudentFoot "+ mask tokens" "#484f58" 7

Add-Grid $sb ($colZhat - 22) $rowStudentGrid 5 10 "latent-pred" -Animate

# L2 box
[void]$sb.AppendLine("  <g transform=`"translate($($colLoss - 40),$($rowStudentGrid + 2))`">")
[void]$sb.AppendLine('    <rect width="80" height="84" rx="8" fill="#161b22" stroke="#30363d" stroke-width="1"/>')
[void]$sb.AppendLine('    <text x="40" y="24" fill="#ff2020" font-family="Segoe UI, Arial, sans-serif" font-size="12" font-weight="700" text-anchor="middle">L2</text>')
[void]$sb.AppendLine('    <text x="40" y="40" fill="#7d8590" font-family="Segoe UI, Arial, sans-serif" font-size="8" text-anchor="middle">loss</text>')
[void]$sb.AppendLine('    <text x="40" y="56" fill="#484f58" font-family="Segoe UI, Arial, sans-serif" font-size="7" text-anchor="middle">||z-hat - z||</text>')
[void]$sb.AppendLine('    <text x="40" y="70" fill="#484f58" font-family="Segoe UI, Arial, sans-serif" font-size="7" text-anchor="middle">latent space</text>')
[void]$sb.AppendLine('  </g>')

# Semantic panel
$semW = 22 * ($cell + $gap) - $gap
[void]$sb.AppendLine("  <g transform=`"translate($([int]($colSemantic - $semW / 2)),$rowStudentGrid)`">")
for ($y = 0; $y -lt 7; $y++) {
  for ($x = 0; $x -lt 22; $x++) {
    if (($x - 7) * ($x - 7) + ($y - 3) * ($y - 3) -lt 16) { $lvl = 2 + (($x + $y) % 3) }
    elseif (($x - 16) * ($x - 16) + ($y - 5) * ($y - 5) -lt 8) { $lvl = 3 + ($x % 2) }
    elseif (($x + $y) % 5 -eq 0) { $lvl = 1 }
    else { $lvl = 0 }
    $px = $x * ($cell + $gap); $py = $y * ($cell + $gap)
    $fill = $levels[[Math]::Min(4, [Math]::Max(0, [int]$lvl))]
    if ($lvl -gt 1) {
      [void]$sb.AppendLine("    <rect x=`"$px`" y=`"$py`" width=`"$cell`" height=`"$cell`" rx=`"2`" fill=`"$fill`" stroke=`"$stroke`" stroke-width=`"0.5`"><animate attributeName=`"fill`" values=`"#2a1212;$fill;#ff2020;$fill`" dur=`"2.5s`" begin=`"$([Math]::Round(($x+$y)*0.03,2))s`" repeatCount=`"indefinite`"/></rect>")
    } else {
      [void]$sb.AppendLine("    <rect x=`"$px`" y=`"$py`" width=`"$cell`" height=`"$cell`" rx=`"2`" fill=`"$fill`" stroke=`"$stroke`" stroke-width=`"0.5`"/>")
    }
  }
}
[void]$sb.AppendLine('  </g>')
Add-Label $sb $colSemantic $rowStudentFoot "semantic target representation" "#484f58" 8

# Student arrows
$arrowY = $rowStudentGrid + 38
[void]$sb.AppendLine("  <path d=`"M$([int]($colInput + $inputW / 2 + 4)) $arrowY H$($colCtx - 28)`" stroke=`"#ff2020`" stroke-width=`"1.5`" marker-end=`"url(#arr)`" fill=`"none`" opacity=`"0.85`"/>")
[void]$sb.AppendLine("  <path d=`"M$($colCtx + 28) $arrowY H$($colPred - 38)`" stroke=`"#ff2020`" stroke-width=`"1.5`" marker-end=`"url(#arr)`" fill=`"none`" opacity=`"0.85`"/>")
[void]$sb.AppendLine("  <path d=`"M$($colPred + 38) $arrowY H$($colZhat - 28)`" stroke=`"#ff2020`" stroke-width=`"1.5`" marker-end=`"url(#arr)`" fill=`"none`" opacity=`"0.85`"/>")
[void]$sb.AppendLine("  <path d=`"M$($colZhat + 30) $($rowStudentGrid + 20) C$($colZhat + 50) $($rowStudentGrid + 10), $($colLoss - 20) $($rowStudentGrid + 10), $($colLoss - 36) $($rowStudentGrid + 28)`" stroke=`"#d41414`" stroke-width=`"1.2`" fill=`"none`" stroke-dasharray=`"3 2`"/>")

# Divider + teacher path
[void]$sb.AppendLine("  <line x1=`"20`" y1=`"$rowDivider`" x2=`"900`" y2=`"$rowDivider`" stroke=`"#21262d`" stroke-width=`"1`"/>")
Add-Label $sb $colInput $rowTeacherLabel "Full image"
Add-LabelGroup $sb $colCtx $rowTeacherLabel @("Target", "Encoder")
Add-Label $sb $colZhat $rowTeacherLabel "z target"

Add-Grid $sb ($colInput - $inputW / 2) $rowTeacherGrid 12 7 "input-full"
Add-Grid $sb ($colCtx - 22) $rowTeacherGrid 5 10 "encoder" -levelOffset 1
Add-Label $sb $colCtx $rowTeacherFoot "z_tgt" "#484f58" 7
Add-Grid $sb ($colZhat - 22) $rowTeacherGrid 5 10 "latent-tgt"
Add-Label $sb $colZhat $rowTeacherFoot "stop-grad" "#484f58" 7

$teacherArrowY = $rowTeacherGrid + 38
[void]$sb.AppendLine("  <path d=`"M$([int]($colInput + $inputW / 2 + 4)) $teacherArrowY H$($colCtx - 28)`" stroke=`"#484f58`" stroke-width=`"1.2`" marker-end=`"url(#arrDim)`" fill=`"none`" stroke-dasharray=`"4 3`"/>")
[void]$sb.AppendLine("  <path d=`"M$($colCtx + 28) $teacherArrowY H$($colZhat - 28)`" stroke=`"#484f58`" stroke-width=`"1.2`" marker-end=`"url(#arrDim)`" fill=`"none`" stroke-dasharray=`"4 3`"/>")
[void]$sb.AppendLine("  <path d=`"M$colCtx $ctxEncBottom H$emaX`" stroke=`"#7d8590`" stroke-width=`"1`" fill=`"none`" stroke-dasharray=`"4 3`"/>")
[void]$sb.AppendLine("  <path d=`"M$emaX $ctxEncBottom V$tgtEncTop`" stroke=`"#7d8590`" stroke-width=`"1`" fill=`"none`" stroke-dasharray=`"4 3`" marker-end=`"url(#arrDim)`"/>")
[void]$sb.AppendLine("  <path d=`"M$emaX $tgtEncTop H$colCtx`" stroke=`"#7d8590`" stroke-width=`"1`" fill=`"none`" stroke-dasharray=`"4 3`"/>")
[void]$sb.AppendLine("  <text x=`"$($emaX - 8)`" y=`"$emaLabelY`" fill=`"#7d8590`" font-family=`"Segoe UI, Arial, sans-serif`" font-size=`"8`" text-anchor=`"end`">EMA</text>")

[void]$sb.AppendLine("  <path d=`"M$($colZhat + 30) $($rowTeacherGrid + 20) C$($colZhat + 48) $($rowTeacherGrid + 8), $($colLoss - 18) $($rowStudentGrid + 58), $($colLoss - 36) $($rowStudentGrid + 52)`" stroke=`"#6b1515`" stroke-width=`"1.2`" fill=`"none`" stroke-dasharray=`"3 2`"/>")

[void]$sb.AppendLine('  <circle r="3" fill="#ff2020"><animateMotion dur="3.5s" repeatCount="indefinite" path="M78 116 H430"/><animate attributeName="opacity" values="0;1;1;0" keyTimes="0;0.08;0.92;1" dur="3.5s" repeatCount="indefinite"/></circle>')

# Legend
Add-Label $sb 700 308 "Less" "#7d8590" 9
for ($i = 0; $i -lt 5; $i++) {
  [void]$sb.AppendLine("  <rect x=`"$([int](728 + $i * 14))`" y=`"298`" width=`"10`" height=`"10`" rx=`"2`" fill=`"$($levels[$i])`" stroke=`"$stroke`" stroke-width=`"0.5`"/>")
}
Add-Label $sb 810 308 "More" "#7d8590" 9

[void]$sb.AppendLine('</svg>')

$content = $sb.ToString()
Set-Content -Path $OutPath -Value $content -Encoding UTF8
try { [xml]$content | Out-Null; Write-Host "Wrote $OutPath (valid XML)" } catch { Write-Error $_.Exception.Message }
