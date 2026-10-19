# SCOP'D v2.1 — Black Ops II sniper build

Cronus Zen / GPC. Offline, bot lobbies, campaign. File: `SCOPD_V6.gpc`.

---

## What changed in v2.1

Display only — no mod, timing or trickshot behaviour changed.

**The eyes were redrawn from scratch.** v2.0 built each eye out of five
hand-placed line segments plus a circle, which is why the pair never looked
like a pair: the two eyes had different outlines, the corners didn't meet, and
the iris sat off to one side of a lopsided socket. Both lids are now the same
parametric curve, mirrored, so the eye is a true almond that closes cleanly at
both corners. The brow is a tapered wedge that points at both ends, and its
drop is accumulated in 1/8 px and rounded once — quantising an arc term and a
tilt term separately is what made the old stroke visibly ragged.

**The idle screen has the tear now.** v2.0 only ran it during boot. Idle now
runs a full cycle — the bead wells at the right eye's outer corner, falls with
acceleration leaving a wobbling streak, then the streak dries from the top
down — roughly every 5.6 s (`TEAR_CYCLE`).

**IDLE VIEW actually does something.** It was declared on the DISPLAY page and
then never read: `draw_idle` always drew the eyes, and `draw_view_scope`,
`draw_view_binds` and `idle_update` were dead code that never ran. All three
are wired in, and the option's values changed from `AUTO / SCOPE / BINDS` to
`EYES / SCOPE / BINDS / CYCLE`.

**Blinking is animated.** It used to snap between open and a flat line. It now
plays six aperture frames — squint, sliver, shut, sliver, squint — closing
faster than it opens, which is what makes it read as a blink instead of a
dropped frame.

**Two new DISPLAY options:** EYE LOOK and TEAR. The page is now five rows.

Old saved settings still load. EYE LOOK and TEAR are stored inverted in
`SPVAR_2` so that the 0 bits in a pre-v2.1 save mean ON, not OFF.

---

## What changed in v2.0

**Trickshots no longer use combos.** A GPC combo is a straight line — every
`wait()` pushes the next thing later, so the spin couldn't start until the cancel
had finished. That's why v1 felt slow and why nothing happened at the same time.

v2 compiles each trickshot into **independent time windows**, one per control
track, and plays them all in parallel. Measured on TEMPER with default timings:

| | v1 (serial combo) | v2 (sequencer) |
|---|---|---|
| Total length | 1230 ms | **690 ms** |
| Spin starts at | 460 ms | **0 ms** |
| YY cancel done at | 460 ms | **170 ms**, while the spin is still running |

**No auto-scope, no auto-fire.** Nothing in the trickshot engine touches L2 or
R2. The macro handles the movement and the cancels; you scope and you shoot.

**Every gap is tunable** on the TS TIMING page — see below.

**Compose your own** on the SLOT EDIT page from four components.

---

## Feature list

### Aim
- **Aim assist enhancer** — CIRCLE / PULSE / STRAFE / FULL, with power, speed and
  trigger condition (scoped / firing / both / always)
- **Hip assist** — enhancer also runs when firing un-scoped
- **Scope bait** — forces the sway on for the first 400 ms after you scope, the
  window where BO2's assist is stickiest, then gets out of the way
- **Snap aim** — taps ADS off/on to re-trigger the initial assist snap, with an
  adjustable nudge in a chosen direction

### Breath
- **Auto hold breath** — OFF / ALWAYS / SMART / DELAY
- **SMART** only holds once your finger is on the trigger, so the meter is full
  when you need it
- **Auto rest** — cycles hold/release so you never drain the meter dry

### Shooting
- **Quickscope** — auto-fire at the settle point, with delay and hold
- **Auto rescope** — drops and re-raises the scope after each shot
- **Bolt cancel** — swap-swap to cut the rechamber animation short
- **Reload cancel**
- **Rapid fire + anti-recoil** for the semi-auto snipers (SVU-AS, XPR-50)
- **Hair trigger** with adjustable activation point

### Movement
- Drop shot, jump shot, auto sprint, YY cancel, dive assist, turbo melee

### Trickshots
- **21 macros**, 8 bindable slots (4 bare D-pad + 4 with a modifier)
- **4 composable custom slots**
- **Parallel sequencer** with full timing control
- Bound directions are swallowed; unbound ones pass through so you keep
  scorestreaks on the directions you don't use
- Pressing a bound direction mid-sequence **aborts** it

### Display
- **Three idle screens**, picked by IDLE VIEW — see below
- Boot: the lids part over ~400 ms, a bead wells at the right eye, then runs
  down for the rest of the boot window before the title card
- Blink on a timer (~3.3 s apart, `BLINK_PERIOD`), six animated frames
- Iris drift on two periods, so the gaze traces a slow figure instead of
  sliding back and forth on one axis
- Idle tear cycle, ~5.6 s apart (`TEAR_CYCLE`)
- 15-page menu, 5 rows per page (scrolls on pages with more), active-mod chips

### System
- 6 weapon presets, master kill switch, per-line reset, all settings persisted

---

## Trickshot list

Every macro is a named **(PRE, CANCEL, SPIN, FINISH)** combination. That's the
whole vocabulary — the library entries are just presets, and the SLOT EDIT page
lets you build any combination that isn't listed.

| Macro | PRE | CANCEL | SPIN | FINISH |
|---|---|---|---|---|
| `180` | — | — | 180 | — |
| `360` | — | — | 360 | — |
| `540` | — | — | 540 | — |
| `720` | — | — | 720 | — |
| `1080` | — | — | 1080 | — |
| `YY180` | — | YY | 180 | — |
| `YY360` | — | YY | 360 | — |
| `YY720` | — | YY | 720 | — |
| `YYY360` | — | YYY | 360 | — |
| `JMP360` | Jump | — | 360 | — |
| `JMPYY` | Jump | YY | 360 | — |
| `DRP360` | — | — | 360 | Prone |
| `DIV360` | Dive | — | 360 | — |
| `TEMPER` | Jump | YY | 360 | Swap |
| `AXE360` | — | Axe | 360 | — |
| `RLD360` | — | Reload | 360 | — |
| `BARREL` | Swap-out | YY | 360 | — |
| `SLOTA`–`SLOTD` | *whatever you compose* | | | |

### The components

**PRE MOVE** — what happens before the cancel

| | |
|---|---|
| `NONE` | straight into the spin |
| `JUMP` | tap jump, then `PRE x10` ms before cancels begin |
| `DIVE` | sprint for `PRE x10` ms, then prone — the dolphin dive |
| `SWAP` | swap out first (barrel roll setup) |
| `PRONE` | drop to prone and stay down |

**CANCEL** — the animation cancel that makes it look clean

| | |
|---|---|
| `NONE` | no cancel |
| `YY` | two swap taps — the standard cancel |
| `YYY` | three taps, longer cancel chain |
| `RELOAD` | start a reload, then YY-cancel it |
| `AXE` | throw the combat axe, then YY-cancel the throw |
| `MELEE` | melee, then YY-cancel it |

**SPIN** — `NONE` / `180` / `360` / `540` / `720` / `1080`, all derived from your
one calibrated SPIN 360ms.

**FINISH** — `NONE` / `PRONE` / `MELEE` / `SWAP`, fired after both the cancels
and the spin have finished.

### Stock custom slots
| Slot | Composition |
|---|---|
| **A** | Jump + YY + 360 |
| **B** | Dive + 720 |
| **C** | Axe cancel + 360 + prone finish |
| **D** | Swap-out + reload cancel + 540 + swap finish |

### Not included
Ladder stalls, top spins and jump-off-building shots are **position**-dependent,
not input sequences — a macro can't know where you're standing. Do those
manually; this handles the input tech.

`AXE` needs a Combat Axe as lethal. `SWAP` finishers want a secondary worth
swapping to. Cancel timings assume **Fast Hands**.

---

## Timing — how to tune it

This is the page that fixes "too slow" and "doesn't work". Everything on TS
TIMING is in milliseconds unless marked `x10`.

| Setting | What it does | Default | Try |
|---|---|---|---|
| **TAP ms** | How long each button is held (swap, reload, axe, melee) | 30 | 20 if cancels don't register as taps; 45 if they get dropped entirely |
| **GAP ms** | Space between consecutive taps in a YY/YYY | 30 | **This is the YY rhythm.** Lower = tighter cancel. 20–40 is the useful band |
| **LEAD x10** | Delay before the spin starts | 0 | Leave at 0 for maximum overlap. Raise if you want the pre-move to land first |
| **PRE x10** | How long the pre-move runs before cancels begin | 8 (80 ms) | Raise for DIVE if the dive doesn't commit; lower for JUMP to cancel earlier in the arc |
| **TAIL x10** | Dead time after the sequence before control returns | 6 (60 ms) | Raise if your own inputs collide with the end of a macro |

**How to tune, in order:**

1. **SPIN 360ms first.** Bind `360`, stand facing a landmark, press it.
   Over-rotated → lower. Under → raise. Step by 5. Then check `720`; small errors
   compound — 3% long is invisible on a 360 and 32° off on a 1080.
2. **GAP next.** Bind `YY360`. If the cancel isn't cancelling, GAP is too wide —
   the game read two separate weapon swaps instead of a cancel. Drop it 5 at a time.
3. **TAP only if GAP alone doesn't fix it.** Too short and the game misses the
   press entirely; too long and it's a deliberate swap, not a cancel.
4. **PRE last**, and only for JUMP and DIVE macros.

The sequence total is now the **longest** track, not the sum, so tightening TAP
and GAP shortens the cancel without shortening the spin. They're independent now.

---

## Eight binds

- **TS BINDS** — fires on a bare D-pad press
- **TS BINDS+** — fires while the **MODIFIER** is held

The modifier is swallowed so it can't leak into the game. **Use L3** (the
default): holding it only sprints, and you're standing still when you set up.
Never map it to a grenade button — BO2 *cooks* lethals on hold, so an L1/R1
modifier means you're holding a live grenade through the entire macro.

**SPIN DIR = AUTO** makes D-Left spin left and D-Right spin right; Up and Down
default to right.

### A layout that works
| Direction | Bare | + Modifier (L3) |
|---|---|---|
| **UP** | `360` | `720` |
| **DOWN** | `YY360` | `1080` |
| **LEFT** | `DRP360` | `TEMPER` |
| **RIGHT** | `JMP360` | `YYY360` |

Up/Down are the plain spins with the modifier escalating rotation count.
Left/Right carry the movement shots escalating into the showpieces. This is what
the `TRICK` preset loads.

---

## The idle screen

**IDLE VIEW** on page 14 picks what sits on the OLED when you're not in the
menu. All of it is cosmetic — nothing here touches the mods.

| Value | What you get |
|---|---|
| `EYES` | SCOP'D over a mil-dot ladder, the eyes below it, blinking, looking around, and shedding a tear on a cycle |
| `SCOPE` | The live range — a runner crosses the board, the crosshair eases onto him, locks, fires, and he ragdolls into debris. **The easing speed is driven by AA POWER**, so the screen is showing you how aggressive your aim assist is set. Full-bleed, with the active-mod chips along the bottom |
| `BINDS` | Your four bare D-pad trickshot binds, with a D-pad graphic showing which direction is lighting up |
| `CYCLE` | Rotates the three above, about six seconds each |

### The other DISPLAY lines
| Setting | Default | What it does |
|---|---|---|
| **EYE BLINK** | ON | OFF holds the eyes open. Also freezes the D-pad graphic on the BINDS screen |
| **EYE LOOK** | ON | Iris drift. OFF stares straight ahead |
| **TEAR** | ON | The idle tear cycle. OFF leaves a dry face — the boot tear still runs |
| **RUMBLE** | ON | Menu haptics |

The face geometry is all defines at the top of the OLED scene block —
`EYE_LX` / `EYE_RX` (centres), `EYE_BY` (brow), `EYE_EY` (eye line), `EYE_W`
(half-width), `EYE_AP` (how wide open), `TEAR_X`. Move any of them and both
the boot and idle screens follow.

---

## Controls
| Action | Input |
|---|---|
| Open / close menu | hold **L2** + tap **OPTIONS** |
| Master arm / disarm | hold **L2** + tap **SHARE** |
| Move cursor | **D-Up / D-Down** |
| Change value | **D-Left / D-Right** (hold ~0.4 s to fast-scroll) |
| Page | **L1 / R1** |
| Toggle / run action | **CROSS** |
| Reset line to default | **TRIANGLE** |
| Save + exit | **CIRCLE** |

### Pages
1 AIM ASSIST · 2 SCOPE IN · 3 BREATH · 4 QUICKSCOPE · 5 BOLT WORK · 6 SEMI AUTO ·
7 MOVEMENT · 8 TRIGGERS · 9 TRICKSHOT · 10 TS TIMING · 11 TS BINDS ·
12 TS BINDS+ · 13 SLOT EDIT · 14 DISPLAY · 15 SYSTEM

**DISPLAY** is five rows: IDLE VIEW, EYE BLINK, EYE LOOK, TEAR, RUMBLE.

**SLOT EDIT** shows one slot at a time and scrolls — EDIT SLOT, SPIN, and all
8 STEP lines live on this one page now (no separate SLOT STEPS page). Change
**EDIT SLOT** to load A/B/C/D into the editor lines; edit those lines and they
write straight back to that slot.

---

## Compile notes
- **GPC has no local variables.** All working vars are top level, prefixed by the
  function that owns them.
- **Combos take `set_val` and `wait` only** — no `if`, no `call`. That constraint
  is exactly why the trickshot sequencer is a *function* walking a window table
  rather than a set of combos.
- **`print` takes a data-section address, not a literal**, and there's no `%d`.
  Text lives in const string tables; numbers go through `print_num()`.
- **The Zen has 64 SPVARs per slot** (16 is the CronusMAX figure). v2 uses 22.
- A pvar is a **signed 16-bit int**, so every pack must stay under 32767. Binds
  pack three to a pvar at 5 bits each (max 22197); slots pack four components at
  3 bits each (max 1900).
- **`get_pvar` hits EEPROM** — only ever called from `init`, never the main loop.
- **`wait()` tops out near 4000 ms**; `ts_build()` caps total spin at 3600.
- **Screen budget:** header `y 0..11`, rows `y 15/25/35/45/55`, labels `x 3`
  (10 chars), values `x 76` (6 chars), scrollbar `x 121..125`. Five rows is the
  hard ceiling.
- Adding a menu line means four edits in step: the `O_*` define, the matching
  `LBL[]` entry at the same index, a `reg()` call, and the page's `pg_count`.
