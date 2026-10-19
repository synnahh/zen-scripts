# SCOP'D — full trickshot button-macro list (v5.2 / V19)

Spin amount is chosen separately at bind time (family → trick → spin),
so it isn't part of any macro below — every move here works at any
spin from 180 to 1080. Buttons are PS4 face names, matching the script's
own mapping:

| Action | Button |
|---|---|
| Jump | CROSS (✕) |
| Crouch (tap) / Prone (hold) | CIRCLE (○) |
| Reload | SQUARE (□) |
| Weapon swap | TRIANGLE (△) |
| Sprint / hold breath | L3 |
| Melee | R3 |
| Lethal / axe | R1 |
| Tactical | L1 |

Every cancel (RELOAD/AXE/MELEE/TAC) is that button held briefly, then
two quick TRIANGLE taps to cut it short — that hold length is what
**CAN TUNE** (RLD MULT / AXE MULT / MEL MULT) controls. A plain "YY"
cancel is just the two TRIANGLE taps with no trigger button first.

---

## BASICS

| Move | Macro |
|---|---|
| **SPIN** | Nothing but the spin — no pre-move, no cancel, no finish |
| **YY** | TRIANGLE, TRIANGLE |
| **YYY** | TRIANGLE ×3 |
| **JUMP** | Tap CROSS |

## CANCELS

| Move | Macro |
|---|---|
| **AXE** | Hold R1, then TRIANGLE ×2 |
| **RELOAD** | Hold SQUARE, then TRIANGLE ×2 |
| **MELEE** | Hold R3, then TRIANGLE ×2 |
| **JMPYY2** | Tap CROSS → TRIANGLE ×2 → TRIANGLE ×2 |
| **AXEYY** | Hold R1 → TRIANGLE ×2 → TRIANGLE ×2 |
| **RLDAXE** | Hold SQUARE → TRIANGLE ×2 → hold R1 → TRIANGLE ×2 |
| **QUADCAN** | Four back-to-back YY cancels — TRIANGLE ×2, ×2, ×2, ×2 (8 taps total) |

## COMBOS

| Move | Macro |
|---|---|
| **TEMPER** | Tap CROSS → TRIANGLE ×2 → finish with TRIANGLE |
| **TEMPR2** | Tap CROSS → TRIANGLE ×2 → TRIANGLE ×2 → finish with TRIANGLE |
| **MONSTR** | Hold L3 (sprint) → tap CROSS (jump) → hold SQUARE + TRIANGLE ×2 (reload cancel) → TRIANGLE ×2 → TRIANGLE ×2 → hold CIRCLE (prone) → tap R3 (melee) to finish |

## NAC

| Move | Macro | Note |
|---|---|---|
| **MONEYNAC** | Hold SQUARE, then TRIANGLE ×2 | Same shape as RELOAD |
| **TITTYNAC** | TRIANGLE ×2 | Same shape as YY |
| **RLDNAC** | Hold SQUARE, then TRIANGLE ×2 | Same shape as RELOAD/MONEYNAC |
| **HYBRDNAC** | TRIANGLE ×2 | Same shape as YY/TITTYNAC |
| **SELFIRE** | TRIANGLE ×2 | Same shape as YY; needs a select-fire attachment equipped to mean anything |

## SWAPS

| Move | Macro |
|---|---|
| **BARREL** | Tap TRIANGLE (swap) → TRIANGLE ×2 |
| **INSTASW** | TRIANGLE ×2 → hold L1, then TRIANGLE ×2 |
| **KNIFEFL** | Hold R3, then TRIANGLE ×2 |

## MOVEMENT

| Move | Macro | Note |
|---|---|---|
| **DROP** | Hold CIRCLE (prone) — no pre, no cancel | |
| **DROPYY** | TRIANGLE ×2, then hold CIRCLE (prone) | |
| **NSL** | Tap CROSS | Button-timing only — the ground spin/ledge-jump positioning is on you |
| **LADSTALL** | Tap CROSS | Pair with SWITCH for the "look away" flip; ladder positioning is on you |
| **TOPSPIN** | Bare spin, no button component | Needs standing at the top of a ladder — the engine only spins horizontally, there's no true vertical spin to script |
| **RUNMAN** | Tap CROSS | Holding the stick forward after the jump is on you |
| **MOONWLK** | Hold L3 (sprint) | Backward movement/direction is on you — this only scripts the sprint-tap rhythm |

## INFADE

The one family that touches FIRE — every other trick deliberately
never does. Fire at least one round yourself first (the script has
no way to know your clip state). Then, unlike a plain cancel, the two
triggers are **staggered, not pressed together**: SQUARE (RELOAD)
goes down and is held on its own for a beat, THEN R2 (FIRE) joins
while SQUARE stays held — only once both are held does it spam
TRIANGLE (SWAP). That stagger is what actually loops the reload
sound/animation without spending real ammo; starting both at once
(the earlier version of this script) didn't work, since there's no
reload-in-progress yet for the swap-spam to interrupt.

Timing is on CAN TUNE: **FADE LEAD** (RELOAD-alone lead before FIRE
joins — tune this first if it's not catching), **FADE HOLD** (extra
delay after FIRE joins before the spam starts), **FADE GAP** (spacing
between swap taps). No published data exists for any of the three —
expect to tune against what you actually see.

| Move | Macro |
|---|---|
| **INFADE** | Hold SQUARE → (beat later) also hold R2 → spam TRIANGLE ×4, release both |
| **INFADEYY** | Hold SQUARE → also hold R2 → spam TRIANGLE ×3, release, then TRIANGLE ×2 |
| **INFADENAC** | Hold SQUARE → also hold R2 → spam TRIANGLE ×3, release, then hold R1 + TRIANGLE ×2 |
| **INFADEMEL** | Hold SQUARE → also hold R2 → spam TRIANGLE ×2, release, then hold R3 + TRIANGLE ×2 |

## SLOTS

Custom slots A–D aren't in this list — they're whatever you built in
SLOT EDIT, which now includes an INFADE REPS field (0–6) alongside
PRE/CAN/FIN/SPIN. Browsable as their own group ("SLOTS") in the bind
picker.

---

## On the overrun fix (same update as this list)

Longer sequences — MONSTR especially, also QUADCAN, RLDAXE, AXEYY,
JMPYY2, TEMPR2, INSTASW — take real time to play out. If you bind one
of these to a short spin (180/360), the cancel chain can now run past
where the spin ends; previously the camera went dead-still for
whatever cancel still had left to do. Fixed: the stick keeps being
driven (at the already-tapered tail power, not full strength) for as
long as the cancel chain actually needs, so it doesn't go static
mid-sequence. Doesn't touch FINISH — a prone+melee landing (MONSTR)
is meant to read as the camera having already settled.

Still worth knowing: these longer moves read better on a bigger spin
(720+) simply because there's more time for the choreography to sit
inside it. Short spin still works now, it just means more of the
sequence rides the settled tail than the active spin.
