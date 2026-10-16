{
  pkgs,
  ...
}:

{
  imports = [ ];

  services.displayManager.regreet = {
    enable = true;
    cageArgs = [
      "-s"
      "-d"
      "-m"
      "last"
    ];
    font.package = pkgs.roboto;
    font.name = "Roboto";
    settings = {
      GTK = {
        application_prefer_dark_theme = true;
      };
    };
  };
}
