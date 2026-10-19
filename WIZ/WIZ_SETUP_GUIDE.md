# WIZ 4-Light Control System - Setup Guide

## System Overview

Your WIZ smart light control system is now configured and ready to use. This system includes:
- 4 individual light control batch files
- A master control panel for managing all lights
- PowerShell scripting support for automation
- Comprehensive test suite
- Configuration file for easy customization

## Light Configuration

| Light | IP Address | Location | Batch File |
|-------|-----------|----------|-----------|
| Light 1 | 192.168.0.151 | Living Room | `light1_control.bat` |
| Light 2 | 192.168.0.208 | Bedroom | `light2_control.bat` |
| Light 3 | 192.168.0.243 | Kitchen | `light3_control.bat` |
| Light 4 | 192.168.0.140 | Office | `light4_control.bat` |

## Quick Start

### Using the Master Control Panel (Easiest)
```
double-click: wiz_master_control.bat
```

This opens an interactive menu where you can:
- Turn all lights ON or OFF
- Control individual lights
- Set brightness for all or specific lights
- Run the test suite

### Testing Your System
```
double-click: test_all_lights.bat
```

This will:
1. Test connectivity to all 4 lights
2. Turn each light on
3. Set brightness on each light
4. Verify everything is working properly

## Advanced Usage

### Individual Light Control (Batch Files)

Control a single light from the command line:

```batch
REM Turn light ON
light1_control.bat on

REM Turn light OFF
light1_control.bat off

REM Set brightness (0-100)
light1_control.bat brightness 75

REM Set color (hex RGB value)
light1_control.bat color FF0000
```

### PowerShell Scripting

For advanced automation and scripting:

```powershell
# Turn all lights on
.\WizLightControl.ps1 allon

# Turn all lights off
.\WizLightControl.ps1 alloff

# Turn on Light 1 only
.\WizLightControl.ps1 on 1

# Set Light 2 brightness to 50%
.\WizLightControl.ps1 brightness 2 50

# Test all lights
.\WizLightControl.ps1 test
```

### Creating Automation Scripts

Create a new batch file to automate your lighting. Example:

```batch
@echo off
REM Morning Routine - Gradually brighten lights

echo Starting morning routine...
call light1_control.bat brightness 20
call light2_control.bat brightness 20
call light3_control.bat brightness 20
call light4_control.bat brightness 20
timeout /t 30 /nobreak

call light1_control.bat brightness 40
call light2_control.bat brightness 40
call light3_control.bat brightness 40
call light4_control.bat brightness 40
timeout /t 30 /nobreak

call light1_control.bat brightness 75
call light2_control.bat brightness 75
call light3_control.bat brightness 75
call light4_control.bat brightness 75

echo Morning routine complete!
```

## Configuration

### Customizing Light Names/Locations

Edit `wiz_config.json` to change light names and locations:

```json
{
  "lights": [
    {
      "name": "Light 1",
      "ip": "192.168.0.151",
      "id": "light1",
      "location": "Living Room"
    }
  ]
}
```

### Changing Port (if needed)

If your WIZ lights use a different port than 38899:
1. Edit each `light*_control.bat` file
2. Change `set PORT=38899` to your port number
3. Edit `WizLightControl.ps1` and change `$Port = 38899`

## API Reference

### WIZ Light JSON-RPC API

All commands use the WIZ proprietary JSON-RPC protocol on port 38899.

#### Turn Light On/Off

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "method": "setPilot",
  "params": {
    "state": true  // true = on, false = off
  }
}
```

#### Set Brightness

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "method": "setPilot",
  "params": {
    "state": true,
    "brightness": 75  // 0-100
  }
}
```

#### Set Color (RGB)

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "method": "setPilot",
  "params": {
    "state": true,
    "c": {
      "r": 255,
      "g": 0,
      "b": 0
    }
  }
}
```

## Troubleshooting

### Lights Not Responding

**Problem:** Test shows lights as unreachable
- Verify lights are powered on
- Check that IP addresses are correct and static
- Ensure firewall isn't blocking port 38899
- Try pinging the light: `ping 192.168.0.151`

### Commands Not Working

**Problem:** Lights don't respond to control commands
- Ensure lights are on the same WiFi network
- Check if lights need to be reset
- Try turning light off/on at the physical switch
- Run test suite again

### Batch Files Won't Run

**Problem:** "Access Denied" or batch files won't execute
- Right-click → Run as Administrator
- Check file permissions
- Ensure PowerShell execution policy allows scripts

### Enable PowerShell Scripts (if needed)

```powershell
# Run PowerShell as Administrator, then:
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

## Files Included

- `wiz_master_control.bat` - Main control panel
- `light1_control.bat` - Light 1 individual control
- `light2_control.bat` - Light 2 individual control
- `light3_control.bat` - Light 3 individual control
- `light4_control.bat` - Light 4 individual control
- `test_all_lights.bat` - Comprehensive test suite
- `WizLightControl.ps1` - PowerShell control script
- `wiz_config.json` - Configuration file
- `WIZ_SETUP_GUIDE.md` - This guide

## Next Steps

1. **Run the test suite** - `test_all_lights.bat` to verify all lights work
2. **Try the master control panel** - `wiz_master_control.bat` for basic control
3. **Experiment with individual scripts** for specific light control
4. **Create custom automation** using the examples provided
5. **Check the WIZ app** on your phone to verify lights are working

## Support & Notes

- WIZ lights require static IP addresses or DHCP reservations for reliable control
- Network connectivity is required for all commands to work
- The system uses standard HTTP requests, so no special drivers are needed
- All scripts are safe to run multiple times

## Performance Tips

- Set static IP addresses for all lights in your router
- Keep all devices on the same WiFi network
- Test connectivity occasionally with the test suite
- For large automation scripts, add small delays between commands

---

**System Setup Date:** 2026-08-16
**Configuration:** 4 WIZ Smart Lights
**API Version:** Standard WIZ JSON-RPC

Enjoy your automated lighting system!
