# SDK Check Script
# Check HarmonyOS SDK and Flutter SDK configuration

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  SDK Configuration Check" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$errors = @()
$warnings = @()

# Check Flutter SDK
Write-Host "1. Checking Flutter SDK..." -ForegroundColor Yellow
Write-Host ""

try {
    $flutterPath = flutter --version 2>&1 | Select-String "Flutter" | Select-Object -First 1
    if ($flutterPath) {
        Write-Host "  [OK] Flutter SDK installed" -ForegroundColor Green
        Write-Host "    $flutterPath" -ForegroundColor Gray
        
        # Get Flutter SDK path
        $flutterWhich = (Get-Command flutter -ErrorAction SilentlyContinue).Source
        if ($flutterWhich) {
            $flutterSdkPath = Split-Path (Split-Path $flutterWhich)
            Write-Host "    SDK Path: $flutterSdkPath" -ForegroundColor Gray
        }
        
        # Check Flutter version
        $flutterVersion = flutter --version 2>&1 | Select-String "Flutter\s+([0-9.]+)" | ForEach-Object { $_.Matches.Groups[1].Value }
        if ($flutterVersion) {
            Write-Host "    Version: $flutterVersion" -ForegroundColor Gray
        }
        
        # Check Dart version
        $dartVersion = dart --version 2>&1 | Select-String "Dart SDK version:\s+([0-9.]+)" | ForEach-Object { $_.Matches.Groups[1].Value }
        if ($dartVersion) {
            Write-Host "    Dart Version: $dartVersion" -ForegroundColor Gray
        }
    }
    else {
        $errors += "Flutter SDK not found"
        Write-Host "  [ERROR] Flutter SDK not found" -ForegroundColor Red
    }
}
catch {
    $errors += "Flutter SDK check failed: $_"
    Write-Host "  [ERROR] Flutter SDK check failed" -ForegroundColor Red
}

Write-Host ""

# Check Node.js
Write-Host "2. Checking Node.js..." -ForegroundColor Yellow
Write-Host ""

try {
    $nodeVersion = node --version 2>&1
    if ($nodeVersion) {
        Write-Host "  [OK] Node.js installed: $nodeVersion" -ForegroundColor Green
        
        $nodePath = (Get-Command node -ErrorAction SilentlyContinue).Source
        if ($nodePath) {
            Write-Host "    Path: $nodePath" -ForegroundColor Gray
        }
        
        # Check version
        $versionNum = $nodeVersion -replace 'v', '' -split '\.' | ForEach-Object { [int]$_ }
        if ($versionNum[0] -ge 16) {
            Write-Host "    Version OK (>= 16.0)" -ForegroundColor Gray
        }
        else {
            $warnings += "Node.js version too low, recommend upgrade to 16.0+"
            Write-Host "  [WARN] Version too low, recommend upgrade" -ForegroundColor Yellow
        }
    }
    else {
        $errors += "Node.js not installed"
        Write-Host "  [ERROR] Node.js not found" -ForegroundColor Red
    }
}
catch {
    $errors += "Node.js check failed: $_"
    Write-Host "  [ERROR] Node.js check failed" -ForegroundColor Red
}

Write-Host ""

# Check HarmonyOS SDK (DevEco Studio)
Write-Host "3. Checking HarmonyOS SDK (DevEco Studio)..." -ForegroundColor Yellow
Write-Host ""

$devecoPaths = @(
    "D:\Huawei\DevEco Studio\bin\devecostudio.exe",
    "C:\Program Files\Huawei\DevEco Studio\bin\devecostudio.exe",
    "C:\Program Files (x86)\Huawei\DevEco Studio\bin\devecostudio.exe"
)

$devecoFound = $false
$devecoExe = $null

foreach ($path in $devecoPaths) {
    if (Test-Path $path) {
        $devecoExe = $path
        $devecoFound = $true
        Write-Host "  [OK] DevEco Studio found" -ForegroundColor Green
        Write-Host "    Path: $path" -ForegroundColor Gray
        break
    }
}

if (-not $devecoFound) {
    # Check PATH
    $devecoInPath = $env:PATH -split ';' | Where-Object { $_ -like '*DevEco Studio*' }
    if ($devecoInPath) {
        $devecoExe = Join-Path $devecoInPath "devecostudio.exe"
        $devecoFound = $true
        Write-Host "  [OK] DevEco Studio in PATH" -ForegroundColor Green
        Write-Host "    Path: $devecoInPath" -ForegroundColor Gray
    }
}

if ($devecoFound) {
    # Check for SDK directory
    $sdkPaths = @(
        "$env:USERPROFILE\AppData\Local\OpenHarmony\Sdk",
        "$env:USERPROFILE\AppData\Local\Huawei\Sdk",
        "$env:USERPROFILE\.ohpm\sdk",
        "C:\Users\$env:USERNAME\AppData\Local\OpenHarmony\Sdk",
        "C:\Users\$env:USERNAME\AppData\Local\Huawei\Sdk",
        "C:\Users\$env:USERNAME\.ohpm\sdk"
    )
    
    $sdkFound = $false
    foreach ($sdkPath in $sdkPaths) {
        if (Test-Path $sdkPath) {
            Write-Host "  [OK] HarmonyOS SDK directory found" -ForegroundColor Green
            Write-Host "    SDK Path: $sdkPath" -ForegroundColor Gray
            
            # Check SDK contents
            $sdkContents = Get-ChildItem $sdkPath -ErrorAction SilentlyContinue
            if ($sdkContents) {
                Write-Host "    SDK Contents:" -ForegroundColor Gray
                foreach ($item in $sdkContents) {
                    if ($item.PSIsContainer) {
                        Write-Host "      - $($item.Name)/ (Directory)" -ForegroundColor DarkGray
                    }
                    else {
                        Write-Host "      - $($item.Name)" -ForegroundColor DarkGray
                    }
                }
                
                # Check for SDK version directories (usually numeric like "20", "21", etc.)
                $versionDirs = Get-ChildItem $sdkPath -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -match '^\d+$' }
                if ($versionDirs) {
                    Write-Host "    SDK Versions found:" -ForegroundColor Gray
                    foreach ($versionDir in $versionDirs | Sort-Object Name -Descending) {
                        Write-Host "      - Version $($versionDir.Name)" -ForegroundColor DarkGray
                    }
                }
            }
            
            $sdkFound = $true
            break
        }
    }
    
    if (-not $sdkFound) {
        $warnings += "HarmonyOS SDK directory not found. You may need to configure it in DevEco Studio."
        Write-Host "  [WARN] HarmonyOS SDK directory not found" -ForegroundColor Yellow
        Write-Host "    Expected locations:" -ForegroundColor Gray
        foreach ($sdkPath in $sdkPaths) {
            Write-Host "      - $sdkPath" -ForegroundColor DarkGray
        }
        Write-Host "    Please configure SDK in DevEco Studio:" -ForegroundColor Yellow
        Write-Host "      Tools -> SDK Manager -> HarmonyOS SDK" -ForegroundColor Yellow
    }
}
else {
    $errors += "DevEco Studio not found"
    Write-Host "  [ERROR] DevEco Studio not found" -ForegroundColor Red
    Write-Host "    Please install DevEco Studio from:" -ForegroundColor Yellow
    Write-Host "    https://developer.harmonyos.com/" -ForegroundColor Yellow
}

Write-Host ""

# Check project SDK configuration
Write-Host "4. Checking project SDK configuration..." -ForegroundColor Yellow
Write-Host ""

$projectRoot = Split-Path -Parent $PSScriptRoot

# Check pubspec.yaml
$pubspecPath = Join-Path $projectRoot "pubspec.yaml"
if (Test-Path $pubspecPath) {
    $pubspecContent = Get-Content $pubspecPath -Raw
    if ($pubspecContent -match "sdk:\s*([^\s]+)") {
        $sdkVersion = $matches[1]
        Write-Host "  [OK] Flutter SDK version in pubspec.yaml: $sdkVersion" -ForegroundColor Green
    }
}

# Check HarmonyOS build profile
$buildProfilePath = Join-Path $projectRoot "ohos\build-profile.json5"
if (Test-Path $buildProfilePath) {
    Write-Host "  [OK] HarmonyOS build profile found" -ForegroundColor Green
    $buildProfile = Get-Content $buildProfilePath -Raw
    if ($buildProfile -match '"apiType":\s*"([^"]+)"') {
        $apiType = $matches[1]
        Write-Host "    API Type: $apiType" -ForegroundColor Gray
    }
}

Write-Host ""

# Summary
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  SDK Check Results" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

if ($errors.Count -eq 0 -and $warnings.Count -eq 0) {
    Write-Host "[SUCCESS] All SDKs configured correctly!" -ForegroundColor Green
    Write-Host ""
    Write-Host "All required SDKs are installed and configured:" -ForegroundColor Green
    Write-Host "  - Flutter SDK: Ready" -ForegroundColor White
    Write-Host "  - Node.js: Ready" -ForegroundColor White
    Write-Host "  - DevEco Studio: Ready" -ForegroundColor White
    Write-Host "  - HarmonyOS SDK: Ready" -ForegroundColor White
    Write-Host ""
    Write-Host "You can now start developing!" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Optional: Open DevEco Studio to start coding" -ForegroundColor Gray
    Write-Host "  Run: .\scripts\open_deveco.ps1" -ForegroundColor DarkGray
    exit 0
}
elseif ($errors.Count -eq 0) {
    Write-Host "[SUCCESS] Basic SDKs configured, but there are warnings:" -ForegroundColor Yellow
    Write-Host ""
    foreach ($warning in $warnings) {
        Write-Host "  [WARN] $warning" -ForegroundColor Yellow
    }
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "1. Configure HarmonyOS SDK in DevEco Studio" -ForegroundColor White
    Write-Host "2. Tools -> SDK Manager -> HarmonyOS SDK" -ForegroundColor White
    exit 0
}
else {
    Write-Host "[ERROR] SDK configuration issues found:" -ForegroundColor Red
    Write-Host ""
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
    Write-Host ""
    Write-Host "Please fix the errors and run this script again." -ForegroundColor Yellow
    exit 1
}

