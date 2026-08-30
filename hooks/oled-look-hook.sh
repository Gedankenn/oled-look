#!/usr/bin/env bash
# Re-apply 6500 K if the OLED-like profile is enabled.
FLAG="${XDG_STATE_HOME:-$HOME/.local/state}/omarchy/oled-look"
[[ -f $FLAG ]] || exit 0
sleep 1
ddcutil --skip-ddc-checks --noverify setvcp 14 0x05 >/dev/null || true
ddcutil --skip-ddc-checks scs >/dev/null 2>&1 || true
