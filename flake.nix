{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs"; # this line is optional, prevents downloading two versions of nixpkgs but disables cache
    };
    # noctalia.url = "github:noctalia-dev/noctalia/cachix";

    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      noctalia,
      noctalia-greeter,
      ...
    }:
    let
      mkHost =
        hostname:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };

          modules = [
            ./hosts/${hostname}
            ./modules/system

            home-manager.nixosModules.home-manager
            {
              networking.hostName = hostname;

              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.yjc = import ./modules/user;
                extraSpecialArgs = { inherit inputs; };
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        nixos = mkHost "nixos";
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;
    };
}
