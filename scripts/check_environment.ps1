# Environment Check Script
# Check if development environment is configured correctly

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  OpenHarmony Flutter Development Environment Check" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$errors = @()
$warnings = @()

# Check Flutter
Write-Host "Checking Flutter..." -ForegroundColor Yellow
try {
    $flutterVersion = flutter --version 2>&1 | Select-String "Flutter" | Select-Object -First 1
    if ($flutterVersion) {
        Write-Host "  [OK] Flutter installed" -ForegroundColor Green
        Write-Host "    $flutterVersion" -ForegroundColor Gray
    } else {
        $errors += "Flutter not installed or not in PATH"
        Write-Host "  [ERROR] Flutter not found" -ForegroundColor Red
    }
} catch {
    $errors += "Flutter check failed: $_"
    Write-Host "  [ERROR] Flutter check failed" -ForegroundColor Red
}

Write-Host ""

# Check Node.js
Write-Host "Checking Node.js..." -ForegroundColor Yellow
try {
    $nodeVersion = node --version 2>&1
    if ($nodeVersion) {
        Write-Host "  [OK] Node.js installed: $nodeVersion" -ForegroundColor Green
        
        # Check version >= 16.0
        $versionNum = $nodeVersion -replace 'v', '' -split '\.' | ForEach-Object { [int]$_ }
        if ($versionNum[0] -ge 16) {
            Write-Host "   Version OK (>= 16.0)" -ForegroundColor Gray
        } else {
            $warnings += "Node.js version too low, recommend upgrade to 16.0+"
            Write-Host "  [WARN] Version too low, recommend upgrade" -ForegroundColor Yellow
        }
    } else {
        $errors += "Node.js not installed"
        Write-Host "  [ERROR] Node.js not found" -ForegroundColor Red
    }
} catch {
    $errors += "Node.js check failed: $_"
    Write-Host "  [ERROR] Node.js check failed" -ForegroundColor Red
}

Write-Host ""

# Check DevEco Studio
Write-Host "Checking DevEco Studio..." -ForegroundColor Yellow
$devecoPaths = @(
    "D:\Huawei\DevEco Studio\bin\devecostudio.exe",
    "C:\Program Files\Huawei\DevEco Studio\bin\devecostudio.exe",
    "C:\Program Files (x86)\Huawei\DevEco Studio\bin\devecostudio.exe"
)

$devecoFound = $false
foreach ($path in $devecoPaths) {
    if (Test-Path $path) {
        Write-Host "  [OK] DevEco Studio installed" -ForegroundColor Green
        Write-Host "    Path: $path" -ForegroundColor Gray
        $devecoFound = $true
        break
    }
}

if (-not $devecoFound) {
    # Check PATH for DevEco Studio
    $devecoInPath = $env:PATH -split ';' | Where-Object { $_ -like '*DevEco Studio*' }
    if ($devecoInPath) {
        Write-Host "  [OK] DevEco Studio in PATH" -ForegroundColor Green
        Write-Host "    Path: $devecoInPath" -ForegroundColor Gray
        $devecoFound = $true
    } else {
        $warnings += "DevEco Studio not found, please ensure it is installed"
        Write-Host "  [WARN] DevEco Studio not found" -ForegroundColor Yellow
    }
}

Write-Host ""

# Check Dart
Write-Host "Checking Dart..." -ForegroundColor Yellow
try {
    $dartVersion = dart --version 2>&1 | Select-String "Dart" | Select-Object -First 1
    if ($dartVersion) {
        Write-Host "  [OK] Dart installed" -ForegroundColor Green
        Write-Host "    $dartVersion" -ForegroundColor Gray
    } else {
        $warnings += "Dart not in PATH (may be included in Flutter)"
        Write-Host "  [WARN] Dart not in PATH" -ForegroundColor Yellow
    }
} catch {
    Write-Host "  [WARN] Dart check failed (may be included in Flutter)" -ForegroundColor Yellow
}

Write-Host ""

# Check project files
Write-Host "Checking project files..." -ForegroundColor Yellow
$projectRoot = Split-Path -Parent $PSScriptRoot
$requiredFiles = @(
    "pubspec.yaml",
    "lib/main.dart",
    "ohos/build-profile.json5",
    "ohos/AppScope/app.json5",
    "ohos/entry/src/main/module.json5"
)

$missingFiles = @()
foreach ($file in $requiredFiles) {
    $filePath = Join-Path $projectRoot $file
    if (Test-Path $filePath) {
        Write-Host "  [OK] $file" -ForegroundColor Green
    } else {
        $missingFiles += $file
        Write-Host "  [ERROR] $file missing" -ForegroundColor Red
    }
}

if ($missingFiles.Count -gt 0) {
    $errors += "Missing required files: $($missingFiles -join ', ')"
}

Write-Host ""

# Check Flutter dependencies
Write-Host "Checking Flutter dependencies..." -ForegroundColor Yellow
$pubspecPath = Join-Path $projectRoot "pubspec.yaml"
if (Test-Path $pubspecPath) {
    try {
        Push-Location $projectRoot
        flutter pub get 2>&1 | Out-Null
        if ($LASTEXITCODE -eq 0) {
            Write-Host "  [OK] Flutter dependencies installed" -ForegroundColor Green
        } else {
            $warnings += "Flutter dependencies installation may have issues"
            Write-Host "  [WARN] Flutter dependencies installation issues" -ForegroundColor Yellow
        }
        Pop-Location
    } catch {
        Write-Host "  [WARN] Cannot check Flutter dependencies" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Check Results" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

if ($errors.Count -eq 0 -and $warnings.Count -eq 0) {
    Write-Host "[SUCCESS] All checks passed! Environment configured correctly." -ForegroundColor Green
    exit 0
} elseif ($errors.Count -eq 0) {
    Write-Host "[SUCCESS] Basic checks passed, but there are warnings:" -ForegroundColor Yellow
    foreach ($warning in $warnings) {
        Write-Host "  [WARN] $warning" -ForegroundColor Yellow
    }
    exit 0
} else {
    Write-Host "[ERROR] Errors found:" -ForegroundColor Red
    foreach ($error in $errors) {
        Write-Host "  [ERROR] $error" -ForegroundColor Red
    }
    if ($warnings.Count -gt 0) {
        Write-Host ""
        Write-Host "Warnings:" -ForegroundColor Yellow
        foreach ($warning in $warnings) {
            Write-Host "  [WARN] $warning" -ForegroundColor Yellow
        }
    }
    exit 1
}
