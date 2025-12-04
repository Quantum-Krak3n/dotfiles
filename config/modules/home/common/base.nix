{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "matt";
  home.homeDirectory = "/home/matt";
  home.sessionPath = [ "$HOME/dotfiles/scripts" ];

  home.sessionVariables = {
    SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
    EDITOR = "nano";
    VISUAL = "nano";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
