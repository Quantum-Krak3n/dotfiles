{
  pkgs,
  lib,
  user,
  ...
}:

{
  imports = [ ./shell/bash.nix ];

  home.packages = with pkgs; [
    wget
    zip
    unzip
    traceroute
    jq
    fzf
    gawk
    file
    patchelf
    nh
    tree
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = lib.mkDefault user.name;
  home.homeDirectory = lib.mkDefault "/home/${user.name}";
  home.sessionPath = [ "$HOME/dotfiles/scripts" ];

  home.sessionVariables = {
    SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
    EDITOR = "nano";
    VISUAL = "nano";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = user.stateVersion;
}
