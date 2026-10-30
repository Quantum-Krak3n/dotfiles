{
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix

    # Dell Inspiron 13 5320
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
    "${inputs.nixos-hardware}/common/cpu/intel/alder-lake"

    ../../modules/os/personal
  ];

  networking.hostName = "vecna";

  boot.loader.grub.useOSProber = true;

  # FIXME
  # services.evremap = {
  #   enable = true; # Enabled here, configured in os/personal/base.nix
  #   settings.device_name = "Framework Laptop 16 Keyboard Module - ANSI Keyboard"; # evremap list-devices
  # };
}
