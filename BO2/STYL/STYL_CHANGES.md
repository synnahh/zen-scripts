# STYL v5.7 — Menu Cleanup & Branding Pass

## Major Changes

### 1. Removed Non-Trickshot Tabs
Streamlined the menu to focus exclusively on trickshot mechanics. Removed:
- **AIM ASSIST** (page 6)
- **BREATH** (page 7) — disabled by default
- **QUICKSCOPE** (page 8)
- **BOLT WORK** (page 9)
- **MOVEMENT** (page 10)
- **DISPLAY** (page 11)
- **SYSTEM** (page 12)
- **STEAL EMBLEM** (page 13)

**Remaining pages (7 total):**
1. TRICKSHOT — bind the trick library or custom slots
2. TS BINDS — button bindings
3. TS TIMING — per-tick calibration (TAP, GAP, STAGE, FIN, TAIL, LEAD)
4. CALIBRATE — spin reference + error logging
5. TS BINDS+ — macro modifiers (bind to D-PAD/M+)
6. SLOT EDIT — custom slot builder
7. CAN TUNE — timing multipliers (RLD/AXE/MEL MULT) + FADE HOLD/GAP

### 2. Rebranding: SCOPD → STYL
- Updated header and all references
- Boot sequence now displays **STYL** with style
- Idle display shows **STYL** below the eyes (OLED_FONT_MEDIUM)
- Status bar updated

### 3. Display Cleanup
- Simplified idle view to show only TRICKSHOT status + on/off
- Removed multi-mode status display (QUICKSCOPE, STEAL EMBLEM)
- Boot sequence reflects trickshot-only focus

## Technical Notes
- All non-trickshot code remains in the script but is disabled by default (BREATH, QUICKSCOPE, BOLT WORK, STEAL EMBLEM)
- Option array indices unchanged — removing pages only affects menu structure, not internal arrays
- Page navigation now cycles through 7 pages instead of 15

## Flow
Everything now follows a single thread: **bind a move → set timing → calibrate → arm → shoot**. No context switching between unrelated weapon configs.
