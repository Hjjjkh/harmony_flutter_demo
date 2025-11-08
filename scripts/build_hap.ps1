# HarmonyOS HAP 打包脚本
# 用于构建 HarmonyOS HAP 安装包

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
$flutterBuildPath = Join-Path $projectRoot "build\flutter_assets"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  HarmonyOS HAP 打包脚本" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "模式: $Mode" -ForegroundColor Yellow
Write-Host "构建 Flutter: $FlutterBuild" -ForegroundColor Yellow
Write-Host ""

Push-Location $projectRoot

try {
    # 清理构建产物
    if ($Clean) {
        Write-Host "清理构建产物..." -ForegroundColor Yellow
        if (Test-Path "build") {
            Remove-Item -Recurse -Force "build"
        }
        if (Test-Path "$ohosPath\build") {
            Remove-Item -Recurse -Force "$ohosPath\build"
        }
        Write-Host "✓ 清理完成" -ForegroundColor Green
        Write-Host ""
    }
    
    # 步骤 1: 构建 Flutter 应用
    if ($FlutterBuild) {
        Write-Host "步骤 1: 构建 Flutter 应用..." -ForegroundColor Yellow
        Write-Host ""
        
        # 检查 Flutter
        flutter doctor 2>&1 | Out-Null
        if ($LASTEXITCODE -ne 0) {
            Write-Host "错误: Flutter 未安装或配置不正确" -ForegroundColor Red
            exit 1
        }
        
        # 获取依赖
        Write-Host "  获取 Flutter 依赖..." -ForegroundColor Gray
        flutter pub get
        if ($LASTEXITCODE -ne 0) {
            Write-Host "错误: Flutter 依赖获取失败" -ForegroundColor Red
            exit 1
        }
        
        # 构建 Flutter 资源
        Write-Host "  构建 Flutter 资源..." -ForegroundColor Gray
        $buildMode = if ($Mode -eq "release") { "release" } else { "debug" }
        flutter build bundle --$buildMode
        
        if ($LASTEXITCODE -ne 0) {
            Write-Host "错误: Flutter 构建失败" -ForegroundColor Red
            exit 1
        }
        
        Write-Host "✓ Flutter 构建完成" -ForegroundColor Green
        Write-Host ""
        
        # 复制 Flutter 资源到鸿蒙项目
        Write-Host "  复制 Flutter 资源到鸿蒙项目..." -ForegroundColor Gray
        $ohosAssetsPath = Join-Path $ohosPath "entry\src\main\assets\flutter"
        
        if (-not (Test-Path $ohosAssetsPath)) {
            New-Item -ItemType Directory -Path $ohosAssetsPath -Force | Out-Null
        }
        
        if (Test-Path $flutterBuildPath) {
            Copy-Item -Path "$flutterBuildPath\*" -Destination $ohosAssetsPath -Recurse -Force
            Write-Host "✓ Flutter 资源已复制到鸿蒙项目" -ForegroundColor Green
        } else {
            Write-Host "⚠ 警告: Flutter 构建产物未找到，跳过资源复制" -ForegroundColor Yellow
        }
        Write-Host ""
    }
    
    # 步骤 2: 检查 DevEco Studio 环境
    Write-Host "步骤 2: 检查 DevEco Studio 环境..." -ForegroundColor Yellow
    
    # 检查 hvigorw 或 hvigor
    $hvigorwPath = Join-Path $ohosPath "hvigorw.bat"
    $hvigorPath = Join-Path $ohosPath "hvigor"
    
    if (-not (Test-Path $hvigorwPath) -and -not (Test-Path $hvigorPath)) {
        Write-Host "⚠ 警告: 未找到 hvigor 构建工具" -ForegroundColor Yellow
        Write-Host "  请确保在 DevEco Studio 中打开 ohos 目录并同步项目" -ForegroundColor Yellow
        Write-Host "  或者手动运行: cd ohos && hvigorw assembleHap" -ForegroundColor Yellow
        Write-Host ""
    }
    
    # 步骤 3: 构建 HAP
    Write-Host "步骤 3: 构建 HarmonyOS HAP..." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "请使用以下方式之一构建 HAP:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "方式 1: 使用 DevEco Studio" -ForegroundColor Cyan
    Write-Host "  1. 打开 DevEco Studio" -ForegroundColor White
    Write-Host "  2. 打开 ohos 目录" -ForegroundColor White
    Write-Host "  3. 选择 Build -> Build Hap(s)/APP(s) -> Build Hap(s)" -ForegroundColor White
    Write-Host ""
    Write-Host "方式 2: 使用命令行（需要先同步项目）" -ForegroundColor Cyan
    Write-Host "  cd ohos" -ForegroundColor White
    Write-Host "  .\hvigorw.bat assembleHap" -ForegroundColor White
    Write-Host ""
    Write-Host "方式 3: 使用 Gradle（如果已配置）" -ForegroundColor Cyan
    Write-Host "  cd ohos" -ForegroundColor White
    Write-Host "  gradlew assembleHap" -ForegroundColor White
    Write-Host ""
    
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  Flutter 构建完成" -ForegroundColor Green
    Write-Host "  请使用 DevEco Studio 完成 HAP 打包" -ForegroundColor Yellow
    Write-Host "========================================" -ForegroundColor Cyan
    
} catch {
    Write-Host "错误: $_" -ForegroundColor Red
    exit 1
} finally {
    Pop-Location
}

