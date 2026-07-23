param(
  [Parameter(Mandatory = $true, Position = 0)]
  [string]$Code
)

$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
$Code = $Code.Trim().ToUpperInvariant()
if ($Code -notmatch '^[2-9A-HJ-NP-Z]{6}$') {
  Write-Error '연결 코드 6자리를 입력해주세요.'
  exit 1
}

try {
  $apiOrigin = 'https://ai-expedition-forge.automl141115.chatgpt.site'
  $body = @{
    code = $Code
    label = 'Windows Codex'
    pluginVersion = '0.1.0'
  } | ConvertTo-Json -Compress
  $result = Invoke-RestMethod -Uri "$apiOrigin/api/devices/pair" -Method Post -ContentType 'application/json' -Body $body -TimeoutSec 5
  $dataDirectory = Join-Path $env:LOCALAPPDATA 'AI Expedition'
  New-Item -ItemType Directory -Path $dataDirectory -Force | Out-Null
  [ordered]@{
    deviceId = $result.deviceId
    token = $result.token
    connectedAt = [DateTime]::UtcNow.ToString('o')
  } | ConvertTo-Json -Compress | Set-Content -LiteralPath (Join-Path $dataDirectory 'device.json') -Encoding UTF8
  Write-Output 'AI 원정대 연결이 완료되었습니다. 다음 Codex 작업부터 랭킹에 반영됩니다.'
} catch {
  Write-Error "연결하지 못했습니다: $($_.Exception.Message)"
  exit 1
}
