# 项目初始化脚本
# 用于初始化项目环境

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  项目初始化脚本" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$projectRoot = Join-Path $PSScriptRoot ".."
Push-Location $projectRoot

try {
    # 检查 Flutter
    Write-Host "检查 Flutter 环境..." -ForegroundColor Yellow
    $flutterCheck = flutter doctor 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "警告: Flutter 环境检查失败" -ForegroundColor Yellow
    } else {
        Write-Host "✓ Flutter 环境正常" -ForegroundColor Green
    }
    Write-Host ""
    
    # 获取 Flutter 依赖
    Write-Host "获取 Flutter 依赖..." -ForegroundColor Yellow
    flutter pub get
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Flutter 依赖获取成功" -ForegroundColor Green
    } else {
        Write-Host "✗ Flutter 依赖获取失败" -ForegroundColor Red
    }
    Write-Host ""
    
    # 分析代码
    Write-Host "分析代码..." -ForegroundColor Yellow
    flutter analyze
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ 代码分析通过" -ForegroundColor Green
    } else {
        Write-Host "⚠ 代码分析发现问题" -ForegroundColor Yellow
    }
    Write-Host ""
    
    # 检查项目文件
    Write-Host "检查项目文件..." -ForegroundColor Yellow
    $requiredFiles = @(
        "pubspec.yaml",
        "lib/main.dart",
        "ohos/build-profile.json5",
        "ohos/AppScope/app.json5",
        "ohos/entry/src/main/module.json5"
    )
    
    $allFilesExist = $true
    foreach ($file in $requiredFiles) {
        if (Test-Path $file) {
            Write-Host "  ✓ $file" -ForegroundColor Green
        } else {
            Write-Host "  ✗ $file 缺失" -ForegroundColor Red
            $allFilesExist = $false
        }
    }
    
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  初始化完成" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    
    if ($allFilesExist) {
        Write-Host "✓ 项目初始化成功！" -ForegroundColor Green
        Write-Host ""
        Write-Host "下一步：" -ForegroundColor Yellow
        Write-Host "1. 配置 DevEco Studio（如果还未配置）" -ForegroundColor White
        Write-Host "2. 运行 scripts/check_environment.ps1 检查环境" -ForegroundColor White
        Write-Host "3. 运行 scripts/open_deveco.ps1 打开 DevEco Studio" -ForegroundColor White
    } else {
        Write-Host "⚠ 项目初始化完成，但缺少一些文件" -ForegroundColor Yellow
    }
    
} catch {
    Write-Host "错误: $_" -ForegroundColor Red
    exit 1
} finally {
    Pop-Location
}

