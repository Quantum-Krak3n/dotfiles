{ ... }:

{
  imports = [ ./modules.nix ];

  programs.waybar = {
    enable = true;

    style = builtins.readFile ./style.css;

    settings.main-bar = {
      #output = "eDP-1";

      modules-left = [
        "user"
        "hyprland/window"
      ];
      modules-center = [ "hyprland/workspaces" ];
      modules-right = [
        "tray"
        "mpd"
        "pulseaudio"
        "network"
        "bluetooth"
        "cpu"
        "memory"
        "keyboard-state"
        "battery"
        "clock"
      ];
    };
  };
}
