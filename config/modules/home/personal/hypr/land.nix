{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:

{
  home.file.".config/hypr/hyprland.lua".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/modules/home/personal/hypr/lang.lua";

  # wayland.windowManager = {
  #   hyprland = {
  #     enable = true;

  #     # Use the flake package
  #     package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  #     # Make sure to also set the portal package, so that they are in sync
  #     portalPackage =
  #       inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

  #     # Tell systemd to import the environment, otherwise it won't find some binaries
  #     systemd.variables = [ "--all" ];

  #     settings = {};
  #   };
  # };
}
