# HarmonyOS HAP 打包脚本（Gradle 方式）
# 使用 Gradle 构建 HAP 安装包

param(
    [Parameter(Mandatory=$false)]
    [ValidateSet("debug", "release")]
    [string]$Mode = "release",
    
    [Parameter(Mandatory=$false)]
    [switch]$FlutterBuild = $true,
    
    [Parameter(Mandatory=$false)]
    [switch]$Clean = $false
)

$projectRoot = Join-Path $PSScriptRoot ".."
$ohosPath = Join-Path $projectRoot "ohos"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  HarmonyOS HAP 打包脚本 (Gradle)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Push-Location $ohosPath

try {
    # 检查 Gradle
    Write-Host "检查 Gradle 环境..." -ForegroundColor Yellow
    $gradleCmd = "gradlew.bat"
    if (-not (Get-Command $gradleCmd -ErrorAction SilentlyContinue)) {
        # 尝试使用项目中的 gradlew
        if (Test-Path "gradlew.bat") {
            $gradleCmd = ".\gradlew.bat"
        } elseif (Test-Path "hvigorw.bat") {
            Write-Host "使用 hvigor 构建工具..." -ForegroundColor Yellow
            $gradleCmd = ".\hvigorw.bat"
        } else {
            Write-Host "错误: 未找到构建工具" -ForegroundColor Red
            Write-Host "请确保在 DevEco Studio 中同步项目" -ForegroundColor Yellow
            exit 1
        }
    }
    
    # 清理
    if ($Clean) {
        Write-Host "清理构建产物..." -ForegroundColor Yellow
        & $gradleCmd clean
        Write-Host ""
    }
    
    # 构建 Flutter（如果需要）
    if ($FlutterBuild) {
        Push-Location $projectRoot
        Write-Host "构建 Flutter 应用..." -ForegroundColor Yellow
        $buildMode = if ($Mode -eq "release") { "release" } else { "debug" }
        flutter build bundle --$buildMode
        Pop-Location
        Write-Host ""
    }
    
    # 构建 HAP
    Write-Host "构建 HarmonyOS HAP..." -ForegroundColor Yellow
    $task = if ($Mode -eq "release") { "assembleHap" } else { "assembleHap" }
    
    if ($gradleCmd -like "*hvigor*") {
        & $gradleCmd assembleHap --mode $Mode
    } else {
        & $gradleCmd $task
    }
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Cyan
        Write-Host "  ✓ HAP 构建成功！" -ForegroundColor Green
        Write-Host "========================================" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "HAP 文件位置: ohos\entry\build\outputs\hap\default" -ForegroundColor Yellow
    } else {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Cyan
        Write-Host "  ✗ HAP 构建失败" -ForegroundColor Red
        Write-Host "========================================" -ForegroundColor Cyan
        exit 1
    }
    
} catch {
    Write-Host "错误: $_" -ForegroundColor Red
    exit 1
} finally {
    Pop-Location
}

