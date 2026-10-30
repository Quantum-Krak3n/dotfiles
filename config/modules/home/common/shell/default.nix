{ ... }:

{
  imports = [
    ./bash.nix
    ./starship.nix
    ./fetch.nix
    ./zellij.nix
  ];

  programs = {
    zoxide = { # cd alternative
      enable = true;
      enableBashIntegration = true;
      options = [ "--cmd cd" ];
    };
  };
}
