param(
    [Parameter(ValueFromPipeline=$true)]
    [string]$Action,
    [string]$LightNumber,
    [int]$Brightness,
    [string]$Color
)

$ErrorActionPreference = 'SilentlyContinue'

$lights = @{
    1 = @{ IP = "192.168.0.151"; Name = "Light 1 (Living Room)" }
    2 = @{ IP = "192.168.0.208"; Name = "Light 2 (Bedroom)" }
    3 = @{ IP = "192.168.0.243"; Name = "Light 3 (Kitchen)" }
    4 = @{ IP = "192.168.0.140"; Name = "Light 4 (Office)" }
}

$Port = 38899

function Send-WizCommand {
    param(
        [string]$IP,
        [hashtable]$Params
    )

    $body = @{
        jsonrpc = "2.0"
        id = 1
        method = "setPilot"
        params = $Params
    } | ConvertTo-Json

    try {
        $response = Invoke-WebRequest -Uri "http://${IP}:${Port}/api/rpc" `
            -Method POST `
            -Body $body `
            -ContentType 'application/json' `
            -TimeoutSec 3 `
            -ErrorAction Stop
        return $true
    }
    catch {
        return $false
    }
}

function Test-Light {
    param([int]$Light)

    $ip = $lights[$Light].IP
    $name = $lights[$Light].Name

    $body = @{
        jsonrpc = "2.0"
        id = 1
        method = "getPilot"
        params = @{}
    } | ConvertTo-Json

    try {
        Invoke-WebRequest -Uri "http://${ip}:${Port}/api/rpc" `
            -Method POST `
            -Body $body `
            -ContentType 'application/json' `
            -TimeoutSec 2 `
            -ErrorAction Stop | Out-Null
        Write-Host "[OK] $name is reachable" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host "[FAIL] $name is not responding" -ForegroundColor Red
        return $false
    }
}

function Set-LightOn {
    param([int]$Light)

    $ip = $lights[$Light].IP
    $name = $lights[$Light].Name

    if (Send-WizCommand -IP $ip -Params @{ state = $true }) {
        Write-Host "$name is now ON" -ForegroundColor Green
    }
    else {
        Write-Host "Failed to turn on $name" -ForegroundColor Red
    }
}

function Set-LightOff {
    param([int]$Light)

    $ip = $lights[$Light].IP
    $name = $lights[$Light].Name

    if (Send-WizCommand -IP $ip -Params @{ state = $false }) {
        Write-Host "$name is now OFF" -ForegroundColor Green
    }
    else {
        Write-Host "Failed to turn off $name" -ForegroundColor Red
    }
}

function Set-LightBrightness {
    param(
        [int]$Light,
        [int]$Brightness
    )

    if ($Brightness -lt 0 -or $Brightness -gt 100) {
        Write-Host "Brightness must be 0-100" -ForegroundColor Red
        return
    }

    $ip = $lights[$Light].IP
    $name = $lights[$Light].Name

    if (Send-WizCommand -IP $ip -Params @{ state = $true; brightness = $Brightness }) {
        Write-Host "$name brightness set to ${Brightness}%" -ForegroundColor Green
    }
    else {
        Write-Host "Failed to set brightness on $name" -ForegroundColor Red
    }
}

function Set-AllOn {
    Write-Host "Turning ALL lights ON..." -ForegroundColor Cyan
    1..4 | ForEach-Object { Set-LightOn -Light $_ }
}

function Set-AllOff {
    Write-Host "Turning ALL lights OFF..." -ForegroundColor Cyan
    1..4 | ForEach-Object { Set-LightOff -Light $_ }
}

function Set-AllBrightness {
    param([int]$Brightness)
    Write-Host "Setting ALL lights brightness to ${Brightness}%..." -ForegroundColor Cyan
    1..4 | ForEach-Object { Set-LightBrightness -Light $_ -Brightness $Brightness }
}

function Test-AllLights {
    Write-Host "`n================================================" -ForegroundColor Cyan
    Write-Host "   WIZ Smart Light System - Test Suite" -ForegroundColor Cyan
    Write-Host "================================================`n" -ForegroundColor Cyan

    1..4 | ForEach-Object {
        Write-Host "[TEST $_] $($lights[$_].Name)"
        Test-Light -Light $_
        Write-Host ""
    }

    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host "   All tests complete!" -ForegroundColor Cyan
    Write-Host "================================================" -ForegroundColor Cyan
}

# Usage examples
if ($Action) {
    switch ($Action.ToLower()) {
        "allon" { Set-AllOn }
        "alloff" { Set-AllOff }
        "test" { Test-AllLights }
        "on" {
            if ($LightNumber) {
                Set-LightOn -Light [int]$LightNumber
            } else {
                Set-AllOn
            }
        }
        "off" {
            if ($LightNumber) {
                Set-LightOff -Light [int]$LightNumber
            } else {
                Set-AllOff
            }
        }
        "brightness" {
            if ($LightNumber -and $Brightness) {
                Set-LightBrightness -Light [int]$LightNumber -Brightness $Brightness
            } else {
                Write-Host "Usage: brightness <light> <0-100>" -ForegroundColor Yellow
            }
        }
        default {
            Write-Host @"
WIZ Light Control Script

Usage:
  .\WizLightControl.ps1 allon                    # Turn all lights on
  .\WizLightControl.ps1 alloff                   # Turn all lights off
  .\WizLightControl.ps1 test                     # Test all lights
  .\WizLightControl.ps1 on [light#]              # Turn light on (all if no number)
  .\WizLightControl.ps1 off [light#]             # Turn light off (all if no number)
  .\WizLightControl.ps1 brightness <light#> <0-100>  # Set brightness

Examples:
  .\WizLightControl.ps1 on 1                     # Turn on Light 1
  .\WizLightControl.ps1 off 3                    # Turn off Light 3
  .\WizLightControl.ps1 brightness 2 50          # Set Light 2 to 50% brightness
"@ -ForegroundColor Yellow
        }
    }
}
else {
    Write-Host @"
WIZ Light Control Script

Usage:
  .\WizLightControl.ps1 allon                    # Turn all lights on
  .\WizLightControl.ps1 alloff                   # Turn all lights off
  .\WizLightControl.ps1 test                     # Test all lights
  .\WizLightControl.ps1 on [light#]              # Turn light on (all if no number)
  .\WizLightControl.ps1 off [light#]             # Turn light off (all if no number)
  .\WizLightControl.ps1 brightness <light#> <0-100>  # Set brightness

Examples:
  .\WizLightControl.ps1 on 1                     # Turn on Light 1
  .\WizLightControl.ps1 off 3                    # Turn off Light 3
  .\WizLightControl.ps1 brightness 2 50          # Set Light 2 to 50% brightness
"@ -ForegroundColor Yellow
}
