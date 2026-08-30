# oled-look

LCD “OLED-like” grade for [Hyprland](https://hypr.land) / [Omarchy](https://omarchy.org): 6500 K on the panel plus a screen shader (deeper blacks, S-curve contrast, restrained vibrance).

Tuned on a **VIE CZ270F100** (Mstar, HDMI). Contrast / saturation / brightness VCP writes are ignored on that panel; temperature and RGB are not.

```sh
oled-look.sh on    # 6500 K + shader
oled-look.sh off   # stock 9300 K, no shader
```

## Install

```sh
git clone https://github.com/Gedankenn/oled-look.git
cd oled-look

mkdir -p ~/.config/hypr/scripts ~/.config/hypr/shaders ~/.config/omarchy/hooks/post-boot.d

install -m 755 oled-look.sh ~/.config/hypr/scripts/oled-look.sh
install -m 644 shaders/oled-look.frag ~/.config/hypr/shaders/oled-look.frag
install -m 755 hooks/oled-look-hook.sh ~/.config/omarchy/hooks/post-boot.d/oled-look-hook.sh
```

Paste `snippets/looknfeel.lua` into `~/.config/hypr/looknfeel.lua`, then:

```sh
~/.config/hypr/scripts/oled-look.sh on
```

Needs `ddcutil` (already on Omarchy) and membership in the `video` group.

## Files

| Path | Role |
| --- | --- |
| `oled-look.sh` | Toggle: flag file + DDC preset + `hyprctl reload` |
| `shaders/oled-look.frag` | Hyprland `decoration:screen_shader` |
| `snippets/looknfeel.lua` | Enable shader only when the flag exists |
| `hooks/oled-look-hook.sh` | Re-apply 6500 K on Omarchy `post-boot` if enabled |

Flag: `~/.local/state/omarchy/oled-look`

Shader knobs in `oled-look.frag`: `CONTRAST`, `VIBRANCE`, `BLACK_CRUSH`, `GAMMA`.

## License

[MIT](LICENSE) © Fabio Slika Stella
