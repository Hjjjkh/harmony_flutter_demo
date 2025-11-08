# Flutter 构建脚本
# 用于构建 Flutter 应用

param(
    [Parameter(Mandatory=$false)]
    [ValidateSet("apk", "appbundle", "ios", "web", "windows", "linux", "macos")]
    [string]$Platform = "apk",
    
    [Parameter(Mandatory=$false)]
    [ValidateSet("debug", "profile", "release")]
    [string]$Mode = "release"
)

$projectRoot = Join-Path $PSScriptRoot ".."

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Flutter 构建脚本" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "平台: $Platform" -ForegroundColor Yellow
Write-Host "模式: $Mode" -ForegroundColor Yellow
Write-Host ""

Push-Location $projectRoot

try {
    # 检查 Flutter
    Write-Host "检查 Flutter 环境..." -ForegroundColor Yellow
    flutter doctor 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "错误: Flutter 未安装或配置不正确" -ForegroundColor Red
        exit 1
    }
    Write-Host "✓ Flutter 环境正常" -ForegroundColor Green
    Write-Host ""
    
    # 获取依赖
    Write-Host "获取依赖..." -ForegroundColor Yellow
    flutter pub get
    if ($LASTEXITCODE -ne 0) {
        Write-Host "错误: 依赖获取失败" -ForegroundColor Red
        exit 1
    }
    Write-Host "✓ 依赖获取成功" -ForegroundColor Green
    Write-Host ""
    
    # 分析代码
    Write-Host "分析代码..." -ForegroundColor Yellow
    flutter analyze
    if ($LASTEXITCODE -ne 0) {
        Write-Host "⚠ 代码分析发现问题，但继续构建..." -ForegroundColor Yellow
    } else {
        Write-Host "✓ 代码分析通过" -ForegroundColor Green
    }
    Write-Host ""
    
    # 构建应用
    Write-Host "构建应用..." -ForegroundColor Yellow
    $buildArgs = @("build", $Platform, "--$Mode")
    flutter $buildArgs
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Cyan
        Write-Host "  ✓ 构建成功！" -ForegroundColor Green
        Write-Host "========================================" -ForegroundColor Cyan
    } else {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Cyan
        Write-Host "  ✗ 构建失败" -ForegroundColor Red
        Write-Host "========================================" -ForegroundColor Cyan
        exit 1
    }
} catch {
    Write-Host "错误: $_" -ForegroundColor Red
    exit 1
} finally {
    Pop-Location
}

