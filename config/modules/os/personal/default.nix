{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
  ];
  
  programs = {
    hyprland.enable = true; # Enable system wide, configure in HM
    regreet.enable = true;
  };

  programs.nix-ld.enable = true; # https://nix.dev/guides/faq#how-to-run-non-nix-executables
  programs.nix-ld.libraries = with pkgs; [
    # https://github.com/cloudflare/workerd/discussions/1515#discussioncomment-10029667
    stdenv.cc.cc
    zlib
    fuse3
    icu
    nss
    openssl
    curl
    expat
  ];
}
