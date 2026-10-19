# SCOP'D v5.0 — Black Ops II sniper build

Cronus Zen / GPC. Offline, bot lobbies, campaign. File: `SCOPD_V17.gpc`.

---

## v5.0 — trickshot rework: families, decoupled spin, SWITCH, auto cancel timing

This is the big one. Pages reordered, LED color, a rebuilt cancel
timing model, and a full rework of how trickshots are picked and
stored.

**Page order**: TRICKSHOT, TS BINDS, TS TIMING, CALIBRATE, TS BINDS+,
SLOT EDIT, then everything else unchanged.

**Pink LED** — the Zen's own LED and the DS4 controller lightbar are
both set to pink, every tick, so the console can't quietly override
it back.

**Reload/axe/melee/tac cancels** no longer share the plain TAP value
for their trigger press. Each gets its own reasoned hold time before
the cancel swap fires (RELOAD 260ms, AXE/TAC 170ms, MELEE 110ms), so
the animation actually starts before it gets cut off — this is the
fix for reload cancels not showing the reload first. Worth being
honest: BO2 has no published frame data for this, so these are
well-reasoned defaults, not measured values. If reload still feels
early or late report back and it can be re-tuned.

**The trickshot library is a full rebuild.** SPIN is no longer baked
into a trick — it's chosen when you bind it. One "AXE" move now
covers every spin amount, instead of needing AXE360/540/720/1080 as
four separate slots. 29 moves across 7 families:

| Family | Moves |
|---|---|
| BASICS | SPIN, YY, YYY, JUMP |
| CANCELS | AXE, RELOAD, MELEE, JMPYY2, AXEYY, RLDAXE, QUADCAN |
| COMBOS | TEMPER, TEMPR2, MONSTR |
| NAC | MONEYNAC, TITTYNAC, RLDNAC, HYBRDNAC, SELFIRE |
| SWAPS | BARREL, INSTASW, KNIFEFL |
| MOVEMENT | DROP, DROPYY, NSL, LADSTALL, TOPSPIN, RUNMAN, MOONWLK |
| OTHER | (empty — reserved for anything that doesn't fit elsewhere) |

Custom slots A–D are browsable as an 8th group, SLOTS.

**TS BINDS / TS BINDS+** — pressing OK on a direction now opens a
3-screen picker instead of cycling a flat list: pick a family, pick a
trick, pick a spin amount. On the spin screen, LEFT/RIGHT changes the
spin, UP/DOWN toggles SWITCH, OK commits, EXIT backs up one screen at
a time.

**SWITCH** — new per-bind flag. Flips the spin direction at the
midpoint instead of holding one direction the whole way through, for
tricks that spin one way then the other partway. Only changes which
way the stick is pushed past 50% of the spin — doesn't touch button
choreography at all.

**On the NAC family**: a few of these (Titty NAC, Hybrid NAC, Selfire
NAC) collapse to the same underlying shape as a plain swap-timed
cancel. That's a genuine limit of what a fixed button sequence can
express — the community's distinctions between them are often about
exact real-world micro-timing a script can't reliably differentiate
without you testing and reporting back, not something faked here to
look more complete than it is.

**On MOVEMENT's new entries** (NSL, Ladder Stall, Top Spin, Running
Man, Moonwalk): these need real positioning — a ledge, a ladder,
momentum — or a sustained stick hold, none of which a macro can
provide blind. What's scripted is only the button/timing piece each
one actually has; getting into position is on you. Top Spin has no
real button component at all — true vertical spin isn't something
the current spin engine (horizontal only) can do — so it's a bare
spin with an in-menu note rather than a fabricated mechanic.

**Custom slots are unchanged** — still 8 fields, still don't have
their own SWITCH field. That's a real scoping decision (adding it
means a large cascading option-id renumber) rather than an oversight
— say the word if you want it added.

---

## v4.6 — declassify boot, status strip idle view

**Boot** no longer runs the eyes — it's a declassify reveal instead:
CLEARANCE/GRANTED, a redacted OPERATOR ID that never resolves (texture,
not real data), the brand line, then LOADING hands off to the same
progress bar that already ran from t=2600. Same total boot time as
before (3.6s) — only what's drawn changed, not the pacing.

**New: IDLE VIEW** on the DISPLAY page — EYES / STATUS, default EYES
(existing saves behave exactly as before). STATUS swaps the idle
eyes for a read-only status strip: TRICKSHOT, QUICKSCOPE, STEAL
EMBLEM (shown as ARMED rather than ON, since that one fires an actual
input sequence), and a HOLD L2+OPTIONS hint at the bottom. It's a
second view, not a replacement — the eyes (blink curve, iris drift,
tear physics, and their three DISPLAY settings) are untouched and
still what you get by default.

Worth knowing going in: the OLED is genuinely monochrome — no color,
no real glow/shadow. "GRANTED" and the brand line use an inverted
block (white fill, black text) for emphasis instead, which is the
same trick the rest of the menu already uses for headers.

---

## v4.5 — 540/720 tiers for AXE/RLD/MEL/TEMPER/BARREL

YY180, YY1080, YYY720, YY2360, YY2720, JMPYY, DRPMEL, YY3360, YY3720,
RUN1080 removed to make room (10 slots — checked first that none of
them were in any default bind). In their place, the missing middle
tiers for each family from v4.4:

| Family | 360 | 540 | 720 | 1080 |
|---|---|---|---|---|
| AXE | AXE360 | **AXE540** | **AXE720** | AXE1080 |
| RELOAD | RLD360 | **RLD540** | **RLD720** | RLD1080 |
| MELEE | MEL360 | **MEL540** | **MEL720** | MEL1080 |
| TEMPER shape | TEMPER | **TMP540** | **TMP720** | TMP1080 |
| BARREL shape | BARREL | **BAR540** | **BAR720** | BAR1080 |

Every family now has all four spin tiers available.

---

## v4.4 — five new 1080 tricks

RUNJMP, RUN720, DIV360, DIV720, DIVYY removed to make room. In their
place, five new library tricks — same shape as their 360 counterpart,
spin bumped to 1080:

| New | Same shape as | Fields |
|---|---|---|
| **AXE1080** | AXE360 | AXE cancel, 1080 spin |
| **RLD1080** | RLD360 | RELOAD cancel, 1080 spin |
| **MEL1080** | MEL360 | MELEE cancel, 1080 spin |
| **TMP1080** | TEMPER | JUMP + YY cancel + SWAP finish, 1080 spin |
| **BAR1080** | BARREL | SWAP pre + YY cancel, 1080 spin |

TEMPER, TEMPR2, AXE360, AXEYY2, RLD360, RLDAXE, MEL360, BARREL,
MONSTR, and QUADCAN were already in the library exactly as specced —
nothing needed to change there.

---

## v4.3 — page counter bugfix, XTRA DOWN, TS AUTO

**Page counter fix.** The header was showing "14/12" — the `/N`
total wasn't a real number, it was two hardcoded characters left over
from when the script had exactly 12 pages. Both halves of the counter
now render off the actual page numbers, so this can't drift again
next time a page gets added.

**STEAL EMBLEM → XTRA DOWN.** New line: 0–6 extra DOWN presses tacked
onto the base 2 at the end of the sequence (default 4, so out of the
box it sends 6 total). This is why the macro stopped being a raw
combo internally — a runtime-adjustable repeat count needs a loop,
and GPC combos can't loop or branch — but nothing about how you use
it changed: same ENABLE/TRIGGER/TAP/GAP/FIRE TEST as before, just one
more tunable line.

**SYSTEM → TS AUTO.** New action on the SYSTEM page: loads the
tested TS TIMING baseline (TAP 28, GAP 24, STAGE 7, LEAD 0, PRE 8,
FIN 4, TAIL 6) in one press instead of resetting all seven timing
lines by hand with TRIANGLE. It's the documented starting point, not
a live per-controller calibration — CALIBRATE's FIRE TEST / APPLY FIX
/ TUNE GAP is still what actually tunes SPIN and GAP to your own
setup once you're there.

---

## v4.2 — STEAL EMBLEM tab

New page, page 14. A fixed menu-navigation macro for the Barracks
emblem-copy glitch — **X, Circle ×3, X, X, Down ×2** — not a gameplay
mod, so it's kept off the trickshot pages entirely.

| Line | What it does |
|---|---|
| **ENABLE** | Master on/off for the whole feature |
| **TRIGGER** | Which button fires the sequence: OFF / L3 / R3 / L1 / R1 |
| **TAP ms** | How long each press is held (default 40) |
| **GAP ms** | Space between presses (default 70, max 250) |
| **XTRA DOWN** | Extra DOWN presses on top of the base 2 at the end (0–6, default 4 — see v4.3) |
| **FIRE TEST** | Runs the sequence once immediately, from the menu, for tuning without backing all the way out |

Menu response is far less consistent than in-game input, so if it's
not landing, walk TAP/GAP up or down a step at a time with FIRE TEST
the same way you'd use TUNE GAP on the sniper side — there's no
guided calibration for this one, it's feel-based.

---

## v4.1 — SLOT EDIT bugfix

`PG_SLOT` (the page id the save/load logic for custom slots checks
against) was set to the wrong page number — it pointed at CALIBRATE
instead of SLOT EDIT. That meant the sync between the on-screen
PRE/CANCEL/SPIN/FINISH fields and the actual stored slot data never
ran while you were on the real SLOT EDIT page: edits changed the
number on screen but never reached the data, so **SLOTA–D always
played whatever was already stored**, and nothing you edited was ever
saved, no matter how many times you hit SAVE ALL or CIRCLE. Fixed —
custom slots now load and save correctly. No settings were reset by
this fix; your existing slot data and other saved settings are
untouched.

---

## What changed in v4.0

### It only does sniping now

Everything that wasn't sniping or trickshotting is **deleted**, not hidden.
The regular build covers that ground; this one shouldn't.

| Gone | Why |
|---|---|
| **SCOPE IN** page (snap aim, scope bait) | Scope bait is meaningless — BO2 has no scope glint to bait. Snap aim had the same "blind vector added on top of your input" flaw as the old aim assist. |
| **SEMI AUTO** page (rapid fire, anti-recoil) | Generic weapon-class tech, not sniper tech. |
| **TRIGGERS** page (hair trigger, trigger point) | Generic QoL for any gun. |
| **Idle SCOPE + BINDS screens** | See the OLED section. |

**MOVEMENT survives intact** — jump shot, dive assist and YY cancel are
literally the PRE and CANCEL vocabulary the sequencer is built from, and
drop shot / auto sprint come along with them. Turbo melee moved here off
the deleted TRIGGERS page.

**15 pages → 13**, and the sequencer is no longer buried at page 9:

`1 AIM ASSIST · 2 TRICKSHOT · 3 TS TIMING · 4 SLOT EDIT · 5 CALIBRATE ·
6 TS BINDS · 7 TS BINDS+ · 8 BREATH · 9 QUICKSCOPE · 10 BOLT WORK ·
11 MOVEMENT · 12 DISPLAY · 13 SYSTEM`

### Aim assist was the wrong idea, so it's a different feature

CIRCLE / PULSE / STRAFE / FULL are gone. They were never really aim
assist — they were **stick-wiggle patterns**, injected on top of your real
right-stick value whether or not you were also moving it. That's exactly
the tweaking you were feeling on small corrections: a full-strength
rotating vector stacked onto a two-unit nudge, and the vector wins.

They were also aimed at a mechanic that doesn't reliably pay out here.
The theory is that oscillating the stick keeps the game's own rotational
aim assist "fed" — but against bots that magnetism doesn't engage the way
it does on a player-shaped hitbox, so you're adding motion for a benefit
that may not exist.

The replacement shapes **your own input** instead of adding a foreign one,
which is why it can't fight you:

| Setting | What it does |
|---|---|
| **CURVE** 0–10 | Response shaping. Blends your stick value toward its own square — fine control near centre where scoped micro-adjustments live, full speed at the edge for flicks. Both endpoints are fixed: 0 → 0 and 100 → 100. Nothing is lost, only redistributed. |
| **SMOOTH** 0–10 | Low-pass filter. Each frame the working value moves a fraction of the way toward the raw stick rather than snapping. Hand tremor and controller noise average out; real movement passes with a small lag (~40 ms at 1, ~160 ms at 10). |
| **BREATH LNK** | While you're scoped and holding breath — the moment you're deliberately trying to be still — both tighten by 3 automatically. |
| **MICRO NUDG** + **NUDGE PWR** 0–6 | Optional magnetism-style pull, **off by default**. Max 6 units versus the 9–13 the old modes used, and scaled to zero as your own deflection passes 20. It only ever acts on a near-still stick. |

CURVE has a floor so a real deflection always survives as at least 1 —
without it, integer division turns a stick value of 5 into 0 at the
steeper settings, which is a dead zone you'd feel immediately.

### Four cancels, one finish

The old 2 PRE / 3 CANCEL / 2 FINISH split was an accident of how fields
got bolted on over versions, not a design. A slot is packed as eight
3-bit fields across two pvars, so eight is the ceiling — the question was
only how to spend them.

```
  PRE 1   PRE 2   CANCEL 1   CANCEL 2
  CANCEL 3   CANCEL 4   SPIN   FINISH
```

FINISH drops to one field and gains a composite **`PR+MEL`** value, so a
prone-then-melee ending still works (that was the only two-action finish
the library ever used). The freed field becomes **CANCEL 4**.

Four new library macros exercise it: `QUADCAN`, `YY3360`, `YY3720`,
`RUN1080`.

### CALIBRATE — a page that does the tuning for you

Calibrating a spin by hand is a guessing game: fire a 360, over-rotate by
"a bit", nudge the number by 5, try again. That number is *solvable*.

**FIRE TEST** closes the menu and runs a bare reference spin — 360, 720 or
1080, no cancels, nothing but rotation. **RESULT** is where you actually
landed, in eighths of a turn. **APPLY FIX** solves for the corrected value:

```
  new SPIN 360ms = old × wanted / (wanted + error)
```

It converges in two or three shots from any starting error, refuses to
write a value outside 20–120, and clears RESULT afterwards so you can't
apply the same correction twice.

**TUNE GAP** is the same idea for cancel rhythm: it drops GAP one step and
fires `YY360` so you can walk it down without leaving the lobby.

### OLED

Boot and idle no longer print the name or the rule line under it. Idle is
**eyes only**, always — the SCOPE range scene, the BINDS list, the CYCLE
rotation and the IDLE VIEW option that switched between them are all gone,
along with their support code (the runner sim, particle system, glitch
bands, scanline, easing helper). The face was always the house mark; it
reads better without a wordmark stacked on it.

### Your saved settings are reset — once

Past versions carried saves forward with translation tables. This one
can't honestly: there is no correct mapping from a 3-cancel/2-finish slot,
or from `AA MODE = CIRCLE`, onto this layout. A migration would have been
guesswork wearing a table's clothes.

So **v4.0 resets everything on first load** and writes the defaults back.
Re-tune TS TIMING and re-bind your directions once. Future layout changes
go back to adding a migration branch.

---

## Calibration — scaling spin and timing correctly

This is the part worth reading twice. Everything else is preference;
this is the difference between a macro that lands and one that doesn't.

### The two numbers that scale everything

**`SPIN 360ms`** is the only rotation number you ever set. Every spin
amount is derived from it by a fixed multiplier:

| Spin | Multiplier | At `SPIN 360ms = 60` |
|---|---|---|
| 180 | ×0.5 | 300 ms |
| 360 | ×1 | 600 ms |
| 540 | ×1.5 | 900 ms |
| 720 | ×2 | 1200 ms |
| 900 | ×2.5 | 1500 ms |
| 1080 | ×3 | 1800 ms |

**This is why error compounds.** A 3 % error is 11° on a 360 — invisible.
The *same* 3 % is 32° on a 1080 — you're facing the wrong wall. Calibrate
against the biggest spin you can stand to watch, because a bigger
reference measures the same error three times more precisely.

That's the whole reason CAL REF offers 720 and 1080.

### How to calibrate the spin

1. Bot lobby, standing still, **not** scoped.
2. Page 5 → **REF SPIN** → `1080`.
3. Face something unmistakable — a doorway edge, a painted line. Not "that
   general direction". You need to be able to tell 45° from 90°.
4. **FIRE TEST** (the menu closes and it fires immediately).
5. Look where you ended up. Pick the nearest **RESULT**:
   - landed *before* the mark → `SHRT`
   - landed *past* it → `LONG`
   - eighth of a turn ≈ 45°, quarter ≈ 90°, half ≈ 180°
6. **APPLY FIX**. The new value shows on screen with the old one under it.
7. Repeat from step 4. Two or three passes gets you inside a few degrees.

If it says **OUT OF RANGE**, your RESULT was wildly off from what actually
happened (usually picking `+1/2 LONG` when you meant `+1/8`). Fire again
and read more carefully.

Once 1080 is right, **every other spin is right**, because they're all the
same number times a constant. Don't calibrate them separately.

### How to calibrate the cancel rhythm

`GAP` is the space between taps *inside* one cancel — the YY itself. If a
cancel isn't cancelling, the game read two separate weapon swaps instead
of one interrupted animation, which means GAP is too wide.

Page 5 → **TUNE GAP** drops it one step and fires `YY360`. Repeat until
the cancel bites. If you overshoot into "nothing registers at all", you've
gone under two frames of input and presses are being dropped — go back up
a step or two.

`TAP` is how long each press is *held*. Only touch it if GAP alone won't
fix it. Below about 20 ms you're under two frames at 60 fps and the
console starts ignoring presses entirely.

### How the timing numbers scale against each other

These are the relationships that matter — get these wrong and no amount of
spin calibration saves the shot.

| | Scales against | Rule of thumb |
|---|---|---|
| **GAP** | frame time (~16.7 ms) | Must be ≥ 2 frames or presses drop. Tight. |
| **STAGE** | the airtime you have | Must be *loose* relative to GAP. Tight YY, loose spacing between cancels — that's the whole reason they're separate numbers. |
| **PRE** | the pre-move's animation | How far *into* the jump the cancel chain starts. Too early and you cancel before leaving the ground. |
| **LEAD** | the spin | Delays the spin's start only. Use it to put the rotation *after* a pre-move rather than through it. |
| **FIN** | whatever ended last | Fires after the later of CANCEL and SPIN — so raising SPIN pushes FINISH out automatically. You rarely need to touch this. |

**The total length is the longest lane, not the sum.** A macro with a 1080
in it is 1080-length no matter how many cancels you pack underneath —
which is exactly why `RUN1080` can fit three cancels and `QUADCAN` can fit
four in a 360.

Two floors you can't tune away: **DIVE and SPRINT need a 200 ms run-up**
before the game commits to them, on top of whatever PRE says. `PRE x10` is
a jump-overlap value; it won't make either of those commit faster.

### Tune in this order

1. **SPIN 360ms** — page 5, against 1080. Everything else depends on it.
2. **GAP** — page 5 TUNE GAP, against `YY360`.
3. **TAP** — only if GAP alone didn't fix the cancel.
4. **STAGE** — on a multi-cancel macro like `JMPYY2` or `QUADCAN`. Too
   tight and the second cancel runs into the first and the game reads one
   long swap chain; too loose and the shot falls out of the jump. Turn
   **TIMELINE** on (page 12) and watch where the cancel bars sit against
   the spin bar.
5. **PRE** — for JUMP and DIVE macros.
6. **RAMP** — last, purely to taste. It can't break your calibration: the
   spin window is lengthened by exactly the area the envelope gives up.

### Tuning the aim curve

Different problem, same discipline — change one thing and fire ten shots.

- **Aim drifts / hard to hold still on a long shot** → raise SMOOTH.
- **Can't make fine corrections; overshooting small adjustments** → raise
  CURVE.
- **Feels sluggish or disconnected on flicks** → lower SMOOTH first, not
  CURVE. CURVE doesn't touch the top end; SMOOTH does add lag.
- **Fine at the hip, bad while scoped** → turn BREATH LNK on rather than
  raising the base numbers.

Start at the defaults (CURVE 4, SMOOTH 3) and move one step at a time.

---

## The macro library

41 named eight-field combinations, plus the four slots. The library is
nothing but presets over the same fields the slots use, so a name and its
behaviour can't drift apart.

| Macro | PRE | CANCEL | SPIN | FINISH | Length |
|---|---|---|---|---|---|
| `180` | — | — | 180 | — | 384 |
| `360` | — | — | 360 | — | 708 |
| `540` | — | — | 540 | — | 1032 |
| `720` | — | — | 720 | — | 1357 |
| `900` | — | — | 900 | — | 1681 |
| `1080` | — | — | 1080 | — | 2005 |
| `YY180` | — | YY | 180 | — | 384 |
| `YY360` | — | YY | 360 | — | 708 |
| `YY540` | — | YY | 540 | — | 1032 |
| `YY720` | — | YY | 720 | — | 1357 |
| `YY1080` | — | YY | 1080 | — | 2005 |
| `YYY360` | — | YYY | 360 | — | 708 |
| `YYY720` | — | YYY | 720 | — | 1357 |
| `YY2360` | — | YY + YY | 360 | — | 708 |
| `YY2720` | — | YY + YY | 720 | — | 1357 |
| `JMP360` | JUMP | — | 360 | — | 708 |
| `JMP720` | JUMP | — | 720 | — | 1357 |
| `JMPYY` | JUMP | YY | 360 | — | 708 |
| `JMPYY2` | JUMP | YY + YY | 360 | — | 708 |
| `RUNJMP` | SPRINT + JUMP | YY | 360 | — | 708 |
| `RUN720` | SPRINT + JUMP | YY + YY | 720 | — | 1357 |
| `DRP360` | — | — | 360 | PRONE | 1088 |
| `DRPYY` | — | YY | 360 | PRONE | 1088 |
| `DRPMEL` | — | YY | 360 | PRONE+MELEE | 1156 |
| `DIV360` | DIVE | — | 360 | — | 708 |
| `DIV720` | DIVE | — | 720 | — | 1357 |
| `DIVYY` | DIVE | YY | 360 | — | 708 |
| `TEMPER` | JUMP | YY | 360 | SWAP | 776 |
| `TEMPR2` | JUMP | YY + YY | 360 | SWAP | 776 |
| `AXE360` | — | AXE | 360 | — | 708 |
| `AXEYY2` | — | AXE + YY | 540 | — | 1032 |
| `RLD360` | — | RELOAD | 360 | — | 708 |
| `RLDAXE` | — | RELOAD + AXE | 360 | — | 708 |
| `MEL360` | — | MELEE | 360 | — | 708 |
| `BARREL` | SWAP | YY | 360 | — | 708 |
| `MONSTR` | SPRINT + JUMP | RELOAD + YY + YY | 1080 | PRONE+MELEE | 2453 |
| `QUADCAN` | — | YY + YY + YY + YY | 360 | — | 708 |
| `YY3360` | — | YY + YY + YY | 360 | — | 708 |
| `YY3720` | — | YY + YY + YY | 720 | — | 1357 |
| `RUN1080` | SPRINT + JUMP | YY + YY + YY | 1080 | — | 2005 |

Lengths are computed at stock timings with `SPIN 360ms = 60` and
`RAMP = 55`, and include `TAIL`.

### The components

**PRE 1 / PRE 2** — `NONE` · `JUMP` · `DIVE` · `SWAP` · `PRONE` · `CROUCH` ·
`SPRINT`. `SPRINT` in PRE 1 stays held *past* the point PRE 2 fires, so the
jump goes off while you're still running — that's a running jump, and a
running jump is what buys airtime for the extra cancels. Everything else
runs to completion first.

**CANCEL 1 / 2 / 3 / 4** — `NONE` · `YY` · `YYY` · `YYYY` · `RELOAD` ·
`AXE` · `MELEE` · `TAC`. The last four start an animation and then
YY-cancel it. Each stage begins `STAGE x10` after the one before.

**SPIN** — `NONE / 180 / 360 / 540 / 720 / 900 / 1080`, all derived from
your one calibrated `SPIN 360ms`, running in parallel with everything else.

**FINISH** — `NONE` · `PRONE` · `MELEE` · `SWAP` · `CROUCH` · `JUMP` ·
`RELOAD` · `PR+MEL`. Fires after whichever of CANCEL and SPIN ends last.
`PR+MEL` drops prone, waits `FIN x10`, then melees off the deck.

### Stock custom slots

| Slot | PRE | CANCEL | SPIN | FINISH |
|---|---|---|---|---|
| **A** | JUMP | YY + YY + YY | 360 | — |
| **B** | SPRINT + JUMP | YY + YY | 720 | — |
| **C** | — | AXE + YY + YY | 360 | PRONE |
| **D** | SWAP | RELOAD + YY | 540 | SWAP |

**SLOT EDIT** (page 4) is nine lines and scrolls five at a time: EDIT SLOT,
PRE 1, PRE 2, CANCEL 1–4, SPIN, FINISH. Change **EDIT SLOT** to load
A/B/C/D into the editor; edit the lines and they write straight back.

That's 7 × 7 × 8 × 8 × 8 × 8 × 7 × 8 = **~11.2 million** expressible
trickshots. All 32 768 combinations of the four cancels against every
finisher were compiled and checked, plus the full cross of the branchy
pre-move fields and a 60 000-sample random sweep of the whole space at
randomised timings: no malformed windows, worst case 23 of the 28 window
slots.

### Not included

Ladder stalls, top spins and jump-off-building shots are **position**
dependent, not input sequences — a macro can't know where you're standing.
Do those manually; this handles the input tech.

`AXE` needs a Combat Axe as lethal. `SWAP` finishers want a secondary
worth swapping to. Cancel timings assume **Fast Hands**.

---

## Eight binds

- **TS BINDS** (page 6) — fires on a bare D-pad press
- **TS BINDS+** (page 7) — fires while the **MODIFIER** is held

The modifier is swallowed so it can't leak into the game. **Use L3** (the
default): holding it only sprints, and you're standing still when you set
up. Never map it to a grenade button — BO2 *cooks* lethals on hold, so an
L1/R1 modifier means holding a live grenade through the entire macro.

**SPIN DIR = AUTO** makes D-Left spin left and D-Right spin right.

Bound directions are swallowed; unbound ones pass through, so you keep
scorestreaks on the directions you don't use. Pressing a bound direction
mid-sequence aborts it.

### The layout `TRICK` loads

| Direction | Bare | + Modifier (L3) |
|---|---|---|
| **UP** | `360` | `720` |
| **DOWN** | `YY360` | `1080` |
| **LEFT** | `DRP360` | `TEMPR2` |
| **RIGHT** | `JMP360` | `JMPYY2` |

---

## Timing reference

Everything on TS TIMING is milliseconds unless marked `x10`.

| Setting | What it does | Default |
|---|---|---|
| **TAP ms** | how long each button is held | 28 |
| **GAP ms** | space between taps inside one cancel — *the YY rhythm* | 24 |
| **STAGE x10** | space between one cancel and the next | 7 (70 ms) |
| **LEAD x10** | delay before the spin starts | 0 |
| **PRE x10** | how far into the pre-move the cancel chain begins | 8 (80 ms) |
| **FIN x10** | before FINISH, and inside the `PR+MEL` composite | 4 (40 ms) |
| **TAIL x10** | dead time before control returns | 6 (60 ms) |

---

## Feature list

### Aim
- **Aim precision** — response curve, jitter smoothing, breath-linked
  tightening, optional suppressed micro nudge

### Breath
- **Auto hold breath** — OFF / ALWAYS / SMART / DELAY, plus auto rest

### Shooting
- Quickscope, auto rescope, bolt cancel, reload cancel

### Movement
- Drop shot, jump shot, auto sprint, YY cancel, dive assist, turbo melee

### Trickshots
- **41 library macros**, 4 composable slots, 8 bindable directions
- Overlapping eight-field sequencer with full timing control
- Spin envelope, abort-on-scope, hold-to-loop, timeline preview
- **Guided calibration** for spin and cancel rhythm

### Display
- Eyes-only idle with animated blink, iris drift and tear cycle
- Timeline overlay, calibration readout
- 13-page menu, 5 rows visible per page

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

---

## Compile notes

- **GPC has no local variables.** All working vars are top level,
  prefixed by the function that owns them.
- **Combos take `set_val` and `wait` only** — no `if`, no `call`. That
  constraint is exactly why the trickshot sequencer is a *function*
  walking a window table rather than a set of combos.
- **`print` takes a data-section address, not a literal**, and there's no
  `%d`. Numbers go through `print_num()`.
- **A pvar is a signed 16-bit int** and `get_pvar` clamps at 32000 here.
  With 45 macros a bind needs 6 bits, and only **two** fit in a pvar:
  44 + 44·64 = 2 860 is fine, three would be 183 260. That ceiling is what
  caps the library size, not the menu.
- A slot spans **two** pvars (eight fields × 3 bits = 24 bits, each half
  maxes at 4095). 25 SPVARs used of 64.
- **`get_pvar` hits EEPROM** — only ever called from `init`, never the
  main loop.
- `MAGIC` in SPVAR_12 tags the save format. v4.0 is 94, and unlike past
  versions it *discards* rather than migrates — see `load_all()`. Go back
  to a migration branch for the next layout change.
- **Screen budget:** header `y 0..11`, rows `y 15/25/35/45/55`, labels
  `x 3` (10 chars), values `x 76` (6 chars), scrollbar `x 121..125`. Five
  rows is the hard ceiling; pages with more scroll.
- Adding a menu line means the `O_*` define, the `LBL[]` entry at the same
  index, the five metadata arrays, `OPT_N`, the `oval`/`odef`/… array
  sizes, and `PGFIRST`/`PGCOUNT` — **ten edits in step**, or the menu
  silently reads the wrong row. Validate with
  `PGFIRST[i] + PGCOUNT[i] == PGFIRST[i+1]` and a final
  `PGFIRST[n] + PGCOUNT[n] == OPT_N`.
- Adding a trickshot field means `SL_STRIDE`, `MACDEF[]`, `SLOTDEF[]`, the
  `ts_slot[]`/`st[]` sizes, `ts_load()`, `slot_sync()`, `ts_build()`, the
  SLOT EDIT lines, the save/load packing, and `NWIN` if it can emit
  windows. Eight 3-bit fields is the ceiling for the two-pvar slot format.
