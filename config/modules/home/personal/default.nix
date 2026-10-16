{
  pkgs,
  ...
}:
{
  imports = [
    ../common
    ./base.nix
    ./hypr
    ./code
  ];

  home.packages = with pkgs; [
    spotify
    obsidian
    beeper

    hyprpicker # Colour picker
    wev # Waykand event viewer
    nodejs
    ffmpeg
    android-tools # adb etc
  ];
}
