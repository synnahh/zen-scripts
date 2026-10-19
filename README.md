<div align="center">

# 🎮 Zen Scripts

**A personal library of controller macros, smart-home utilities and helper tools.**

![Scripts](https://img.shields.io/badge/scripts-GPC%20%2B%20batch%20%2B%20PowerShell-6E40C9)
![Private](https://img.shields.io/badge/repo-private-critical)

</div>

---

## 🗂️ What's inside

| Folder | Contents | Format |
|---|---|---|
| 🔫 `BO2/` | Black Ops II macro sets (CELERIUM, SCOPD and trickshot notes) | `.gpc`, `.md` |
| ⚽ `FC25/` | FC 25 controller layouts | `.gpc` |
| ⚽ `FC26/` | FC 26 controller layouts | `.gpc` |
| 🧪 `IDEAS/` | Drafts and experiments | `.gpc` |
| 💡 `WIZ/` | WiZ smart-light control suite | `.bat`, `.ps1`, `.json`, `.md` |
| 🧰 `BO2 EMBLEM KIT/` | Black Ops II emblem toolkit (Python) | `.py`, `.md` |

## 💡 WiZ light control

A small toolkit for controlling WiZ smart bulbs on your local network.

```
WIZ/
├── wiz_config.json          # light names, IPs and locations
├── WizLightControl.ps1      # core PowerShell controller
├── wiz_master_control.bat   # control every light at once
├── light1..4_control.bat    # per-light control
├── test_all_lights.bat      # connectivity check
└── WIZ_SETUP_GUIDE.md       # setup walkthrough
```

Start with the [setup guide](WIZ/WIZ_SETUP_GUIDE.md) and the [quick reference](WIZ/QUICK_REFERENCE.txt).

## 🧰 BO2 Emblem Kit

A Python toolkit with a local web UI. See its own [README](BO2%20EMBLEM%20KIT/README.md), [install guide](BO2%20EMBLEM%20KIT/docs/INSTALL.md) and [usage guide](BO2%20EMBLEM%20KIT/docs/USAGE.md).

## 🚀 Usage

- **Macros (`.gpc`)** are loaded onto a compatible controller adapter.
- **Batch and PowerShell** scripts run on Windows.
- **Python tools** need Python 3 and the packages in `requirements.txt`.

## ⚠️ Notes

- Published privately. Keep it that way while it contains game-specific macros.
- Compiled binaries are deliberately excluded (see [`.gitignore`](.gitignore)). They are not built from this repo and are not verified.
- Use these scripts for personal, offline or single-player practice. Using macros in online play may breach a game's terms of service.

---

<div align="center">

*Scripts for the calm, the precise and the playful.* ✨

</div>
