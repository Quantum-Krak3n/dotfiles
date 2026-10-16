{
  pkgs,
  user,
  ...
}:

{
  imports = [
    ./base.nix

    ./shell
  ];

  xdg.enable = true;

  home.packages = with pkgs; [
    nix-search
    hwatch # better watch command
  ];

  programs = {
    ssh.enable = true;

    delta = {
      enable = true; # Git diff syntax hilighting
      enableGitIntegration = true;
    };

    git = {
      enable = true;
      lfs.enable = true;

      settings = {
        credential.helper = "store";
        init.defaultBranch = "main";
        url."https://github.com/".insteadOf = [
          "gh:"
          "github:"
        ];
        user = {
          email = user.email;
          name = user.fullName;
        };
        alias = {
          co = "checkout";
          cl = "clone";
          br = "branch";
          ci = "commit";
          st = "status";
          pl = "pull";
          ps = "push";
          rs = "reset";
          rh = "reset --hard HEAD";
          b = "bisect bad";
          g = "bisect good";
        };
      };
    };

    btop = {
      enable = true;
      # package = pkgs.btop-rocm # or pkgs.btop-cuda
      settings = {
        theme_background = false;
        presets = "";
        clock_format = "/host %X";
      };
    };
  };
}
