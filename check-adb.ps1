param(
    [string]$AdbPath = 'adb',
    [ValidateRange(1, 65535)][int]$Port = 5037
)

$adb = Get-Command $AdbPath -CommandType Application -ErrorAction SilentlyContinue
if (-not $adb) {
    Write-Error '未找到 adb。请安装 Android SDK Platform-Tools，并将其加入 PATH 或指定 -AdbPath。'
    exit 1
}

$lines = & $adb.Source -P $Port devices 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Error 'ADB 调用失败。请检查指定的程序及端口。'
    exit 1
}

$states = @(
    foreach ($line in $lines) {
        if ($line -match '^\S+\s+(device|unauthorized|offline|recovery|sideload|bootloader|no permissions)(?:\s|$)') {
            $Matches[1]
        }
    }
)

if ($states.Count -eq 0) {
    Write-Output '未检测到设备。'
    exit 2
}
if ($states.Count -gt 1) {
    Write-Output '检测到多台设备，请只保留目标手机。'
    exit 2
}
switch ($states[0]) {
    'device' { Write-Output '手机已连接并授权。'; exit 0 }
    'unauthorized' { Write-Output '手机尚未授权，请在手机上确认 USB 调试提示。'; exit 2 }
    default { Write-Output '手机未处于可调试状态。'; exit 2 }
}
