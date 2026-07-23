$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

try {
  $apiOrigin = 'https://ai-expedition-forge.automl141115.chatgpt.site'
  $dataDirectory = if ($env:PLUGIN_DATA) { $env:PLUGIN_DATA } else { Join-Path $env:LOCALAPPDATA 'AI Expedition' }
  $devicePath = Join-Path $dataDirectory 'device.json'
  if (-not (Test-Path -LiteralPath $devicePath)) {
    throw 'No saved connection was found.'
  }

  $device = Get-Content -LiteralPath $devicePath -Raw | ConvertFrom-Json
  if (-not $device.token) {
    throw 'No saved device credential was found.'
  }

  $headers = @{ Authorization = "Bearer $($device.token)" }
  $result = Invoke-RestMethod -Uri "$apiOrigin/api/devices/status" -Method Post -Headers $headers -ContentType 'application/json' -Body '{}' -TimeoutSec 5
  $signal = if ($result.connection.lastExpeditionStatus -eq 'complete') {
    'start and completion signals received'
  } elseif ($result.connection.lastExpeditionStatus -eq 'running') {
    'start signal received; waiting for completion'
  } else {
    'connected; no expedition signal yet'
  }

  Write-Output "AI Expedition: $signal"
  Write-Output "This week: $($result.connection.weeklyExpeditions) expeditions; longest: $($result.connection.longestExpeditionSeconds)s; lifetime: $($result.progress.lifetimeExpeditions)"
  if (-not $result.connection.lastExpeditionStatus) {
    Write-Output 'If new Codex tasks still do not record, review and trust the AI Expedition hook in /hooks.'
  }
} catch {
  Write-Error "Could not check AI Expedition status: $($_.Exception.Message)"
  exit 1
}
