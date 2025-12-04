{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  boot.kernelPackages = pkgs.linuxPackages_latest; # Sets the kernel version https://nixos.wiki/wiki/Linux_kernel

  systemd.oomd.enableUserSlices = true; # I don't remember why

  nixpkgs.config = {
    allowUnfree = true;
  };

  nix.settings = {
    trusted-users = [ "@wheel" ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true; # Combine duplicates

    # List of binary cache URLs used to obtain pre-built binaries of Nix packages
    substituters = [
      "https://nix-community.cachix.org"
    ];
    trusted-substituters = [
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  time.timeZone = "Australia/Melbourne";

  i18n.defaultLocale = "en_AU.UTF-8";

  users = {
    groups.matt.gid = 1000;
    users.matt = {
      uid = 1000;
      description = "Matthew Murphy";
      createHome = true;
      home = "/home/matt";
      group = "matt";
      extraGroups = [
        "wheel"
        "networkmanager"
        "adbusers"
        "libvirtd"
        "docker"
        "kvm"
        "tty"
        "dialout"
      ];
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9kVH5ybQdbqUxpJF2ryMQfqmpYSXj9iprIleVTrcCWfapCxYvQWx/XBiIoUaX9j+8Qlo53UT1tKqOWFlwK3Np0JjlcR3vpTCsXCn8YHlX3J9oPPmRfy+mS2TonV+wnnyJxq6oqmwYRl4OoThEFyOrsvX7+LbHBl6lvduGRRqtmSfPw+03Eqbrf8kPlIiEy3iC4ir70I1H/U15iXm7A0AQ4dtfqAjnrA/NhnuRr4BTBqxwS4bPgH8fmNRuoIQBee2F1i0dgkcOTkz3bnj6Hn4fSOlJY4IhGdKEgBhaQuAd0ZmfflVJDBkaf5vV7ifrrd1jGpKWVwUVwGkA9NjlunzP"
      ];
    };
  };

  services = {
    openssh.enable = true;
  };
}
