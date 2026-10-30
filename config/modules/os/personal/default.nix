{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ../common
    ./base.nix
    ./regreet.nix
    ./thunar.nix
    ./audio.nix
  ];

  nixpkgs.overlays = [ inputs.nix-vscode-extensions.overlays.default ];

  programs = {
    hyprland = {
      enable = true; # Enable system wide, configure in HM
      # Use the flake package
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # Make sure to also set the portal package, so that they are in sync
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    gamemode.enable = true;
  };

  services = {
    avahi = { # For printing
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    printing = {
      enable = true;
      drivers = with pkgs; [
        cups-filters
        cups-browsed
      ];
    };
  };
}
