{
  pkgs,
  ...
}:

{
  imports = [
    ./waybar
    ./land.nix
    ./idle.nix
    ./lock.nix
    ./wlogout.nix
  ];

  home.pointerCursor = {
    enable = true;
    hyprcursor.enable = true;
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 18;
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 18;
    };
  };
}
