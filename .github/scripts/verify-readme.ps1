param(
  [string]$ReadmePath = "README.md"
)

$ErrorActionPreference = "Stop"
$root = Resolve-Path (Join-Path $PSScriptRoot "../..")
Set-Location $root

Write-Host "Verifying README assets..." -ForegroundColor Cyan

$failures = 0

function Test-Asset {
  param([string]$Label, [string]$PathOrUrl, [switch]$Local)
  if ($Local) {
    $full = Join-Path $root $PathOrUrl
    if (Test-Path $full) {
      if ($full.EndsWith(".svg")) {
        try {
          [xml](Get-Content -Raw $full) | Out-Null
          Write-Host "OK   $Label ($PathOrUrl)" -ForegroundColor Green
        } catch {
          Write-Host "FAIL $Label invalid XML: $($_.Exception.Message)" -ForegroundColor Red
          $script:failures++
        }
      } else {
        Write-Host "OK   $Label ($PathOrUrl)" -ForegroundColor Green
      }
    } else {
      Write-Host "FAIL $Label missing local file: $PathOrUrl" -ForegroundColor Red
      $script:failures++
    }
    return
  }

  if ($url -match 'raw\.githubusercontent\.com/.+/output/') {
    Write-Host "WARN $Label HTTP $code (workflow asset; run Generate All Profile Assets if missing)" -ForegroundColor Yellow
    return
  }
    if ($response.StatusCode -ge 200 -and $response.StatusCode -lt 400) {
      Write-Host "OK   $Label ($($response.StatusCode))" -ForegroundColor Green
    } else {
      Write-Host "FAIL $Label HTTP $($response.StatusCode)" -ForegroundColor Red
      $script:failures++
    }
  } catch {
    $code = $_.Exception.Response.StatusCode.value__
    Write-Host "FAIL $Label HTTP $code" -ForegroundColor Red
    $script:failures++
  }
}

Test-Asset -Label "README file" -PathOrUrl $ReadmePath -Local
Test-Asset -Label "Transformer SVG" -PathOrUrl "assets/transformer-architecture.svg" -Local

$readme = Get-Content -Raw $ReadmePath
$matches = [regex]::Matches($readme, 'https?://[^\s"''\)]+')
$seen = @{}
foreach ($match in $matches) {
  $url = $match.Value.TrimEnd(')')
  if ($seen.ContainsKey($url)) { continue }
  $seen[$url] = $true
  if ($url -match 'mailto:|git\.io|linkedin\.com|github\.com/Aadik1ng|aadik1ng\.github\.io') { continue }
  Test-Asset -Label "URL" -PathOrUrl $url
}

if ($failures -gt 0) {
  Write-Host "`nVerification failed with $failures issue(s)." -ForegroundColor Red
  exit 1
}

Write-Host "`nAll README assets verified." -ForegroundColor Green
exit 0
