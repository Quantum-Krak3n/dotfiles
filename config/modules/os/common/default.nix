{
  inputs,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./base.nix

    ./docker.nix
    ./oom.nix
  ];

  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (subject.isInGroup("wheel"))
          return polkit.Result.YES;
      });
    '';
  };

  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
  };

  system =
    let
      gitRevision = inputs.self.shortRev or inputs.self.dirtyShortRev or "UNKNOWN";
    in
    {
      # Display the latest git commit hash in `nixos-rebuild list-generations`
      configurationRevision = gitRevision;
      nixos.tags = [ gitRevision ];
    };

  boot = {
    kernel = {
      # Compressed RAM cache for swap pages
      sysfs.module.zswap.parameters = {
        enabled = true;
        compressor = "zstd";
        max_pool_percent = 20; # maximum percentage of RAM that zswap is allowed to use
        shrinker_enabled = true; # whether to shrink the pool proactively on high memory pressure
        accept_threshold_percent = 90; # hysteresis to refuse taking pages into zswap pool until it has sufficient space if the limit has been hit
      };
    };

    loader = {
      grub = {
        enable = true;
        configurationLimit = 50;
        efiSupport = lib.mkDefault true;
        device = lib.mkDefault "nodev";
      };

      efi.canTouchEfiVariables = lib.mkDefault true;
      timeout = 1;
    };
  };

  users.mutableUsers = false;

  programs = {
    bash.enable = true;
    appimage = {
      enable = true;
      binfmt = true; # Run appimages directly
    };
  };

  fonts.packages = [ pkgs.nerd-fonts.caskaydia-cove ];

  services = {
    btrfs.autoScrub.enable = lib.mkDefault true;
    fwupd.enable = true;

    # Better getty
    kmscon = {
      enable = true;
      config = {
        font-size = 14;
        font-name = "CaskaydiaCove Nerd Font";
        hwRender = true;
      };
    };
  };
}
