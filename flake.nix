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
          personal = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDlNlKIUyEMf23RugEgJXDMvNY2zDlM3IhONc3/NP4JD9ppoEcUE+JOAl6eVrMox/Q36ZcTHML8BxZfhQoXIGKZWq7ZwFX8pn5SFdNg5OZnY8e/NEEFA/EVOUvP/3L2+Rdkclwz5Rp1UL7Sv5gq98ZzuhxgDZDulDYknd5OGaBHWjrMo1b4Z9li/6aTCs53zl4/38o/TxDGHBiuNDWHtKkdJT47LQ3NVwkh8IP1Id8ZOhoZ0CHimTt0cUg45KLurH2tAU4PxPsaeaSwa6jMjBAY26I/6tadG4ztWlGGqsCYhwCsqCcOH0CRbfKi+qgqHuwa4Sw62fMdhqXl09zPf/VdY3HKdWL0gfyxV3uMTf2OEue6//SiWOJZRQZ9qVpLm5c13+y0A/RXpC3hS8gPvunVkGnj82lxPFrCLx9jYkhvRPLh+eUxwHjUIswFRGgX5vuxEt+0RTGs5jH2CIl5IdviBVWz5GsxcvyqRAuDKu9EkNNawfx1wr//09eBhNMvBw8=";
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
