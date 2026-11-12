
{
  description = "Wynn NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      # -----------------------------------------------
      # NixOS
      # -----------------------------------------------

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./configuration.nix

          home-manager.nixosModules.home-manager

          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;

              extraSpecialArgs = {
                inherit inputs;
              };

              users.wynn = import ./home/wynn;
            };
          }
        ];
      };

      # -----------------------------------------------
      # Development Shells
      # -----------------------------------------------

      devShells.${system} = {

        # JavaScript / TypeScript
        javascript = pkgs.mkShell {
          name = "wynn-javascript";

          packages = with pkgs; [
            nodejs
            pnpm
          ];

          shellHook = ''
            echo "Wynn JavaScript / TypeScript Environment"
            echo "Node.js: $(node --version)"
            echo "pnpm: $(pnpm --version)"
          '';
        };

        # Python
        python = pkgs.mkShell {
          name = "wynn-python";

          packages = with pkgs; [
            (python3.withPackages (pythonPackages: with pythonPackages; [
              pip
              pytest
            ]))

            ruff
          ];

          shellHook = ''
            echo "Wynn Python Development Environment"
            echo "Python: $(python --version)"
            echo "Ruff: $(ruff --version)"
          '';
        };

        # C# / Unity
        unity = pkgs.mkShell {
          name = "wynn-unity";

          packages = with pkgs; [
            dotnet-sdk
          ];

          shellHook = ''
            echo "Wynn Unity / C# Development Environment"
            echo ".NET SDK: $(dotnet --version)"
          '';
        };
      };
    };
}


