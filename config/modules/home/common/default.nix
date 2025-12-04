{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./base.nix

    ./shell
    ./java.nix
  ];

  home.packages = with pkgs; [
    wget
    btop
    zip
    unzip
    traceroute
    jq
    file
  ];

  programs = {
    zellij = {
      enable = true;
    };

    delta = {
      enable = true; # Syntax hilighting
      enableGitIntegration = true;
    };

    git = {
      enable = true;

      settings = {
        credential.helper = "store";
        init.defaultBranch = "main";
        url."https://github.com/".insteadOf = [
          "gh:"
          "github:"
        ];
        user = {
          email = "matt@barbermurphy.id.au";
          name = "Matthew Murphy";
        };
      };
    };
  };
}
