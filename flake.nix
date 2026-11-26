{
  description = "Wynn NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    noctalia.url = "github:noctalia-dev/noctalia/cachix";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      username = "wynn";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit username; };

        modules = [
          ./configuration.nix

          home-manager.nixosModules.home-manager
          inputs.sops-nix.nixosModules.sops

          {
            sops.age.keyFile = "/var/lib/sops-nix/key.txt";
          }

          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;

              extraSpecialArgs = {
                inherit inputs username;
              };

              users.${username} = import (./home + "/${username}");
            };
          }
        ];
      };

      devShells.${system} = {
        default = pkgs.mkShell {
          packages = with pkgs; [
            git
            nixfmt
            nil
            statix
            pre-commit
          ];
        };

        javascript = pkgs.mkShell {
          packages = with pkgs; [
            nodejs
            pnpm
          ];
        };

        python = pkgs.mkShell {
          packages = with pkgs; [
            python3
            uv
            python3Packages.pytest
            ruff
          ];
        };

        unity = pkgs.mkShell {
          packages = with pkgs; [
            dotnet-sdk
          ];
        };
      };

      formatter.${system} = pkgs.nixfmt-tree;

      checks.${system} = {
        nixos-evaluation =
          assert self.nixosConfigurations.nixos.config.system.build.toplevel.drvPath != "";
          pkgs.runCommand "nixos-config-evaluation" { } ''
            touch "$out"
          '';

        niri-config =
          pkgs.runCommand "niri-config-validation"
            {
              nativeBuildInputs = [ self.nixosConfigurations.nixos.config.programs.niri.package ];
            }
            ''
              niri validate --config ${
                self.nixosConfigurations.nixos.config.home-manager.users.${username}.xdg.configFile."niri/config.kdl".source
              }
              touch "$out"
            '';
      };
    };
}
