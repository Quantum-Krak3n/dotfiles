{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./base.nix
  ];

  services.btrfs.autoScrub.enable = true;

  networking.networkmanager.enable = true;

  boot = {
    loader = {
      grub = {
        enable = true;
        configurationLimit = 50;
      };

      timeout = 1;
    };
  };

  programs = {
    appimage = {
      enable = true;
      binfmt = true; # Run appimages directly
    };
  };
}
