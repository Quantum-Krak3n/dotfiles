{
  wayland.windowManager = {
    hyprland = {
      enable = true;
      settings = {
        # https://wiki.hyprland.org/Configuring/Binds/
        # use `wev` to figure out what key is what

        # Non-repeating
        bind = [
          # Actions
          "META, RETURN, exec, alacritty"
          "META, B, exec, firefox" # Opens the browser

          "META, SPACE, exec, wofi --show drun" # Open wofi to run .desktop entries
          "META ALT, SPACE, exec, wofi --show run" # Open to run from path

          # "CTRL ALT ALT, DELETE, exec, wlogout" # TODO
          "CTRL ALT ALT, DELETE, exec, loginctl terminate-user $USER" # Interim, just kill hyprland

          "META, Q, killactive" # Close current window
          "META ALT, Q, forcekillactive" # Kill current window
          "META, T, togglefloating" # Toggle between tiling and floating window
          "META, P, pseudo," # Psudotiling (floating window, centered in a tile)
          "META, F, fullscreen, 0" # fullscreen
          "META, M, fullscreen, 1" # maximise

          "META, J, togglesplit," # flip between horizontal and vertical split
          # "META, L, exec, hyprlock --immediate & loginctl lock-session" # lock TODO

          # Media keys
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86AudioNext, exec, playerctl next"
          "SHIFT, XF86AudioPrev, exec, playerctl position 10-"
          "SHIFT, XF86AudioNext, exec, playerctl position 10+"

          # Move focus with mod + arrow keys
          "META, left, movefocus, l" # Move focus left
          "META, right, movefocus, r" # Move focus right
          "META, up, movefocus, u" # Move focus up
          "META, down, movefocus, d" # Move focus down

          # Move window
          "META SHIFT, left, movewindow, l" # Move focus left
          "META SHIFT, right, movewindow, r" # Move focus right
          "META SHIFT, up, movewindow, u" # Move focus up
          "META SHIFT, down, movewindow, d" # Move focus down

          # Move workspace to monitor
          "META ALT, left, moveworkspacetomonitor, +0 l" # Move focus left
          "META ALT, right, moveworkspacetomonitor, +0 r" # Move focus right
          "META ALT, up, moveworkspacetomonitor, +0 u" # Move focus up
          "META ALT, down, moveworkspacetomonitor, +0 d" # Move focus down

          # Switch workspaces with mod + [ or ]
          "META, bracketright, workspace, r+1" # Switch to workspace right
          "META, bracketleft, workspace, r-1" # Switch to workspace left

          # Move active window to a workspace with mod + SHIFT + [ or  ]
          "META SHIFT, bracketright, movetoworkspace, +1" # Move window to workspace right
          "META SHIFT, bracketleft, movetoworkspace, -1" # Move window to workspace left

          # Move active window to a workspace and don't move focus with mod + alt + [ or ]
          "META ALT, bracketright, movetoworkspacesilent, +1" # Move window to workspace right
          "META ALT, bracketleft, movetoworkspacesilent, -1" # Move window to workspace left
        ]
        ++ (builtins.concatLists (
          builtins.genList
            # For numbers 1-9
            (
              i:
              let
                ws = i + 1;
              in
              [
                "META, code:1${toString i}, workspace, ${toString ws}" # Switch workspaces with mod + [0-9]
                "META SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}" # Move active window to a workspace with mod + SHIFT + [0-9]
                "META ALT, code:1${toString i}, movetoworkspacesilent, ${toString ws}" # Move active window to a workspace with mod + alt + [0-9] DONT MOVE FOCUS
              ]
            )
            9
        ));

        # Repeating
        binde = [
          # Volume
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+" # Limit volume to 150%

          # Screen brightness
          ", XF86MonBrightnessUp, exec, brightnessctl --min-value=235 --exponent=3 s +10%"
          ", XF86MonBrightnessDown, exec, brightnessctl --min-value=235 --exponent=3 s 10%-"
        ];

        # Mouse
        # Move/resize windows with mod + LMB/RMB and dragging
        bindm = [
          "META, mouse:272, movewindow" # Move window
          "META, mouse:273, resizewindow" # Resize window
        ];
      };
    };
  };
}
