# SCOP'D v3.0 — Black Ops II sniper build

Cronus Zen / GPC. Offline, bot lobbies, campaign. File: `SCOPD_V7.gpc`.

---

## What changed in v3.0

### Trickshots are sectioned now

v2.0 made the *spin* parallel and then laid every button press end to end.
A jump-cancel shot was jump → wait → swap → wait → swap, three serial taps
that all had to finish before anything felt like it had started. And a custom
slot was eight loose "steps" with no idea what any of them meant — which is
why the README described `(PRE, CANCEL, SPIN, FINISH)` while the code stored
something else entirely.

Every trickshot is now four named sections that **deliberately overlap**:

```
  PRE     ├──┤
  CANCEL      ├─┤   ├─┤
  SPIN    ├──────────────────────┤
  FINISH                            ├──┤
          0      80  132        648  688
```

- **CANCEL starts `PRE x10` *into* the pre-move, not after it.** The YY lands
  while you're still coming off the jump.
- **SPIN** runs on its own clock from `LEAD x10`, straight through both.
- **FINISH** fires `FIN x10` after whichever of CANCEL and SPIN ends last.

`JMPYY` measured: jump at 0 ms, the two swap taps at 80 and 132 ms, spin
running 0 → 648 ms underneath all of it. Total 708 ms.

### The spin has an envelope

Flat 100 % deflection starts and stops like a switch, and that was most of
what still looked robotic. **SPIN RAMP** blends in a whip-out / carry / settle
curve.

The catch worth knowing about: a ramp gives away deflection area, so a naive
ramp would quietly under-rotate every shot and break your `SPIN 360ms`
calibration. The compiler lengthens the spin window by exactly the area the
envelope gives up. Measured across the full range:

| RAMP | window | rotation vs flat |
|---|---|---|
| 0 | 600 ms | — |
| 25 | 621 ms | +0.17 % |
| 55 | 668 ms | +0.16 % |
| 100 | 696 ms | +0.18 % |

So the ramp changes how a spin *feels* without moving where you end up
pointing. Tune it freely; you never have to re-calibrate.

### Three new behaviours

- **ABORT ON** *(OFF / FIRE / ADS / BOTH, default ADS)* — the moment you
  scope, the macro drops the stick and hands control back mid-spin. Bail out
  when the shot's already there.
- **HOLD LOOP** *(default OFF)* — keep the direction held and the trickshot
  repeats. For grinding the same shot back to back in a bot lobby. A fresh
  *press* still aborts, so the two can't fight: `event_press` can't retrigger
  from a held button.
- **TIMELINE** *(default OFF, on the DISPLAY page)* — fire a trickshot and the
  OLED paints the compiled windows as bars, one row per section, with a
  playhead that runs with the macro and the total on the header. Then the idle
  screen comes back untouched. See the spacing standing in an empty lobby
  instead of guessing at it in a match.

### Display

- **Eyes are bigger** — 33 px wide instead of 27, spread wider apart, on both
  the boot and idle screens. Still leaves the drip room for the tear.
- **The mil-dot ladder under the title is gone.** It hung twenty graduated
  ticks directly above the eyes and fought the face for attention. Replaced
  with a nameplate rule: two stacked hairlines of different length with the
  ends kicked up into a bracket.
- **The boot loading dashes are gone.** They read as screen tearing. Replaced
  with a bracketed track — quarter ticks inside, a solid fill, and a bright
  leading edge that overruns them.

### Your saved settings survive

The slot format and the macro numbering both changed, so a v2 save can't just
be read back — but `SPIN 360ms` is the one number you can only get by standing
in a lobby and testing. So v3 migrates instead of wiping:

| | |
|---|---|
| **Kept** | SPIN 360ms, TAP, GAP, LEAD, every mod setting, every toggle |
| **Remapped** | all 8 binds, pushed through a translation table so `TEMPER` stays `TEMPER` instead of silently becoming `YYY360` |
| **Reset** | the four custom slots (eight loose steps have no honest translation into four sections), plus the new options |

It runs once and rewrites in the new format.

---

## The macro library

25 macros now, up from 15. Every one is a named `(PRE, CANCEL, SPIN, FINISH)`
combination — the library is nothing but presets over the same four fields the
custom slots use, so a name and its behaviour can't drift apart.

| Macro | PRE | CANCEL | SPIN | FINISH | Length |
|---|---|---|---|---|---|
| `180` | — | — | 180 | — | 324 |
| `360` | — | — | 360 | — | 648 |
| `540` | — | — | 540 | — | 972 |
| `720` | — | — | 720 | — | 1297 |
| `900` | — | — | 900 | — | 1621 |
| `1080` | — | — | 1080 | — | 1945 |
| `YY180` | — | YY | 180 | — | 324 |
| `YY360` | — | YY | 360 | — | 648 |
| `YY540` | — | YY | 540 | — | 972 |
| `YY720` | — | YY | 720 | — | 1297 |
| `YY1080` | — | YY | 1080 | — | 1945 |
| `YYY360` | — | YYY | 360 | — | 648 |
| `YYY720` | — | YYY | 720 | — | 1297 |
| `JMP360` | JUMP | — | 360 | — | 648 |
| `JMP720` | JUMP | — | 720 | — | 1297 |
| `JMPYY` | JUMP | YY | 360 | — | 648 |
| `DRP360` | — | — | 360 | PRONE | 1028 |
| `DRPYY` | — | YY | 360 | PRONE | 1028 |
| `DIV360` | DIVE | — | 360 | — | 648 |
| `DIV720` | DIVE | — | 720 | — | 1297 |
| `TEMPER` | JUMP | YY | 360 | SWAP | 716 |
| `AXE360` | — | AXE | 360 | — | 648 |
| `RLD360` | — | RELOAD | 360 | — | 648 |
| `MEL360` | — | MELEE | 360 | — | 648 |
| `BARREL` | SWAP | YY | 360 | — | 648 |

Lengths are at stock timings with `SPIN 360ms = 60` and `RAMP = 55`.

### The components

**PRE** — what happens before the cancel

| | |
|---|---|
| `NONE` | straight in |
| `JUMP` | tap jump; cancels begin `PRE x10` into the arc |
| `DIVE` | sprint, then prone — the dolphin dive |
| `SWAP` | swap out first (barrel roll setup) |
| `PRONE` | drop and stay down |
| `CROUCH` | quick crouch |
| `SPRINT` | hold sprint for `PRE x10` |

**CANCEL** — the animation cut that makes it look clean

| | |
|---|---|
| `NONE` · `YY` · `YYY` · `YYYY` | bare swap chains, two to four taps |
| `RELOAD` · `AXE` · `MELEE` · `TAC` | start the animation, then YY-cancel it |

**SPIN** — `NONE / 180 / 360 / 540 / 720 / 900 / 1080`, all derived from your
one calibrated SPIN 360ms.

**FINISH** — `NONE / PRONE / MELEE / SWAP / CROUCH / JUMP / RELOAD`.

That's 7 × 8 × 7 × 7 = **2 744 possible trickshots**. All of them compile;
worst case uses 8 of the 12 window slots.

### Stock custom slots
| Slot | PRE | CANCEL | SPIN | FINISH |
|---|---|---|---|---|
| **A** | JUMP | YY | 360 | — |
| **B** | DIVE | — | 720 | — |
| **C** | — | AXE | 360 | PRONE |
| **D** | SWAP | RELOAD | 540 | SWAP |

### Not included
Ladder stalls, top spins and jump-off-building shots are **position**-dependent,
not input sequences — a macro can't know where you're standing. Do those
manually; this handles the input tech.

`AXE` needs a Combat Axe as lethal. `SWAP` finishers want a secondary worth
swapping to. Cancel timings assume **Fast Hands**.

---

## Timing — how to tune it

Everything on TS TIMING is milliseconds unless marked `x10`.

| Setting | What it does | Default |
|---|---|---|
| **TAP ms** | how long each button is held | 28 |
| **GAP ms** | space between taps inside a cancel chain — *this is the YY rhythm* | 24 |
| **LEAD x10** | delay before the spin starts | 0 |
| **PRE x10** | how far into the pre-move the cancel chain begins | 8 (80 ms) |
| **FIN x10** | gap after CANCEL/SPIN before the finish fires | 4 (40 ms) |
| **TAIL x10** | dead time before control returns | 6 (60 ms) |

**Tune in this order:**

1. **SPIN 360ms.** Bind `360`, face a landmark, fire. Over-rotated → lower.
   Step by 5. Then check `1080` — small errors compound, and 3 % long is
   invisible on a 360 and 32° off on a 1080.
2. **GAP.** Bind `YY360`. If the cancel isn't cancelling, GAP is too wide — the
   game read two separate weapon swaps. Drop it 5 at a time.
3. **TAP**, only if GAP alone didn't fix it. Too short and the game misses the
   press; too long and it's a deliberate swap, not a cancel. Below ~20 ms
   you're under two frames at 60 fps and it starts getting dropped.
4. **PRE**, for JUMP and DIVE macros. (DIVE adds a 200 ms sprint floor on top —
   `PRE x10` alone is a jump-overlap value and won't commit a dive.)
5. **RAMP** last, purely to taste. It can't break your calibration.

The total is the **longest** section, not the sum, so tightening TAP and GAP
shortens the cancel without shortening the spin.

---

## Eight binds

- **TS BINDS** — fires on a bare D-pad press
- **TS BINDS+** — fires while the **MODIFIER** is held

The modifier is swallowed so it can't leak into the game. **Use L3** (the
default): holding it only sprints, and you're standing still when you set up.
Never map it to a grenade button — BO2 *cooks* lethals on hold, so an L1/R1
modifier means holding a live grenade through the entire macro.

**SPIN DIR = AUTO** makes D-Left spin left and D-Right spin right.

### The layout `TRICK` loads
| Direction | Bare | + Modifier (L3) |
|---|---|---|
| **UP** | `360` | `720` |
| **DOWN** | `YY360` | `1080` |
| **LEFT** | `DRP360` | `TEMPER` |
| **RIGHT** | `JMP360` | `YYY360` |

---

## Feature list

### Aim
- **Aim assist enhancer** — CIRCLE / PULSE / STRAFE / FULL, with power, speed
  and trigger condition
- **Hip assist**, **scope bait**, **snap aim**

### Breath
- **Auto hold breath** — OFF / ALWAYS / SMART / DELAY, plus auto rest

### Shooting
- Quickscope, auto rescope, bolt cancel, reload cancel
- Rapid fire + anti-recoil for the semi-autos, hair trigger

### Movement
- Drop shot, jump shot, auto sprint, YY cancel, dive assist, turbo melee

### Trickshots
- **25 library macros**, 4 composable slots, 8 bindable directions
- Overlapping four-section sequencer with full timing control
- Spin envelope, abort-on-scope, hold-to-loop, timeline preview
- Bound directions are swallowed; unbound ones pass through, so you keep
  scorestreaks on the directions you don't use

### Display
- Three idle screens (EYES / SCOPE / BINDS / CYCLE) plus the timeline overlay
- Animated blink, iris drift, tear cycle
- 15-page menu, 5 rows visible per page, active-mod chips

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
1 AIM ASSIST · 2 SCOPE IN · 3 BREATH · 4 QUICKSCOPE · 5 BOLT WORK ·
6 SEMI AUTO · 7 MOVEMENT · 8 TRIGGERS · 9 TRICKSHOT · 10 TS TIMING ·
11 TS BINDS · 12 TS BINDS+ · 13 SLOT EDIT · 14 DISPLAY · 15 SYSTEM

**SLOT EDIT** is five lines now instead of ten: EDIT SLOT, PRE MOVE, CANCEL,
SPIN, FINISH. Change **EDIT SLOT** to load A/B/C/D into the editor; edit the
lines and they write straight back to that slot.

---

## Compile notes
- **GPC has no local variables.** All working vars are top level, prefixed by
  the function that owns them.
- **Combos take `set_val` and `wait` only** — no `if`, no `call`. That
  constraint is exactly why the trickshot sequencer is a *function* walking a
  window table rather than a set of combos.
- **`print` takes a data-section address, not a literal**, and there's no
  `%d`. Numbers go through `print_num()`.
- **A pvar is a signed 16-bit int** and `get_pvar` clamps at 32000 here. Binds
  pack three to a pvar at 5 bits each, so the ceiling is
  29 + 29·32 + 29·1024 = 30 653 — **which is exactly why the library stops at
  30 macros.** Add a 31st and saved binds corrupt silently.
- A slot is now **one** pvar (four components × 3 bits, max 4095). v2 needed
  twelve pvars for the same four slots. 23 SPVARs used of 64.
- **`get_pvar` hits EEPROM** — only ever called from `init`, never the main
  loop.
- `MAGIC` in SPVAR_12 tags the save format. Bump it when a layout changes, and
  add a migration branch rather than discarding — see `load_all()`.
- **Screen budget:** header `y 0..11`, rows `y 15/25/35/45/55`, labels `x 3`
  (10 chars), values `x 76` (6 chars), scrollbar `x 121..125`. Five rows is the
  hard ceiling; pages with more scroll.
- Adding a menu line means the `O_*` define, the `LBL[]` entry at the same
  index, the five metadata arrays, `OPT_N`, the `oval`/`odef`/… array sizes,
  and `PGFIRST`/`PGCOUNT` — **ten edits in step**, or the menu silently reads
  the wrong row.
