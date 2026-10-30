{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nixos-hardware,
      ...
    }:
    let
      user = {
        fullName = "Matthew Murphy";
        name = "matt";
        email = "matt@barbermurphy.id.au";

        sshKeys = {
          # FIXME
          personal = "ssh-rsa AAAAAAAAAAAAAAAAAAAAAAA";
        };

        stateVersion = "26.11"; # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration, and migrated your data accordingly. https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
      };
    in
    {
      nixosConfigurations.vecna =
        let
          specialArgs = {
            inherit inputs user;
            # Equivalent to:
            # inputs = inputs;
            # user = user;
          };
        in
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            ./config/hosts/vecna/os.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                extraSpecialArgs = specialArgs;
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${user.name} = import ./config/hosts/vecna/home.nix;
              };
            }
          ];
        };

      inherit inputs; # Useful for nix repl
    };
}
