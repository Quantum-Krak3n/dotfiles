{
  config,
  pkgs,
  ...
}:
{
  home.packages = [ pkgs.nixd ];

  home.file.".config/Code/User/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/modules/home/personal/code/settings.jsonc";
  home.file.".config/Code/User/keybindings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/modules/home/personal/code/keybindings.jsonc";
  home.file.".config/Code/User/snippets".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/modules/home/personal/code/snippets";

  programs = {
    vscode = {
      enable = true;

      mutableExtensionsDir = true;
      profiles.default = {
        # https://github.com/nix-community/nix-vscode-extensions
        extensions = with pkgs; [ # FIXME
          # Themes
          vscode-marketplace.pkief.material-icon-theme
          vscode-marketplace.github.github-vscode-theme
          vscode-marketplace.oderwat.indent-rainbow

          # Languages
          vscode-marketplace.yzhang.markdown-all-in-one
          vscode-marketplace.bierner.markdown-preview-github-styles
          vscode-marketplace.mechatroner.rainbow-csv
          vscode-marketplace.jnoortheen.nix-ide

          # Utility
          vscode-marketplace.aaron-bond.better-comments
          vscode-marketplace.usernamehw.errorlens
          vscode-marketplace.ms-vscode.hexeditor
          vscode-marketplace.mhutchie.git-graph
          vscode-marketplace.streetsidesoftware.code-spell-checker
          vscode-marketplace.christian-kohler.path-intellisense
        ];
      };
    };
  };
}
