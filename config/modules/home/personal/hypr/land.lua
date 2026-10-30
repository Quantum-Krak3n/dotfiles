-- functions
local brightness_accumulator = 0
local change_brightness = function(change)
  hl.exec_cmd("brightnessctl --min-value=4000 --exponent=3 s " .. (change < 0 and (math.abs(change) .. "%-") or ("+" .. math.abs(change) .. "%")))
end
local brightness_gesture = function(change)
  brightness_accumulator = brightness_accumulator + (-0.25 * change)
  local int_part = math.floor(brightness_accumulator)
  brightness_accumulator = brightness_accumulator - int_part
  change_brightness(int_part)
end

local change_volume = function(change)
  hl.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ " .. math.abs(change) .. "%" .. (change < 0 and "-" or "+"))
end
local volume_gesture = function(change)
  change_volume(-0.25 * change)
end

-- settings.curve
hl.curve("myBezier", {
  points = { { 0.05, 0.9 }, { 0.1, 1.05 } },
  type = "bezier",
})

-- settings.animation
hl.animation({
  bezier = "myBezier",
  enabled = true,
  leaf = "windows",
  speed = 7,
})
hl.animation({
  bezier = "default",
  enabled = true,
  leaf = "windowsOut",
  speed = 7,
  style = "popin 80%",
})
hl.animation({
  bezier = "default",
  enabled = true,
  leaf = "border",
  speed = 10,
})
hl.animation({
  bezier = "default",
  enabled = true,
  leaf = "borderangle",
  speed = 8,
})
hl.animation({
  bezier = "default",
  enabled = true,
  leaf = "fade",
  speed = 7,
})
hl.animation({
  bezier = "default",
  enabled = true,
  leaf = "workspaces",
  speed = 6,
})

-- settings.bind
hl.bind("META + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("META + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind("META + ALT + mouse:273", hl.dsp.window.resize({ keep_aspect_ratio = true }), { mouse = true })
hl.bind("META + RETURN", hl.dsp.exec_cmd("ghostty"))
hl.bind("META + C", hl.dsp.exec_cmd("code"))
hl.bind("META + E", hl.dsp.exec_cmd("thunar"))
hl.bind("META + SPACE", hl.dsp.exec_cmd("wofi --insensitive --show drun"))
hl.bind("META + B", hl.dsp.exec_cmd("firefox"))
hl.bind("META + S", hl.dsp.exec_cmd("spotify"))
hl.bind("META + V", hl.dsp.exec_cmd("cliphist list | wofi -S dmenu | cliphist decode | wl-copy"))
hl.bind("META + N", hl.dsp.exec_cmd("obsidian"))
hl.bind("META + ALT + B", hl.dsp.exec_cmd("pkill -USR1 waybar || ~/dotfiles/scripts/reload-waybar.sh")) -- Send "User Signal 1" to waybar which toggles it's visibility
hl.bind("CTRL + ALT + DELETE", hl.dsp.exec_cmd("wlogout"))
hl.bind("META + Q", hl.dsp.window.close())
hl.bind("META + ALT + Q", hl.dsp.window.kill()) -- Force kill
hl.bind("META + ALT + T", hl.dsp.window.float())
hl.bind("META + P", hl.dsp.window.pseudo())
hl.bind("META + ALT + S", hl.dsp.window.toggle_swallow())

-- Toggle Picture in Picture
-- hl.bind("META + ALT + P", (function()
--   local w = hl.get_active_window()
--   for index, value in ipairs(w.tags) do
--     if value == 'PIP*' then
--       hl.dispatch(hl.dsp.window.pin({ action = 'off', window = w }))
--       hl.dispatch(hl.dsp.window.float({ action = 'off', window = w }))
--       hl.dispatch(hl.dsp.window.tag({ tag = '-PIP*', window = w }))
--       return
--     end
--   end

--   hl.dispatch(hl.dsp.window.tag({ tag = '+PIP*', window = w }))
--   hl.dispatch(hl.dsp.window.float({ action = 'on', window = w }))
--   hl.dispatch(hl.dsp.window.pin({ action = 'on', window = w }))
--   hl.dispatch(hl.dsp.window.move({ x = w.monitor.size.width - w.size.x - 640, y = w.monitor.size.height - w.size.y - 400, window = w }))
-- end
-- ))

hl.bind("META + M", hl.dsp.window.fullscreen_state({ internal = 1, client = 1, action = "toggle" })) -- Toggle maximised
hl.bind("META + F", hl.dsp.window.fullscreen_state({ internal = 2, client = 2, action = "toggle" })) -- Toggle fullscreen
hl.bind("META + ALT + F", hl.dsp.window.fullscreen_state({ internal = 2, client = 0 })) -- Set fullscreen, but make the app think it's windowed
hl.bind("META + ALT + M", hl.dsp.window.fullscreen_state({ internal = 1, client = 2 })) -- Set maximised, but make the app think it's fullscreen
hl.bind("META + ALT + N", hl.dsp.window.fullscreen_state({ internal = 0, client = 2 })) -- Set windowed, but make the app think it's fullscreen

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("ALT+ XF86AudioPrev", hl.dsp.exec_cmd("playerctl position 10-"))
hl.bind("ALT+ XF86AudioNext", hl.dsp.exec_cmd("playerctl position 10+"))

hl.bind("XF86AudioRaiseVolume", function() change_volume(5) end, { repeating = true })
hl.bind("XF86AudioLowerVolume", function() change_volume(-5) end, { repeating = true })
hl.bind("XF86MonBrightnessUp", function() change_brightness(10) end, { repeating = true })
hl.bind("XF86MonBrightnessDown", function() change_brightness(-10) end, { repeating = true })

hl.bind("Print", hl.dsp.exec_cmd("/home/alice/dotfiles/scripts/screenshot.sh"))
hl.bind("META + Print", hl.dsp.exec_cmd("/home/alice/dotfiles/scripts/screenshot.sh -e"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd("hyprpicker -a"))

-- Move focus
hl.bind("META + H", hl.dsp.focus({ direction = "l" }))
hl.bind("META + L", hl.dsp.focus({ direction = "r" }))
hl.bind("META + K", hl.dsp.focus({ direction = "u" }))
hl.bind("META + J", hl.dsp.focus({ direction = "d" }))

-- Move window
hl.bind("META + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind("META + SHIFT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind("META + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind("META + SHIFT + J", hl.dsp.window.move({ direction = "d" }))
hl.bind("META + SHIFT + SEMICOLON", hl.dsp.layout("rotatesplit 90"))
hl.bind("META + ALT + SEMICOLON", hl.dsp.layout("movetoroot"))

-- Switch workspaces
hl.bind("META + Y", hl.dsp.focus({ workspace = "r-1" }))
hl.bind("META + O", hl.dsp.focus({ workspace = "r+1" }))
hl.bind("META + 1", hl.dsp.focus({ workspace = "1" }))
hl.bind("META + 2", hl.dsp.focus({ workspace = "2" }))
hl.bind("META + 3", hl.dsp.focus({ workspace = "3" }))
hl.bind("META + 4", hl.dsp.focus({ workspace = "4" }))
hl.bind("META + 5", hl.dsp.focus({ workspace = "5" }))
hl.bind("META + 6", hl.dsp.focus({ workspace = "6" }))
hl.bind("META + 7", hl.dsp.focus({ workspace = "7" }))
hl.bind("META + 8", hl.dsp.focus({ workspace = "8" }))
hl.bind("META + 9", hl.dsp.focus({ workspace = "9" }))
hl.bind("META + 0", hl.dsp.workspace.toggle_special("special"))

-- Bring window to workspace
hl.bind("META + SHIFT + Y", hl.dsp.window.move({ workspace = "-1" }))
hl.bind("META + SHIFT + O", hl.dsp.window.move({ workspace = "+1" }))
hl.bind("META + SHIFT + 1", hl.dsp.window.move({ workspace = "1" }))
hl.bind("META + SHIFT + 2", hl.dsp.window.move({ workspace = "2" }))
hl.bind("META + SHIFT + 3", hl.dsp.window.move({ workspace = "3" }))
hl.bind("META + SHIFT + 4", hl.dsp.window.move({ workspace = "4" }))
hl.bind("META + SHIFT + 5", hl.dsp.window.move({ workspace = "5" }))
hl.bind("META + SHIFT + 6", hl.dsp.window.move({ workspace = "6" }))
hl.bind("META + SHIFT + 7", hl.dsp.window.move({ workspace = "7" }))
hl.bind("META + SHIFT + 8", hl.dsp.window.move({ workspace = "8" }))
hl.bind("META + SHIFT + 9", hl.dsp.window.move({ workspace = "9" }))

-- Throw window to workspace
hl.bind("META + ALT + Y", hl.dsp.window.move({ workspace = "-1", follow = false }))
hl.bind("META + ALT + O", hl.dsp.window.move({ workspace = "+1", follow = false }))
hl.bind("META + ALT + 1", hl.dsp.window.move({ workspace = "1", follow = false }))
hl.bind("META + ALT + 2", hl.dsp.window.move({ workspace = "2", follow = false }))
hl.bind("META + ALT + 3", hl.dsp.window.move({ workspace = "3", follow = false }))
hl.bind("META + ALT + 4", hl.dsp.window.move({ workspace = "4", follow = false }))
hl.bind("META + ALT + 5", hl.dsp.window.move({ workspace = "5", follow = false }))
hl.bind("META + ALT + 6", hl.dsp.window.move({ workspace = "6", follow = false }))
hl.bind("META + ALT + 7", hl.dsp.window.move({ workspace = "7", follow = false }))
hl.bind("META + ALT + 8", hl.dsp.window.move({ workspace = "8", follow = false }))
hl.bind("META + ALT + 9", hl.dsp.window.move({ workspace = "9", follow = false }))

-- settings.config
hl.config({
  binds = { allow_pin_fullscreen = true },
  decoration = {
    active_opacity = 1,
    blur = {
      enabled = true,
      passes = 1,
      size = 3,
    },
    border_part_of_window = false,
    dim_inactive = true,
    dim_strength = 0.1,
    fullscreen_opacity = 1,
    inactive_opacity = 1,
    rounding = 15,
  },
  dwindle = { preserve_split = true },
  ecosystem = {
    no_donation_nag = true,
    no_update_news = true,
  },
  general = {
    border_size = 0,
    col = {
      active_border = "rgb(FFA348)",
      inactive_border = "rgb(595959)",
    },
    gaps_in = 2,
    gaps_out = 4,
    gaps_workspaces = 10,
    layout = "dwindle",
    no_focus_fallback = true,
  },
  gestures = {
    workspace_swipe_direction_lock = false,
    workspace_swipe_distance = 400,
    workspace_swipe_forever = true,
  },
  input = {
    follow_mouse = 1,
    kb_layout = "us,gr",
    kb_options = "grp:alt_space_toggle",
    numlock_by_default = true,
    sensitivity = 0,
    special_fallthrough = true,
    touchpad = {
      disable_while_typing = true,
      natural_scroll = true,
    },
  },
  misc = {
    disable_hyprland_logo = false,
    disable_splash_rendering = false,
    enable_swallow = false,
    force_default_wallpaper = 2,
    initial_workspace_tracking = 0,
    middle_click_paste = false,
    on_focus_under_fullscreen = 2,
    swallow_regex = "com.mitchellh.ghostty",
    vrr = 3,
  },
  xwayland = { force_zero_scaling = true },
})

-- settings.env
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("GDK_SCALE", "1")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("XCURSOR_SIZE", "24")
hl.env("APPIMAGELAUNCHER_DISABLE", "1")
hl.env("OZONE_PLATFORM", "wayland")

-- settings.gesture
hl.gesture({
  action = {
    start = function(e) volume_gesture(e.delta.y) end,
    update = function(e) volume_gesture(e.delta.y) end,
  },
  direction = "vertical",
  fingers = 3,
})
hl.gesture({
  action = {
    start = function(e)
      brightness_accumulator = 0
      brightness_gesture(e.delta.y)
    end,
    update = function(e) brightness_gesture(e.delta.y) end,
  },
  direction = "vertical",
  fingers = 3,
  mods = "SHIFT",
})
hl.gesture({
  action = "workspace",
  direction = "horizontal",
  fingers = 3,
  scale = 2,
})
hl.gesture({
  action = function(e) hl.exec_cmd("playerctl play-pause") end,
  direction = "down",
  fingers = 4,
})
hl.gesture({
  action = function(e) hl.exec_cmd("playerctl previous") end,
  direction = "right",
  fingers = 4,
})
hl.gesture({
  action = function(e) hl.exec_cmd("playerctl next") end,
  direction = "left",
  fingers = 4,
})
hl.gesture({
  action = function(e) hl.exec_cmd("playerctl position 10-") end,
  direction = "right",
  fingers = 4,
  mods = "SHIFT",
})
hl.gesture({
  action = function(e) hl.exec_cmd("playerctl position 10+") end,
  direction = "left",
  fingers = 4,
  mods = "SHIFT",
})

-- settings.monitor
hl.monitor({
  -- mode = "2560x1600@165", -- FIXME
  output = "eDP-1",
  position = "auto",
  scale = 1.333333,
})
hl.monitor({
  mode = "preferred",
  output = "",
  position = "auto",
  scale = "auto",
})

-- settings.on
hl.on("hyprland.start", function()
  -- hl.dispatch(hl.dsp.focus({ workspace = 2 })) -- Start on workspace 2 (with firefox)
  hl.exec_cmd("waybar")
  -- hl.exec_cmd("spotify", { workspace = "1 silent" })
  -- hl.exec_cmd("firefox", { workspace = "2 silent" })
  hl.exec_cmd("beeper &") -- Run beeper in the background
end)

-- Some things should always be floating windows
hl.window_rule({
  float = true,
  match = {
    class = "thunar",
    title = "(File Operation Progress)|(Rename.*)",
  },
})
hl.window_rule({
  float = true,
  match = { title = "((Add|Open).*(File|Folder))|((Select).*(open))" },
})

-- Pretty border in fullscreen
hl.window_rule({
  border_color = {
    angle = 45,
    colors = { "rgb(FF0000)", "rgb(00FF00)", "rgb(0000FF)" },
  },
  border_size = 2,
  match = { fullscreen = true },
})

-- Picture in Picture
hl.window_rule({ -- Tag windows (so you can toggle the tag with a keybind if you want)
  match = { title = "Picture-in-Picture" },
  tag = "+PIP",
})
hl.window_rule({
  match = { tag = "PIP" },
  float = true, -- Keep on top
  move = { "monitor_w-window_w", "monitor_h-window_h" }, -- Bottom right
  opacity = "0.2 1", -- Transparent when mouse over (so you can see under)
  pin = true, -- On all workspaces
})

-- Don't go to sleep when something is fullscreen
hl.window_rule({
  idle_inhibit = "fullscreen",
  match = { class = ".*" },
})

-- Don't let apps maximise themself (some do it at startup)
hl.window_rule({
  match = { class = ".*" },
  suppress_event = "maximize",
})

-- IDK, something nix related probably
hl.on("hyprland.start", function()
  hl.exec_cmd("dbus-update-activation-environment --systemd --all && systemctl --user stop hyprland-session.target && systemctl --user start hyprland-session.target")
end)
hl.on("hyprland.shutdown", function()
  os.execute("systemctl --user stop hyprland-session.target && sleep 0.1")
end)
