{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    mac-app-util.url = "github:hraban/mac-app-util";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    home-manager,
    mac-app-util,
    nix-darwin,
    nixpkgs,
  }: let
    # reusable home-manager config when
    # home-manager is used as a nix module (nixos or darwin)
    # NOT standalone
    home-manager-config = {
      username,
      path,
    }: {
      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        users.${username} = path;
        # sharedModules = [ ]; # TODO dunno what I'd use this for yet
        extraSpecialArgs = {
          inherit inputs;
        };
      };
    };
  in {
    # home-manager configurations
    homeConfigurations = {
      "beforan@cloud" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./nixfiles/cloud/home.nix
        ];
      };
    };

    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Shadow
    darwinConfigurations."Shadow" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        mac-app-util.darwinModules.default
        home-manager.darwinModules.default
        (home-manager-config {
          username = "beforan";
          path = ./nixfiles/Shadow/home.nix;
        })
        ./nixfiles/Shadow/configuration.nix
      ];
      specialArgs = {
        inherit inputs;
      };
    };

    # Expose the package set, including overlays, for convenience.
    # TODO should I do this in a shared config?
    # darwinPackages = self.darwinConfigurations."Shadow".pkgs;

    # Some day
    # nixosConfigurations = {}
  };
}
