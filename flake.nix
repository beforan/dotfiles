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

    nixGL = {
      url = "github:nix-community/nixGL/310f8e49a149e4c9ea52f1adf70cdc768ec53f8a";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    home-manager,
    mac-app-util,
    nix-darwin,
    nixpkgs,
    nixGL,
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
        extraSpecialArgs = {
          inherit inputs;
        };
      };
      "beforan@auron" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./nixfiles/auron/home.nix
        ];
        extraSpecialArgs = {
          inherit inputs;
        };
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

    # NixOS configurations
    # Build NixOS flake using:
    # $ sudo nixos-rebuild switch --flake .
    
    # Auron is currently Fedora + Home Manager
    # Configuration below remains as an example for a NixOS Host
    # nixosConfigurations.auron = nixpkgs.lib.nixosSystem {
    #  system = "x86_64-linux";
    #  modules = [
    #    ./nixfiles/auron/configuration.nix

        # make home-manager as a module of nixos
        # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
    #    home-manager.nixosModules.home-manager
    #    {
    #      home-manager.useGlobalPkgs = true;
    #      home-manager.useUserPackages = true;

    #      home-manager.users.beforan = import ./nixfiles/auron/home.nix;
    #    }
    #  ];
    #  specialArgs = {
    #    inherit inputs;
    #  };
    #};
  };
}
