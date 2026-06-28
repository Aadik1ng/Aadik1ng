# I-JEPA architecture graphic in GitHub contribution-grid pixel style
param(
  [string]$OutPath = "assets/transformer-architecture.svg"
)

$ErrorActionPreference = "Stop"
$root = Resolve-Path (Join-Path $PSScriptRoot "../..")
Set-Location $root

$cell = 8
$gap = 2
$levels = @("#161b22", "#0e4429", "#006d32", "#26a641", "#39d353")

function Get-Cell([int]$x, [int]$y, [int]$level, [double]$delay = 0, [switch]$Animate) {
  $fill = $levels[[Math]::Min(4, [Math]::Max(0, $level))]
  $px = $x * ($cell + $gap)
  $py = $y * ($cell + $gap)
  $lines = @("  <rect x=`"$px`" y=`"$py`" width=`"$cell`" height=`"$cell`" rx=`"2`" fill=`"$fill`" stroke=`"#21262d`" stroke-width=`"0.5`"/>")
  if ($Animate -and $level -gt 0) {
    $l0 = $levels[[Math]::Max(0, $level - 1)]
    $l1 = $fill
    $l2 = $levels[[Math]::Min(4, $level + 1)]
    $dur = [Math]::Round(2 + (($x + $y) % 4) * 0.2, 1)
    return @(
      "  <rect x=`"$px`" y=`"$py`" width=`"$cell`" height=`"$cell`" rx=`"2`" fill=`"$fill`" stroke=`"#21262d`" stroke-width=`"0.5`">",
      "    <animate attributeName=`"fill`" values=`"$l0;$l1;$l2;$l1`" dur=`"${dur}s`" begin=`"${delay}s`" repeatCount=`"indefinite`"/>",
      "  </rect>"
    ) -join "`n"
  }
  return $lines[0]
}

function Get-GridLevel([int]$x, [int]$y, [string]$Region) {
  switch ($Region) {
    "input-context" {
      if ($x -ge 0 -and $x -le 7 -and $y -ge 1 -and $y -le 4) {
        return 2 + (($x + $y) % 3)
      }
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
    "encoder" {
      return 1 + (($x + $y * 2) % 4)
    }
    "predictor" {
      return 2 + (($x * $y + $x) % 3)
    }
    "latent-pred" {
      return 2 + (($x + $y) % 3)
    }
    "latent-tgt" {
      return 1 + (($x * 2 + $y) % 3)
    }
    default { return 0 }
  }
}

$sb = New-Object System.Text.StringBuilder
[void]$sb.AppendLine('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 920 300" role="img" aria-label="I-JEPA architecture in contribution-grid style">')
[void]$sb.AppendLine('  <rect width="920" height="300" fill="#0d1117"/>')
[void]$sb.AppendLine('  <defs>')
[void]$sb.AppendLine('    <marker id="arr" markerWidth="6" markerHeight="6" refX="5" refY="3" orient="auto"><path d="M0,0 L6,3 L0,6 Z" fill="#39d353"/></marker>')
[void]$sb.AppendLine('    <marker id="arrDim" markerWidth="6" markerHeight="6" refX="5" refY="3" orient="auto"><path d="M0,0 L6,3 L0,6 Z" fill="#484f58"/></marker>')
[void]$sb.AppendLine('  </defs>')
[void]$sb.AppendLine('  <text x="460" y="26" fill="#e6edf3" font-family="Segoe UI, Arial, sans-serif" font-size="15" font-weight="700" text-anchor="middle">I-JEPA | Joint Embedding Predictive Architecture</text>')
[void]$sb.AppendLine('  <text x="460" y="44" fill="#7d8590" font-family="Segoe UI, Arial, sans-serif" font-size="10" text-anchor="middle">contribution-grid view | predict target embeddings in latent space</text>')

# Input patch grid (context + targets)
$gx = 24; $gy = 58
[void]$sb.AppendLine("  <g transform=`"translate($gx,$gy)`">")
[void]$sb.AppendLine('    <text x="52" y="-8" fill="#7d8590" font-family="Segoe UI, Arial, sans-serif" font-size="9" text-anchor="middle">Input patches</text>')
for ($y = 0; $y -lt 7; $y++) {
  for ($x = 0; $x -lt 12; $x++) {
    $lvl = Get-GridLevel -x $x -y $y -Region "input-context"
    $delay = [Math]::Round(($x * 0.05 + $y * 0.07) % 2.5, 2)
    [void]$sb.AppendLine((Get-Cell -x $x -y $y -level $lvl -delay $delay -Animate:($lvl -gt 1)))
  }
}
[void]$sb.AppendLine('    <rect x="-2" y="10" width="74" height="46" rx="3" fill="none" stroke="#39d353" stroke-width="1" stroke-dasharray="3 2" opacity="0.8"/>')
[void]$sb.AppendLine('    <text x="35" y="66" fill="#39d353" font-family="Segoe UI, Arial, sans-serif" font-size="7" text-anchor="middle">context</text>')
[void]$sb.AppendLine('    <text x="96" y="66" fill="#7d8590" font-family="Segoe UI, Arial, sans-serif" font-size="7" text-anchor="middle">targets</text>')
[void]$sb.AppendLine('  </g>')

# Context encoder grid
$gx = 168; $gy = 62
[void]$sb.AppendLine("  <g transform=`"translate($gx,$gy)`">")
[void]$sb.AppendLine('    <text x="22" y="-8" fill="#7d8590" font-family="Segoe UI, Arial, sans-serif" font-size="9" text-anchor="middle">Context</text>')
[void]$sb.AppendLine('    <text x="22" y="2" fill="#7d8590" font-family="Segoe UI, Arial, sans-serif" font-size="9" text-anchor="middle">Encoder</text>')
for ($y = 0; $y -lt 10; $y++) {
  for ($x = 0; $x -lt 5; $x++) {
    $lvl = Get-GridLevel -x $x -y $y -Region "encoder"
    $delay = [Math]::Round(($y * 0.12) % 2, 2)
    [void]$sb.AppendLine((Get-Cell -x $x -y $y -level $lvl -delay $delay -Animate))
  }
}
[void]$sb.AppendLine('    <text x="22" y="98" fill="#484f58" font-family="Segoe UI, Arial, sans-serif" font-size="7" text-anchor="middle">z_ctx</text>')
[void]$sb.AppendLine('  </g>')

# Predictor grid
$gx = 268; $gy = 72
[void]$sb.AppendLine("  <g transform=`"translate($gx,$gy)`">")
[void]$sb.AppendLine('    <text x="25" y="-8" fill="#7d8590" font-family="Segoe UI, Arial, sans-serif" font-size="9" text-anchor="middle">Predictor</text>')
for ($y = 0; $y -lt 8; $y++) {
  for ($x = 0; $x -lt 8; $x++) {
    $lvl = Get-GridLevel -x $x -y $y -Region "predictor"
    $delay = [Math]::Round((($x + $y) * 0.08) % 2.2, 2)
    [void]$sb.AppendLine((Get-Cell -x $x -y $y -level $lvl -delay $delay -Animate))
  }
}
[void]$sb.AppendLine('    <text x="35" y="86" fill="#484f58" font-family="Segoe UI, Arial, sans-serif" font-size="7" text-anchor="middle">+ mask tokens</text>')
[void]$sb.AppendLine('  </g>')

# Predicted latent
$gx = 400; $gy = 62
[void]$sb.AppendLine("  <g transform=`"translate($gx,$gy)`">")
[void]$sb.AppendLine('    <text x="22" y="-8" fill="#39d353" font-family="Segoe UI, Arial, sans-serif" font-size="9" font-weight="600" text-anchor="middle">z-hat predicted</text>')
for ($y = 0; $y -lt 10; $y++) {
  for ($x = 0; $x -lt 5; $x++) {
    $lvl = Get-GridLevel -x $x -y $y -Region "latent-pred"
    $delay = [Math]::Round(($y * 0.1 + $x * 0.05) % 2, 2)
    [void]$sb.AppendLine((Get-Cell -x $x -y $y -level $lvl -delay $delay -Animate))
  }
}
[void]$sb.AppendLine('  </g>')

# Full input (teacher path)
$gx = 24; $gy = 178
[void]$sb.AppendLine("  <g transform=`"translate($gx,$gy)`">")
[void]$sb.AppendLine('    <text x="52" y="-8" fill="#7d8590" font-family="Segoe UI, Arial, sans-serif" font-size="9" text-anchor="middle">Full image</text>')
for ($y = 0; $y -lt 7; $y++) {
  for ($x = 0; $x -lt 12; $x++) {
    $lvl = Get-GridLevel -x $x -y $y -Region "input-full"
    [void]$sb.AppendLine((Get-Cell -x $x -y $y -level $lvl))
  }
}
[void]$sb.AppendLine('  </g>')

# Target encoder
$gx = 168; $gy = 182
[void]$sb.AppendLine("  <g transform=`"translate($gx,$gy)`">")
[void]$sb.AppendLine('    <text x="22" y="-8" fill="#7d8590" font-family="Segoe UI, Arial, sans-serif" font-size="9" text-anchor="middle">Target</text>')
[void]$sb.AppendLine('    <text x="22" y="2" fill="#7d8590" font-family="Segoe UI, Arial, sans-serif" font-size="9" text-anchor="middle">Encoder</text>')
for ($y = 0; $y -lt 10; $y++) {
  for ($x = 0; $x -lt 5; $x++) {
    $lvl = [Math]::Max(0, (Get-GridLevel -x $x -y $y -Region "encoder") - 1)
    [void]$sb.AppendLine((Get-Cell -x $x -y $y -level $lvl))
  }
}
[void]$sb.AppendLine('    <text x="22" y="98" fill="#484f58" font-family="Segoe UI, Arial, sans-serif" font-size="7" text-anchor="middle">z_tgt</text>')
[void]$sb.AppendLine('  </g>')

# Target latent
$gx = 400; $gy = 182
[void]$sb.AppendLine("  <g transform=`"translate($gx,$gy)`">")
[void]$sb.AppendLine('    <text x="22" y="-8" fill="#7d8590" font-family="Segoe UI, Arial, sans-serif" font-size="9" text-anchor="middle">z target</text>')
for ($y = 0; $y -lt 10; $y++) {
  for ($x = 0; $x -lt 5; $x++) {
    $lvl = Get-GridLevel -x $x -y $y -Region "latent-tgt"
    [void]$sb.AppendLine((Get-Cell -x $x -y $y -level $lvl))
  }
}
[void]$sb.AppendLine('    <text x="22" y="98" fill="#484f58" font-family="Segoe UI, Arial, sans-serif" font-size="7" text-anchor="middle">stop-grad</text>')
[void]$sb.AppendLine('  </g>')

# Flow arrows (pixel-style dotted)
[void]$sb.AppendLine('  <path d="M142 95 H168" stroke="#39d353" stroke-width="1.5" marker-end="url(#arr)" fill="none" opacity="0.8"/>')
[void]$sb.AppendLine('  <path d="M228 95 H268" stroke="#39d353" stroke-width="1.5" marker-end="url(#arr)" fill="none" opacity="0.8"/>')
[void]$sb.AppendLine('  <path d="M358 95 H400" stroke="#39d353" stroke-width="1.5" marker-end="url(#arr)" fill="none" opacity="0.8"/>')
[void]$sb.AppendLine('  <path d="M142 215 H168" stroke="#484f58" stroke-width="1.2" marker-end="url(#arrDim)" fill="none" stroke-dasharray="4 3"/>')
[void]$sb.AppendLine('  <path d="M228 215 H400" stroke="#484f58" stroke-width="1.2" marker-end="url(#arrDim)" fill="none" stroke-dasharray="4 3"/>')
[void]$sb.AppendLine('  <path d="M190 162 C190 172, 190 172, 190 182" stroke="#7d8590" stroke-width="1" fill="none" stroke-dasharray="4 3" marker-end="url(#arrDim)"/>')
[void]$sb.AppendLine('  <text x="204" y="176" fill="#7d8590" font-family="Segoe UI, Arial, sans-serif" font-size="8">EMA</text>')

# L2 loss block
[void]$sb.AppendLine('  <g transform="translate(490, 108)">')
[void]$sb.AppendLine('    <rect width="88" height="88" rx="8" fill="#161b22" stroke="#30363d" stroke-width="1"/>')
[void]$sb.AppendLine('    <text x="44" y="28" fill="#39d353" font-family="Segoe UI, Arial, sans-serif" font-size="11" font-weight="700" text-anchor="middle">L2</text>')
[void]$sb.AppendLine('    <text x="44" y="44" fill="#7d8590" font-family="Segoe UI, Arial, sans-serif" font-size="8" text-anchor="middle">loss</text>')
[void]$sb.AppendLine('    <text x="44" y="62" fill="#484f58" font-family="Segoe UI, Arial, sans-serif" font-size="7" text-anchor="middle">||z-hat - z||</text>')
[void]$sb.AppendLine('    <text x="44" y="74" fill="#484f58" font-family="Segoe UI, Arial, sans-serif" font-size="7" text-anchor="middle">latent space</text>')
[void]$sb.AppendLine('  </g>')
[void]$sb.AppendLine('  <path d="M450 108 C470 108, 478 128, 490 140" stroke="#26a641" stroke-width="1.2" fill="none" stroke-dasharray="3 2"/>')
[void]$sb.AppendLine('  <path d="M450 228 C470 228, 478 188, 490 170" stroke="#006d32" stroke-width="1.2" fill="none" stroke-dasharray="3 2"/>')

# Right panel: semantic flow label + mini contribution calendar as "world model"
[void]$sb.AppendLine('  <g transform="translate(610, 58)">')
[void]$sb.AppendLine('    <text x="130" y="0" fill="#7d8590" font-family="Segoe UI, Arial, sans-serif" font-size="9" text-anchor="middle">Abstract prediction | no pixel decode</text>')
for ($y = 0; $y -lt 7; $y++) {
  for ($x = 0; $x -lt 26; $x++) {
    if (($x - 8) * ($x - 8) + ($y - 3) * ($y - 3) -lt 18) {
      $lvl = 2 + (($x + $y) % 3)
    } elseif (($x - 18) * ($x - 18) + ($y - 5) * ($y - 5) -lt 8) {
      $lvl = 3 + ($x % 2)
    } elseif (($x + $y) % 5 -eq 0) {
      $lvl = 1
    } else {
      $lvl = 0
    }
    $px = $x * ($cell + $gap); $py = 12 + $y * ($cell + $gap)
    $fill = $levels[[Math]::Min(4, [Math]::Max(0, [int]$lvl))]
    if ($lvl -gt 1) {
      [void]$sb.AppendLine("    <rect x=`"$px`" y=`"$py`" width=`"$cell`" height=`"$cell`" rx=`"2`" fill=`"$fill`" stroke=`"#21262d`" stroke-width=`"0.5`"><animate attributeName=`"fill`" values=`"#0e4429;$fill;#39d353;$fill`" dur=`"2.5s`" begin=`"$([Math]::Round(($x+$y)*0.03,2))s`" repeatCount=`"indefinite`"/></rect>")
    } else {
      [void]$sb.AppendLine("    <rect x=`"$px`" y=`"$py`" width=`"$cell`" height=`"$cell`" rx=`"2`" fill=`"$fill`" stroke=`"#21262d`" stroke-width=`"0.5`"/>")
    }
  }
}
[void]$sb.AppendLine('    <text x="130" y="92" fill="#484f58" font-family="Segoe UI, Arial, sans-serif" font-size="8" text-anchor="middle">semantic target representation</text>')
[void]$sb.AppendLine('  </g>')

# Legend
[void]$sb.AppendLine('  <text x="720" y="268" fill="#7d8590" font-family="Segoe UI, Arial, sans-serif" font-size="9">Less</text>')
for ($i = 0; $i -lt 5; $i++) {
  [void]$sb.AppendLine("  <rect x=`"$([int](748 + $i * 14))`" y=`"258`" width=`"10`" height=`"10`" rx=`"2`" fill=`"$($levels[$i])`" stroke=`"#21262d`" stroke-width=`"0.5`"/>")
}
[void]$sb.AppendLine('  <text x="830" y="268" fill="#7d8590" font-family="Segoe UI, Arial, sans-serif" font-size="9">More</text>')

# Animated flow dot
[void]$sb.AppendLine('  <circle r="3" fill="#39d353"><animateMotion dur="3.5s" repeatCount="indefinite" path="M130 95 H420"/><animate attributeName="opacity" values="0;1;1;0" keyTimes="0;0.08;0.92;1" dur="3.5s" repeatCount="indefinite"/></circle>')

[void]$sb.AppendLine('  <text x="460" y="292" fill="#484f58" font-family="Segoe UI, Arial, sans-serif" font-size="8" text-anchor="middle">visible context patches -> encode -> predict target embeddings | teacher path via EMA target encoder</text>')
[void]$sb.AppendLine('</svg>')

$content = $sb.ToString()
Set-Content -Path $OutPath -Value $content -Encoding UTF8
try { [xml]$content | Out-Null; Write-Host "Wrote $OutPath (valid XML)" } catch { Write-Error $_.Exception.Message }
