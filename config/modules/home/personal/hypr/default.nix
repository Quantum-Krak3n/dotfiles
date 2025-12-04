{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./binds.nix
    ./env.nix
  ];

  wayland.windowManager = {
    hyprland = {
      enable = true;

      # Tell systemd to import the environment, otherwise it won't find some binaries
      systemd.variables = [ "--all" ];

      settings = {
        # debug.disable_logs = false; # Uncomment to print full logs

        # See https://wiki.hyprland.org/Configuring/Monitors/
        # Run `hyprctl monitors all`
        # monitor = ",2560x1600@165,auto,1.333333"; # TODO

        # https://wiki.hypr.land/Configuring/Variables/#general
        general = {
          gaps_in = 2;
          gaps_out = 4;
          gaps_workspaces = 10;
        };

        input = {
          kb_layout = "us";
          numlock_by_default = true;

          follow_mouse = 1; # Focus follows mouse https://wiki.hypr.land/Configuring/Variables/#:~:text=Follow%20Mouse%20Cursor
        };

        # https://wiki.hyprland.org/Configuring/Dwindle-Layout/
        dwindle = {
          pseudotile = true; # master switch to allow, can be applied to a window with a keybind
          preserve_split = true; # you probably want this
        };

        # Execute your favorite apps at launch
        # exec-once = [ "waybar &" ]; # TODO
      };
    };
  };
}
