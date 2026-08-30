-- OLED-like grade: toggled by ~/.local/state/omarchy/oled-look
--   ~/.config/hypr/scripts/oled-look.sh on|off
do
  local home = os.getenv("HOME") or ""
  local flag = (os.getenv("XDG_STATE_HOME") or (home .. "/.local/state")) .. "/omarchy/oled-look"
  local shader = home .. "/.config/hypr/shaders/oled-look.frag"
  local enabled = io.open(flag, "r")
  if enabled then
    enabled:close()
    hl.config({ decoration = { screen_shader = shader } })
  else
    hl.config({ decoration = { screen_shader = "" } })
  end
end
