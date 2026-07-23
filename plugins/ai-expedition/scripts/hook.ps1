param(
  [Parameter(Position = 0)]
  [ValidateSet('start', 'complete')]
  [string]$Action
)

$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
$apiOrigin = 'https://ai-expedition-forge.automl141115.chatgpt.site'
$dataDirectory = Join-Path $env:LOCALAPPDATA 'AI Expedition'

try {
  $eventJson = [Console]::In.ReadToEnd()
  $event = if ($eventJson) { $eventJson | ConvertFrom-Json } else { [pscustomobject]@{} }
  $sessionId = if ($event.session_id) { [string]$event.session_id } else { 'unknown-session' }
  $sha = [System.Security.Cryptography.SHA256]::Create()
  try {
    $hashBytes = $sha.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($sessionId))
  } finally {
    $sha.Dispose()
  }
  $sessionKey = ([System.BitConverter]::ToString($hashBytes)).Replace('-', '').Substring(0, 24).ToLowerInvariant()
  $statePath = Join-Path $dataDirectory "active-$sessionKey.json"
  $devicePath = Join-Path $dataDirectory 'device.json'
  if (-not (Test-Path -LiteralPath $devicePath)) { exit 0 }

  $device = Get-Content -LiteralPath $devicePath -Raw | ConvertFrom-Json
  if (-not $device.token) { exit 0 }
  $headers = @{ Authorization = "Bearer $($device.token)" }
  New-Item -ItemType Directory -Path $dataDirectory -Force | Out-Null

  if ($Action -eq 'start') {
    $state = [ordered]@{
      turnId = [guid]::NewGuid().ToString()
      sessionKey = $sessionKey
      startedAt = [DateTime]::UtcNow.ToString('o')
    }
    $body = @{ turnId = $state.turnId; pluginVersion = '0.1.0' } | ConvertTo-Json -Compress
    Invoke-RestMethod -Uri "$apiOrigin/api/expeditions/start" -Method Post -Headers $headers -ContentType 'application/json' -Body $body -TimeoutSec 3 | Out-Null
    $state | ConvertTo-Json -Compress | Set-Content -LiteralPath $statePath -Encoding UTF8
    exit 0
  }

  if (-not (Test-Path -LiteralPath $statePath)) { exit 0 }
  $state = Get-Content -LiteralPath $statePath -Raw | ConvertFrom-Json
  $body = @{ turnId = $state.turnId } | ConvertTo-Json -Compress
  Invoke-RestMethod -Uri "$apiOrigin/api/expeditions/complete" -Method Post -Headers $headers -ContentType 'application/json' -Body $body -TimeoutSec 3 | Out-Null
  Remove-Item -LiteralPath $statePath -Force
} catch {
  # Ranking failures must never interrupt Codex work.
  exit 0
}
