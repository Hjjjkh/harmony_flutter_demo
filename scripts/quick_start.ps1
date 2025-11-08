# 快速启动脚本
# 提供快速访问常用功能的菜单

function Show-Menu {
    Clear-Host
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  鸿蒙 Flutter 开发工具" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "请选择操作：" -ForegroundColor Yellow
    Write-Host "1. 检查开发环境" -ForegroundColor White
    Write-Host "2. 检查 SDK 配置" -ForegroundColor White
    Write-Host "3. 初始化项目" -ForegroundColor White
    Write-Host "4. 打开 DevEco Studio" -ForegroundColor White
    Write-Host "5. 获取 Flutter 依赖" -ForegroundColor White
    Write-Host "6. 分析代码" -ForegroundColor White
    Write-Host "7. 构建应用 (APK)" -ForegroundColor White
    Write-Host "8. 运行 Flutter 应用" -ForegroundColor White
    Write-Host "9. 查看项目信息" -ForegroundColor White
    Write-Host "0. 退出" -ForegroundColor White
    Write-Host ""
}

function Check-Environment {
    Write-Host "正在检查环境..." -ForegroundColor Yellow
    & "$PSScriptRoot\check_environment.ps1"
    Write-Host ""
    Write-Host "按任意键继续..." -ForegroundColor Gray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function Check-SDK {
    Write-Host "正在检查 SDK 配置..." -ForegroundColor Yellow
    & "$PSScriptRoot\check_sdk.ps1"
    Write-Host ""
    Write-Host "按任意键继续..." -ForegroundColor Gray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function Initialize-Project {
    Write-Host "正在初始化项目..." -ForegroundColor Yellow
    & "$PSScriptRoot\setup.ps1"
    Write-Host ""
    Write-Host "按任意键继续..." -ForegroundColor Gray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function Open-DevEco {
    Write-Host "正在打开 DevEco Studio..." -ForegroundColor Yellow
    & "$PSScriptRoot\open_deveco.ps1"
    Write-Host ""
    Write-Host "按任意键继续..." -ForegroundColor Gray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function Get-FlutterDependencies {
    $projectRoot = Join-Path $PSScriptRoot ".."
    Push-Location $projectRoot
    Write-Host "正在获取 Flutter 依赖..." -ForegroundColor Yellow
    flutter pub get
    Pop-Location
    Write-Host ""
    Write-Host "按任意键继续..." -ForegroundColor Gray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function Analyze-Code {
    $projectRoot = Join-Path $PSScriptRoot ".."
    Push-Location $projectRoot
    Write-Host "正在分析代码..." -ForegroundColor Yellow
    flutter analyze
    Pop-Location
    Write-Host ""
    Write-Host "按任意键继续..." -ForegroundColor Gray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function Build-App {
    Write-Host "正在构建应用..." -ForegroundColor Yellow
    & "$PSScriptRoot\build_flutter.ps1" -Platform apk -Mode release
    Write-Host ""
    Write-Host "按任意键继续..." -ForegroundColor Gray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function Run-FlutterApp {
    $projectRoot = Join-Path $PSScriptRoot ".."
    Push-Location $projectRoot
    Write-Host "正在运行 Flutter 应用..." -ForegroundColor Yellow
    Write-Host "提示: 按 'q' 退出应用" -ForegroundColor Gray
    flutter run
    Pop-Location
    Write-Host ""
    Write-Host "按任意键继续..." -ForegroundColor Gray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function Show-ProjectInfo {
    Clear-Host
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  项目信息" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    
    $projectRoot = Join-Path $PSScriptRoot ".."
    
    # 读取 pubspec.yaml
    if (Test-Path "$projectRoot\pubspec.yaml") {
        $pubspec = Get-Content "$projectRoot\pubspec.yaml" -Raw
        if ($pubspec -match "name:\s*(.+)") {
            Write-Host "项目名称: $($matches[1].Trim())" -ForegroundColor White
        }
        if ($pubspec -match "version:\s*(.+)") {
            Write-Host "版本: $($matches[1].Trim())" -ForegroundColor White
        }
    }
    
    Write-Host ""
    Write-Host "项目结构:" -ForegroundColor Yellow
    Write-Host "  lib/          - Flutter 代码" -ForegroundColor Gray
    Write-Host "  ohos/         - 鸿蒙平台代码" -ForegroundColor Gray
    Write-Host "  scripts/      - 脚本文件" -ForegroundColor Gray
    Write-Host "  .vscode/      - VS Code/Cursor 配置" -ForegroundColor Gray
    Write-Host ""
    Write-Host "重要文件:" -ForegroundColor Yellow
    Write-Host "  README.md              - 项目说明" -ForegroundColor Gray
    Write-Host "  NEXT_STEPS.md          - 下一步操作" -ForegroundColor Gray
    Write-Host "  USER_ACTION_REQUIRED.md - 用户操作指南" -ForegroundColor Gray
    Write-Host "  SETUP_CHECKLIST.md     - 配置检查清单" -ForegroundColor Gray
    Write-Host ""
    Write-Host "按任意键继续..." -ForegroundColor Gray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

# 主循环
do {
    Show-Menu
    $choice = Read-Host "请输入选项"
    
    switch ($choice) {
        "1" { Check-Environment }
        "2" { Check-SDK }
        "3" { Initialize-Project }
        "4" { Open-DevEco }
        "5" { Get-FlutterDependencies }
        "6" { Analyze-Code }
        "7" { Build-App }
        "8" { Run-FlutterApp }
        "9" { Show-ProjectInfo }
        "0" { 
            Write-Host "退出..." -ForegroundColor Yellow
            break 
        }
        default {
            Write-Host "无效选项，请重试" -ForegroundColor Red
            Start-Sleep -Seconds 1
        }
    }
} while ($choice -ne "0")

Write-Host "再见！" -ForegroundColor Green

