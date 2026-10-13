#!/usr/bin/env bash
# OLED-like grade for LCD monitors on Hyprland.
#
# Hardware: 6500 K (D65). Contrast/sat/brightness VCP writes are ignored
# by many cheap Mstar panels; those live in shaders/oled-look.frag.
#
# Stock (this VIE CZ270F100, before the profile): 9300 K, RGB 38/39/49,
# no screen shader.
#
# Usage: oled-look.sh on|off
set -u

FLAG="${XDG_STATE_HOME:-$HOME/.local/state}/omarchy/oled-look"
SHADER="$HOME/.config/hypr/shaders/oled-look.frag"

usage() {
  echo "Usage: $0 on|off" >&2
  exit 1
}

[[ $# -eq 1 ]] || usage
cmd=$1

mkdir -p "$(dirname "$FLAG")"

set_preset() {
  ddcutil --skip-ddc-checks --noverify setvcp 14 "$1" >/dev/null || true
  ddcutil --skip-ddc-checks scs >/dev/null 2>&1 || true
}

apply_shader() {
  command -v hyprctl >/dev/null || return 0
  # Reload so looknfeel.lua can pick up the flag. Keyword is the fallback
  # if that snippet was wiped (omarchy refresh looknfeel).
  hyprctl reload >/dev/null
  hyprctl keyword decoration:screen_shader "$1" >/dev/null
}

case $cmd in
  on)
    [[ -f $SHADER ]] || { echo "missing shader: $SHADER" >&2; exit 1; }
    : >"$FLAG"
    set_preset 0x05
    apply_shader "$SHADER"
    ;;
  off)
    rm -f "$FLAG"
    set_preset 0x08
    apply_shader ""
    ;;
  *)
    usage
    ;;
esac
