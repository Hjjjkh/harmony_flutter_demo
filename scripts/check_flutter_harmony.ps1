# Check if Flutter is HarmonyOS-specific branch
# 检查 Flutter 是否为鸿蒙专属分支

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Flutter HarmonyOS Branch Check" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$flutterPath = (Get-Command flutter -ErrorAction SilentlyContinue).Source
if (-not $flutterPath) {
    Write-Host "[ERROR] Flutter not found in PATH" -ForegroundColor Red
    exit 1
}

$flutterSdkPath = Split-Path (Split-Path $flutterPath)
Write-Host "Flutter SDK Path: $flutterSdkPath" -ForegroundColor Yellow
Write-Host ""

# Check Flutter version
Write-Host "1. Checking Flutter version..." -ForegroundColor Yellow
$flutterVersion = flutter --version 2>&1 | Select-String "Flutter\s+([0-9.]+)" | ForEach-Object { $_.Matches.Groups[1].Value }
Write-Host "  Version: $flutterVersion" -ForegroundColor White
Write-Host ""

# Check Git remote
Write-Host "2. Checking Git remote repository..." -ForegroundColor Yellow
Push-Location $flutterSdkPath
try {
    $gitRemote = git remote -v 2>&1
    if ($gitRemote) {
        Write-Host "  Remote repositories:" -ForegroundColor White
        $gitRemote | ForEach-Object {
            Write-Host "    $_" -ForegroundColor Gray
        }
        
        # Check if it's HarmonyOS branch
        $isHarmonyOS = $false
        if ($gitRemote -match "harmony|openharmony|huawei") {
            $isHarmonyOS = $true
            Write-Host ""
            Write-Host "  [INFO] This appears to be a HarmonyOS-specific Flutter branch" -ForegroundColor Green
        } else {
            Write-Host ""
            Write-Host "  [INFO] This is the standard Flutter repository (github.com/flutter/flutter)" -ForegroundColor Yellow
        }
    } else {
        Write-Host "  [WARN] Cannot check Git remote (may not be a Git repository)" -ForegroundColor Yellow
    }
} catch {
    Write-Host "  [WARN] Cannot check Git remote: $_" -ForegroundColor Yellow
}
Write-Host ""

# Check current branch
Write-Host "3. Checking current Git branch..." -ForegroundColor Yellow
try {
    $gitBranch = git branch --show-current 2>&1
    if ($gitBranch -and $gitBranch -notmatch "fatal|error") {
        Write-Host "  Current branch: $gitBranch" -ForegroundColor White
    } else {
        Write-Host "  [WARN] Cannot determine current branch" -ForegroundColor Yellow
    }
} catch {
    Write-Host "  [WARN] Cannot check branch: $_" -ForegroundColor Yellow
}
Write-Host ""

# Check for HarmonyOS platform support
Write-Host "4. Checking for HarmonyOS platform support..." -ForegroundColor Yellow
$flutterDevices = flutter devices 2>&1
$hasHarmonyOS = $flutterDevices -match "harmony|openharmony"
if ($hasHarmonyOS) {
    Write-Host "  [OK] HarmonyOS devices detected in flutter devices" -ForegroundColor Green
} else {
    Write-Host "  [INFO] No HarmonyOS devices detected (this is normal)" -ForegroundColor Yellow
    Write-Host "    Standard Flutter does not directly support HarmonyOS platform" -ForegroundColor Gray
    Write-Host "    HarmonyOS development is done through:" -ForegroundColor Gray
    Write-Host "    - DevEco Studio for native development" -ForegroundColor Gray
    Write-Host "    - Platform Channel for Flutter-Native communication" -ForegroundColor Gray
}
Write-Host ""

# Check Flutter doctor
Write-Host "5. Checking Flutter doctor output..." -ForegroundColor Yellow
$flutterDoctor = flutter doctor -v 2>&1
$hasHarmonyOSInfo = $flutterDoctor -match "harmony|openharmony"
if ($hasHarmonyOSInfo) {
    Write-Host "  [OK] HarmonyOS information found in flutter doctor" -ForegroundColor Green
} else {
    Write-Host "  [INFO] No HarmonyOS information in flutter doctor (this is normal for standard Flutter)" -ForegroundColor Yellow
}
Write-Host ""

Pop-Location

# Summary
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Flutter Type: " -NoNewline -ForegroundColor Yellow
if ($isHarmonyOS) {
    Write-Host "HarmonyOS-specific branch" -ForegroundColor Green
    Write-Host ""
    Write-Host "This Flutter SDK is customized for HarmonyOS development." -ForegroundColor Green
} else {
    Write-Host "Standard Flutter (official)" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "This is the standard Flutter SDK from:" -ForegroundColor White
    Write-Host "  https://github.com/flutter/flutter.git" -ForegroundColor Gray
    Write-Host ""
    Write-Host "For HarmonyOS development:" -ForegroundColor Yellow
    Write-Host "  - Use DevEco Studio for native HarmonyOS development" -ForegroundColor White
    Write-Host "  - Use Platform Channel to communicate between Flutter and HarmonyOS" -ForegroundColor White
    Write-Host "  - The ohos/ directory contains HarmonyOS native code" -ForegroundColor White
    Write-Host ""
    Write-Host "Note: Standard Flutter does not directly support HarmonyOS as a platform," -ForegroundColor Gray
    Write-Host "      but you can develop HarmonyOS apps using the hybrid approach:" -ForegroundColor Gray
    Write-Host "      1. Flutter UI layer (lib/ directory)" -ForegroundColor Gray
    Write-Host "      2. HarmonyOS native layer (ohos/ directory)" -ForegroundColor Gray
    Write-Host "      3. Platform Channel for communication" -ForegroundColor Gray
}

Write-Host ""

