# SCOP'D v3.1 — Black Ops II sniper build

Cronus Zen / GPC. Offline, bot lobbies, campaign. File: `SCOPD_V8.gpc`.

---

## What changed in v3.1

### A trickshot is eight fields now

v3.0 gave a trickshot four named sections, which fixed the flow but allowed
exactly **one** cancel. Long shots need more — a running jump buys close to a
second of airtime and you want two or three cancels inside it.

```
  PRE 1     PRE 2     CANCEL 1   CANCEL 2
  CANCEL 3  SPIN      FINISH 1   FINISH 2
```

Same eight fields for the library macros and the custom slots, so anything in
the library is something you can build by hand — and anything you build is
something the sequencer already knows how to lay out.

### PRE 2 exists for the running jump

`SPRINT` deliberately stays **held past** the point PRE 2 fires, so the jump
goes off while you're still running. That's a running jump: higher, longer,
and with the airtime the extra cancels need. Compiled `RUNJMP`:

```
  SPRINT  ├──────────────────┤
  JUMP              ├─┤
  CANCEL                 ├─┤  ├─┤
  SPIN    ├───────────────────────────────┤
          0       280  308  360 388  412  440              648
```

Sprint 0 → 420, jump at **280 while still sprinting**, both swap taps at 360
and 412, spin running underneath the whole thing.

### GAP split in two

| | |
|---|---|
| **GAP ms** | the rhythm *inside* one cancel — the YY tap spacing |
| **STAGE x10** | the rest *between* one cancel and the next |

One number couldn't express "tight YY, loose spacing between cancels," which
is exactly what a multi-cancel shot needs. `JMPYY2` compiled: taps at 80/132,
then the second cancel at 230/282 — both inside the jump arc.

### 36 library macros, up from 25

Eleven new ones exercise the fields that didn't exist before:

| | |
|---|---|
| `YY2360` `YY2720` | two cancel stages, no pre-move |
| `JMPYY2` | jump with both cancels inside the arc |
| `RUNJMP` `RUN720` | running jump, one and two cancels |
| `DIVYY` | dive with a cancel |
| `TEMPR2` | TEMPER with the second cancel |
| `AXEYY2` | axe cancel, then a clean YY |
| `RLDAXE` | reload cancel straight into an axe cancel |
| `DRPMEL` | spin, drop, then melee off the deck |
| `MONSTR` | running jump + reload + YY + YY + 1080 + prone + melee |

### The custom tab

SLOT EDIT is nine lines (scrolls five at a time): EDIT SLOT, PRE 1, PRE 2,
CANCEL 1, CANCEL 2, CANCEL 3, SPIN, FINISH 1, FINISH 2.

That's **8.6 million** expressible trickshots. I compiled all 25 088
combinations of the branchy fields plus a 60 000-slot random sample of the
full space: no malformed windows, worst case 19 of the 24 window slots.

### Your saved settings, again

Macro ids renumbered when the library grew, and binds needed a wider field
(41 macros no longer fit in 5 bits). v3.1 reads **both** v2 and v3.0 saves:

| | |
|---|---|
| **Kept** | SPIN 360ms, TAP, GAP, LEAD, PRE, FIN, TAIL, RAMP, every mod setting |
| **Remapped** | all 8 binds — a v2 save chains through two translation tables, so a `TEMPER` bound two versions ago is still `TEMPER` |
| **Reset** | the four custom slots (four fields can't honestly become eight), and STAGE takes its default |

Binds also moved from three-per-pvar at 5 bits to two-per-pvar at 6 bits.
Three 6-bit fields would pack to 40 + 40·64 + 40·4096 = **166 440**, far past
the signed 16-bit ceiling — worth knowing before anyone tries to add a third
back.

---

## The macro library

Every macro is a named eight-field combination. The library is nothing but
presets over the same fields the custom slots use, so a name and its behaviour
can't drift apart.

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
| `YY2360` | — | YY + YY | 360 | — | 648 |
| `YY2720` | — | YY + YY | 720 | — | 1297 |
| `JMP360` | JUMP | — | 360 | — | 648 |
| `JMP720` | JUMP | — | 720 | — | 1297 |
| `JMPYY` | JUMP | YY | 360 | — | 648 |
| `JMPYY2` | JUMP | YY + YY | 360 | — | 648 |
| `RUNJMP` | SPRINT + JUMP | YY | 360 | — | 648 |
| `RUN720` | SPRINT + JUMP | YY + YY | 720 | — | 1297 |
| `DRP360` | — | — | 360 | PRONE | 1028 |
| `DRPYY` | — | YY | 360 | PRONE | 1028 |
| `DRPMEL` | — | YY | 360 | PRONE + MELEE | 1096 |
| `DIV360` | DIVE | — | 360 | — | 648 |
| `DIV720` | DIVE | — | 720 | — | 1297 |
| `DIVYY` | DIVE | YY | 360 | — | 648 |
| `TEMPER` | JUMP | YY | 360 | SWAP | 716 |
| `TEMPR2` | JUMP | YY + YY | 360 | SWAP | 716 |
| `AXE360` | — | AXE | 360 | — | 648 |
| `AXEYY2` | — | AXE + YY | 540 | — | 972 |
| `RLD360` | — | RELOAD | 360 | — | 648 |
| `RLDAXE` | — | RELOAD + AXE | 360 | — | 648 |
| `MEL360` | — | MELEE | 360 | — | 648 |
| `BARREL` | SWAP | YY | 360 | — | 648 |
| `MONSTR` | SPRINT + JUMP | RELOAD + YY + YY | 1080 | PRONE + MELEE | 2393 |

Lengths are at stock timings with `SPIN 360ms = 60` and `RAMP = 55`.

### The components

**PRE 1 / PRE 2** — `NONE` · `JUMP` · `DIVE` · `SWAP` · `PRONE` · `CROUCH` ·
`SPRINT`. `SPRINT` in PRE 1 overlaps whatever PRE 2 does; everything else runs
to completion first.

**CANCEL 1 / 2 / 3** — `NONE` · `YY` · `YYY` · `YYYY` · `RELOAD` · `AXE` ·
`MELEE` · `TAC`. The last four start an animation and then YY-cancel it. Each
stage is `STAGE x10` after the one before.

**SPIN** — `NONE / 180 / 360 / 540 / 720 / 900 / 1080`, all derived from your
one calibrated SPIN 360ms, running in parallel with everything.

**FINISH 1 / 2** — `NONE` · `PRONE` · `MELEE` · `SWAP` · `CROUCH` · `JUMP` ·
`RELOAD`, fired after whichever of CANCEL and SPIN ends last.

### Stock custom slots
| Slot | PRE | CANCEL | SPIN | FINISH |
|---|---|---|---|---|
| **A** | JUMP | YY + YY | 360 | — |
| **B** | SPRINT + JUMP | YY | 720 | — |
| **C** | — | AXE + YY | 360 | PRONE |
| **D** | SWAP | RELOAD + YY | 540 | SWAP |

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
| **GAP ms** | space between taps inside one cancel — *the YY rhythm* | 24 |
| **STAGE x10** | space between one cancel and the next | 7 (70 ms) |
| **LEAD x10** | delay before the spin starts | 0 |
| **PRE x10** | how far into the pre-move the cancel chain begins | 8 (80 ms) |
| **FIN x10** | before FINISH 1, and again before FINISH 2 | 4 (40 ms) |
| **TAIL x10** | dead time before control returns | 6 (60 ms) |

**Tune in this order:**

1. **SPIN 360ms.** Bind `360`, face a landmark, fire. Over-rotated → lower.
   Step by 5. Then check `1080` — small errors compound, and 3 % long is
   invisible on a 360 and 32° off on a 1080.
2. **GAP.** Bind `YY360`. If the cancel isn't cancelling, GAP is too wide — the
   game read two separate weapon swaps. Drop it 5 at a time.
3. **TAP**, only if GAP alone didn't fix it. Below ~20 ms you're under two
   frames at 60 fps and presses start getting dropped entirely.
4. **STAGE**, on a multi-cancel macro like `JMPYY2`. Too tight and the second
   cancel runs into the first and the game reads one long swap chain; too loose
   and the shot falls out of the jump. Turn **TIMELINE** on and watch where the
   cancel bars sit relative to the spin.
5. **PRE**, for JUMP and DIVE macros. (DIVE and SPRINT add a 200 ms run-up
   floor on top — `PRE x10` alone is a jump-overlap value and won't commit
   either.)
6. **RAMP** last, purely to taste. It can't break your calibration.

The total is the **longest** section, not the sum.

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
| **LEFT** | `DRP360` | `TEMPR2` |
| **RIGHT** | `JMP360` | `JMPYY2` |

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
- **36 library macros**, 4 composable slots, 8 bindable directions
- Overlapping eight-field sequencer with full timing control
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

**SLOT EDIT** is nine lines and scrolls: EDIT SLOT, PRE 1, PRE 2, CANCEL 1,
CANCEL 2, CANCEL 3, SPIN, FINISH 1, FINISH 2. Change **EDIT SLOT** to load
A/B/C/D into the editor; edit the lines and they write straight back.

---

## Compile notes
- **GPC has no local variables.** All working vars are top level, prefixed by
  the function that owns them.
- **Combos take `set_val` and `wait` only** — no `if`, no `call`. That
  constraint is exactly why the trickshot sequencer is a *function* walking a
  window table rather than a set of combos.
- **`print` takes a data-section address, not a literal**, and there's no
  `%d`. Numbers go through `print_num()`.
- **A pvar is a signed 16-bit int** and `get_pvar` clamps at 32000 here. With
  41 macros a bind needs 6 bits, and only **two** fit in a pvar:
  40 + 40·64 = 2 600 is fine, three would be 166 440. That ceiling is what
  caps the library, not the menu.
- A slot spans **two** pvars (eight fields × 3 bits = 24 bits, each half maxes
  at 4095). 29 SPVARs used of 64.
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
  the wrong row. The build script that generates this file's metadata asserts
  `LBL[]` against the spec and checks `PGFIRST[i] + PGCOUNT[i] == PGFIRST[i+1]`
  for exactly that reason.
- Adding a trickshot field means `SL_STRIDE`, `MACDEF[]`, `SLOTDEF[]`, the
  `ts_slot[]`/`st[]` sizes, `ts_load()`, `slot_sync()`, `ts_build()`, the
  SLOT EDIT lines, the save/load packing, and `NWIN` if it can emit windows.
