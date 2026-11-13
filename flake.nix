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

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      # NixOS
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager

          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.wynn = import ./home/wynn;
            };
          }
        ];
      };

      # Development environments
      devShells.${system} = {
        default = pkgs.mkShell {
          name = "wynn-core";
          packages = with pkgs; [
            git
            nixfmt
            nil
            statix
          ];
        };

        javascript = pkgs.mkShell {
          name = "wynn-javascript";
          packages = with pkgs; [
            nodejs
            pnpm
          ];
        };

        python = pkgs.mkShell {
          name = "wynn-python";

          packages = [
            (pkgs.python3.withPackages (ps: [
              ps.pip
              ps.pytest
            ]))
            pkgs.uv
            pkgs.ruff
          ];
        };

        unity = pkgs.mkShell {
          name = "wynn-unity";
          packages = with pkgs; [
            dotnet-sdk
          ];
        };
      };

      # Nix formatter
      formatter.${system} = pkgs.nixfmt;
    };
}
