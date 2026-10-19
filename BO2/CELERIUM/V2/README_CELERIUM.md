# CELERIUM v2.0 — Black Ops II (setup & tuning)

## Install
1. Open **Zen Studio** → new script → paste `CELERIUM.gpc`.
2. **Build** (F7). Fix nothing unless it errors — see *Compile notes* below.
3. **Program Device** into any slot, then run that slot.
4. First boot plays the intro animation, then settings load from slot memory.

## Controls
| Action | Input |
|---|---|
| Open / close menu | hold **L2** + tap **OPTIONS** |
| Master arm / disarm all mods | hold **L2** + tap **SHARE** |
| Move cursor | **D-Up / D-Down** |
| Change value | **D-Left / D-Right** (hold ≈0.4s to fast-scroll) |
| Page | **L1 / R1** |
| Toggle / run action | **CROSS** |
| Reset that line to default | **TRIANGLE** |
| Save + exit | **CIRCLE** |

While the menu is open all controller output is blocked, so you can't
accidentally shoot or pause. `OPTIONS` is also blocked whenever L2 is held so
the combo never pauses the game.

## Boot sequence
A DSR-50 scans in from left to right behind a bright scan line, with a band of
dithered 4px blocks trailing the edge so it materialises rather than wipes. Once
it's fully drawn the header and the `v2.0  ARMING` progress bar come up. Total
~3 seconds.

## Pages
Ten pages, three to five lines each — no page scrolls, so what you see is the
whole page.

1. **AIM ASSIST** – mode, power, speed, trigger, hip assist
2. **AIM SNAP** – snap aim, snap pull, snap delay, auto focus
3. **RECOIL** – enable, vertical, horizontal, ramp up, start delay
4. **RAPID FIRE** – enable, hold ms, rest ms, ADS only
5. **JITTER** – mode, hold ms, rest ms
6. **SHOT MODS** – drop shot, crouch shot, jump shot
7. **MOVEMENT** – auto sprint, YY cancel, bunny hop
8. **SCOPE/TRIG** – quickscope, QS delay, hair trigger, trigger point, deadzone
9. **EXTRAS** – reload cancel, turbo melee, melee rate, rumble, OLED anim
10. **SYSTEM** – preset, apply, save all, reset all

Deadzone compensation lives on the SCOPE/TRIG page rather than with the rest of
the recoil settings — it's a stick-response setting, and it keeps RECOIL to five
lines.

## Tuning the aim assist enhancer
The enhancer works by feeding tiny stick movements that keep BO2's rotational
aim assist "awake" — it doesn't read the screen, so power matters a lot.

- **CIRCLE** – traces a micro-circle with the right stick. Best all-rounder.
- **PULSE** – left/right shake only. Feels tighter at long range.
- **STRAFE** – left-stick sway. This is what actually triggers BO2's rotational
  pull, so it's the strongest at close range.
- **FULL** – circle + strafe together. This is the "screen shaking" look.

Start at **POWER 10–14, SPEED 8**. If your crosshair visibly wanders, drop power
by 2 until it stops. Higher SPEED = slower cycle. Set **TRIGGER** to `ADS+FIRE`
if you only want it while actually shooting.

## Tuning anti-recoil
1. Turn the enhancer OFF while you tune this.
2. Face a wall, hold fire, and watch the bullet spread.
3. Raise **VERTICAL** until the spread stops climbing. Most BO2 ARs land ~18–30.
4. If it drifts sideways, use **HORIZONTAL** (negative = compensate to the left).
5. **RAMP UP** eases the pull in over the first 700 ms — good for guns that only
   kick hard later in the mag.
6. **DEADZONE** only matters if small values do nothing; raise it until the
   smallest pull registers.

The routine only pulls when you aren't already pulling harder yourself, so it
won't fight your own aim.

## Jitter
- **SWAP** — fire + weapon-swap cancel. For the SMR / FAL / M14. Start at
  hold 18 / rest 18 and walk both down 2 at a time until it stops firing, then
  back up 2.
- **AKIMBO** — fire + ADS alternation. For akimbo pistols and the Five-Seven.

Jitter overrides rapid fire when it's on.

## Presets
Page 9 → pick a weapon → **APPLY PRE**. That overwrites the recoil/fire values
for that gun. Tweak afterwards and hit **SAVE ALL**; the preset stays as the
starting point but your edits are what's stored.

Preset values are in the `apply_preset()` function near the bottom of the
script — edit them there if you want your own numbers baked in permanently.

## Compile notes
- The `PS4_*` names are just index aliases and work on every output protocol
  the Zen supports. If you use a non-default in-game layout (Tactical, Lefty),
  change only the **BUTTON LAYOUT** block at the top.
- **GPC has no local variables.** Every working variable is declared at top
  level, prefixed by the function that owns it (`ar_rx`, `dm_i`, `np_v`, ...).
  If you add a function, add its variables to the state block — don't declare
  `int` inside the function body.
- **`printf` is dead; `print` replaces it** and takes a *string address*, not a
  literal: `print(x, y, font, colour, LBL[id])`. All on-screen text lives in the
  const string tables in the data section. There is no `%d` — numbers go
  through `print_num()`, which pushes digits with `putc_oled` and draws them
  with `puts_oled`.
- Adding a menu line means editing four things in step: the `O_*` define, the
  matching entry in `LBL[]` (same index), a `reg()` call, and the page's
  `pg_count`. The index into `LBL[]` **is** the option ID.
- `OLED_WHITE` is 1 and `OLED_BLACK` is 0. Small font is 7px wide and 8px tall,
  medium is 11px wide.
- **Screen budget** (this is what stops it looking cramped): header `y 0..11`,
  rows at `y 15/25/35/45/55` on a 10px pitch so there are 2 clear pixels between
  lines, labels at `x 3` (max 10 chars, ends at 73), values at `x 76` (max 6
  chars, ends at 118), scrollbar at `x 121..125`. Five rows is the hard ceiling —
  a sixth would need an 8px pitch, which is where v1.x looked cluttered.
- The DSR-50 in `draw_dsr()` is a vector sprite occupying `x 5..121, y 14..43`.
  If you edit it, keep it inside that band or it will collide with the header
  above or the ARMING bar below.
- `vm_tctrl(-8)` runs the VM at ~2 ms. If jitter feels inconsistent, try `-9`.
- Settings live in `SPVAR_1`–`SPVAR_12`, bit-packed. `SPVAR_12` holds a magic
  value (77) so a fresh device falls back to defaults instead of garbage.
