# SCOP'D v1.1 — Black Ops II sniper build

## Install
1. **Zen Studio** → new script → paste `SCOPD.gpc` → **Build** (F7) → **Program Device**.
2. First boot plays the quickscope intro, then settings load from slot memory.

## Controls
| Action | Input |
|---|---|
| Open / close menu | hold **L2** + tap **OPTIONS** |
| Master arm / disarm | hold **L2** + tap **SHARE** |
| Move cursor | **D-Up / D-Down** |
| Change value | **D-Left / D-Right** (hold ~0.4s to fast-scroll) |
| Page | **L1 / R1** |
| Toggle / run action | **CROSS** |
| Reset line to default | **TRIANGLE** |
| Save + exit | **CIRCLE** |

## Calibrate the spin first
Everything on the trickshot pages derives from **SPIN 360ms** — the time your
stick needs for one full rotation at *your* sensitivity. Nothing else will land
until this is right, and every multi-rotation macro is a multiple of it.

1. TS BINDS → set **D-PAD UP** to `360`. TRICKSHOT → **ENABLE** on.
2. Stand still in a bot match facing something distinctive.
3. Press D-Up. You should finish facing the same thing.
4. Over-rotated → lower SPIN 360ms. Under-rotated → raise it. Step by 5.

Rough starting points: high sens (8–10) ≈ 35–45, medium (5–7) ≈ 55–70,
low (3–4) ≈ 80–110. Default is 60.

Check `720` afterwards. Small errors compound — a spin that's 3% long is barely
visible on a 360 and lands you 32° off on a 1080.

## Trickshot macros

| Value | Sequence |
|---|---|
| `180` | Half spin, scope up through the last 40%, fire |
| `360` | One rotation |
| `540` | One and a half rotations |
| `720` | Two rotations |
| `1080` | Three rotations |
| `NOSCOP` | Full spin, fires from the hip |
| `JMP360` | Jump, then spin + quickscope in the air |
| `DRP360` | Spin into a drop shot, fires from prone |
| `DIVE` | Sprint, dolphin dive, spin, quickscope |
| `TEMPER` | Temperr shot: jump, fake the zoom, YY through the spin, no-scope, swap out |
| `SWAP` | Insta swap: land the quickscope, pull the secondary before it registers |
| `AXECAN` | Combat axe out, swap-cancel the throw, spin, quickscope |
| `KNIFE` | Spin, quickscope, melee straight out of the shot |
| `RLDCAN` | Start a reload, YY-cancel it mid-spin, land the scope |
| `BARREL` | Shotgun barrel roll: swap out, sprint, double-tap swap, no-scope |

**Not included, because they're position-dependent rather than input sequences:**
ladder stalls and top spins need you on a specific ladder, and jump-off-building
shots need the building. A macro can't know where you're standing. Do those
manually — what's here is the input tech.

`AXECAN` needs a Combat Axe as lethal. `BARREL` and `SWAP` want a secondary worth
swapping to (R870 or Five-Seven). `TEMPER` and `RLDCAN` assume **Fast Hands** —
the swap-cancel timings are built around it.

## Eight binds, not four
The D-pad gives four directions, so there are two bind sets:

- **TS BINDS** — fires on a bare D-pad press.
- **TS BINDS+** — fires while the **MODIFIER** is held.

Set MODIFIER on the TRICKSHOT page. It's blocked from reaching the game while
held, so it can't leak an input mid-macro.

**Use L3.** Holding it only sprints, and you're standing still setting up anyway.
Never pick a grenade button — BO2 *cooks* lethals on hold, so an L1/R1 modifier
means you're holding a live grenade through the entire macro. `L1` is offered for
people who insist, but that's the trap.

A direction set to `OFF` in both sets passes straight through to the game, so you
keep scorestreaks on the directions you don't use.

### A layout that works
Grouped so each direction has a theme and the modifier escalates it:

| Direction | Bare | + Modifier |
|---|---|---|
| **UP** | `360` | `720` |
| **DOWN** | `NOSCOP` | `1080` |
| **LEFT** | `DRP360` | `TEMPER` |
| **RIGHT** | `JMP360` | `SWAP` |

Up and Down are the bread-and-butter spins, with the modifier escalating rotation
count. Left and Right carry the movement shots, escalating into the showpieces.
With **SPIN DIR = AUTO**, Left spins left and Right spins right, so the two
movement shots mirror each other.

Running a shotgun secondary? Swap `KNIFE` onto modifier-Right and put `BARREL` on
modifier-Down.

## Auto Hold Breath
Four modes:

- **ALWAYS** — holds the instant you scope. Simple, but drains the meter while
  you're just panning.
- **SMART** — only holds once your finger is on the trigger (>5% pull). This is
  the one to use. Your breath is full when you actually need it.
- **DELAY** — waits `DELAY x10` ms after scoping, then holds.
- **AUTO REST** layers on any mode: holds for `MAX HOLD` (×100ms), releases 600ms
  to recover, repeats.

With hair trigger on and TRIGGER PT low, SMART engages the moment you touch the
trigger — effectively instant.

## Aim assist for sniping
- **CIRCLE** — micro-circle on the right stick. Best general scoped choice.
- **PULSE** — left/right only. Tighter at long range.
- **STRAFE** — left-stick sway; this is what baits BO2's rotational assist.
- **FULL** — circle + strafe.

Start POWER 9–11. Snipers punish crosshair wander far more than ARs, so this
wants to be *lower* than an AR script. If you can see the reticle moving, it's
too high.

**SCOPE BAIT** forces the sway on for the first 400ms after you scope — the
window where BO2's assist is stickiest — then gets out of the way.

**SNAP AIM** taps ADS off and back on to re-trigger the initial snap, then nudges
in the direction set by **SNAP DIR**. DOWN for standing targets, UP if you're
consistently aiming low.

## Post-shot work
- **AUTO RESCP** drops and re-raises the scope after each shot. Tune `RESCP DLY`
  to just past the rechamber.
- **BOLT CANCL** swaps twice to cut the rechamber short. `BOLT DELAY` must land
  *after* the shot registers or you'll cancel the shot itself — start at 42 and
  walk down.

## Presets
SYSTEM page → pick → **APPLY**. `DSR-50`, `BALLST`, `SVU-AS`, `XPR-50` set
quickscope and bolt timings per weapon. `QSRUSH` is aggressive (fast QS, auto
rescope, hair trigger, jump shot, FULL aim assist). `TRICK` enables trickshots
with macros pre-bound.

Edit the numbers permanently in `apply_preset()` near the bottom of the script.

## Display
Idle alternates every 4s between two views (fix it to one on DISPLAY):

- **SCOPE** — reticle breathing in a figure-eight. The sway collapses when Auto
  Hold Breath is on, so you can see at a glance that it's live.
- **BINDS** — what each D-pad direction fires, with an animated D-pad glyph.

## Compile notes
- **GPC has no local variables.** All working vars are top level, prefixed by the
  function that owns them.
- **Combos take `set_val` and `wait` only** — no `if`, no `call`. Anything
  conditional is resolved into a global *before* `combo_run`.
- **`print` takes a data-section address, not a literal**, and there's no `%d`.
  Text lives in const string tables; numbers go through `print_num()`.
- **`wait()` tops out around 4000ms** — `fire_macro()` caps total spin at 3600 so
  a 1080 at low sensitivity can't overflow it.
- **Storage:** 15 slot vars, bit-packed. A pvar is a signed 16-bit int, so a pack
  must stay under 32767. `SPVAR_1` holds 14 booleans (max 16383) deliberately; a
  15th would hit exactly 32767 and get clipped by the `get_pvar` ceiling. The
  8 binds pack three-to-a-pvar at 4 bits each (max 4095).
- **Screen budget:** header `y 0..11`, rows at `y 15/25/35/45/55`, labels `x 3`
  max 10 chars, values `x 76` max 6 chars, scrollbar `x 121..125`. Five rows per
  page is the hard ceiling.
- Adding a menu line means four edits in step: the `O_*` define, the matching
  `LBL[]` entry at the same index, a `reg()` call, and the page's `pg_count`.
- The bind field is 4 bits, so the macro list can hold exactly 16 entries
  (`OFF` + 15). A 17th needs the bind packing widened.
