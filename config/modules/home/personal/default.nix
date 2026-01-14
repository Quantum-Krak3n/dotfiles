{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [ ./hypr ];

  home.packages = with pkgs; [
    # nodejs
    # gcc
  ];

  programs = {
    firefox.enable = true;
    wofi.enable = true; # Spotlight search
    alacritty.enable = true; # Terminal
  };

  services = {
    dunst.enable = true; # Notification daemon
  };
}
