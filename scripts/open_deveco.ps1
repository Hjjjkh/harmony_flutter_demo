# 打开 DevEco Studio 脚本
# 用于快速打开 DevEco Studio 并加载 ohos 项目

$projectPath = Join-Path $PSScriptRoot "..\ohos"
$devecoPaths = @(
    "D:\Huawei\DevEco Studio\bin\devecostudio.exe",
    "C:\Program Files\Huawei\DevEco Studio\bin\devecostudio.exe",
    "C:\Program Files (x86)\Huawei\DevEco Studio\bin\devecostudio.exe"
)

$devecoExe = $null
foreach ($path in $devecoPaths) {
    if (Test-Path $path) {
        $devecoExe = $path
        break
    }
}

if (-not $devecoExe) {
    # 尝试从 PATH 中查找
    $devecoInPath = Get-Command devecostudio -ErrorAction SilentlyContinue
    if ($devecoInPath) {
        $devecoExe = $devecoInPath.Source
    }
}

if (-not $devecoExe) {
    Write-Host "错误: 未找到 DevEco Studio" -ForegroundColor Red
    Write-Host "请确保 DevEco Studio 已安装，或修改脚本中的路径" -ForegroundColor Yellow
    exit 1
}

Write-Host "正在打开 DevEco Studio..." -ForegroundColor Green
Write-Host "项目路径: $projectPath" -ForegroundColor Gray

# 检查项目路径是否存在
if (-not (Test-Path $projectPath)) {
    Write-Host "错误: 项目路径不存在: $projectPath" -ForegroundColor Red
    exit 1
}

# 打开 DevEco Studio
Start-Process -FilePath $devecoExe -ArgumentList $projectPath

Write-Host "✓ DevEco Studio 已启动" -ForegroundColor Green

