{
  description = "Darwin system flake";

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    mac-app-util.url = "github:hraban/mac-app-util";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixGL = {
      url = "github:nix-community/nixGL/310f8e49a149e4c9ea52f1adf70cdc768ec53f8a";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = inputs @ {
    self,
    home-manager,
    mac-app-util,
    nix-darwin,
    nixpkgs-stable,
    nixpkgs-unstable,
    nixGL,
  }: let
    # reusable home-manager config when
    # home-manager is used as a nix module (nixos or darwin)
    # NOT standalone
    mkHomeModuleConfig = {
      username,
      module,
      system ? "x86_64-linux",
    }: let
      stable = import nixpkgs-stable {inherit system;};
      unstable = import nixpkgs-unstable {inherit system;};
    in {
      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        users.${username} = module;
        # sharedModules = [ ]; # TODO dunno what I'd use this for yet
        extraSpecialArgs = {
          inherit inputs unstable;
        };
      };
    };

    # reusable home-manager config for standalone use
    mkHomeStandaloneConfig = {
      module,
      system ? "x86_64-linux",
    }: let
      stable = import nixpkgs-stable {inherit system;};
      unstable = import nixpkgs-unstable {inherit system;};
    in
      home-manager.lib.homeManagerConfiguration {
        pkgs = unstable; # match home-manager by default

        modules = [
          module
        ];
        extraSpecialArgs = {
          # make available explicit nixpkgs channels
          inherit inputs stable unstable;
        };
      };
  in {
    # home-manager configurations
    homeConfigurations = {
      "beforan@cloud" = mkHomeStandaloneConfig {
        module = ./nixfiles/cloud/home.nix;
      };
      # home-manager.lib.homeManagerConfiguration {
      #   system = "x86_64-linux";
      #   pkgs = nixpkgs-stable.legacyPackages.${system};
      #   unstable = nixpkgs-unstable.legacyPackages.${system}; # TODO: better way? possibly not due to system
      #   modules = [
      #     ./nixfiles/cloud/home.nix
      #   ];
      #   extraSpecialArgs = {
      #     inherit inputs;
      #     inherit unstable;
      #   };
      # };
      "beforan@auron" = mkHomeStandaloneConfig {
        module = ./nixfiles/auron/home.nix;
      };

      # home-manager.lib.homeManagerConfiguration {
      #   system = "x86_64-linux";
      #   pkgs = nixpkgs.legacyPackages.${system};
      #   unstable = nixpkgs-unstable.legacyPackages.${system}; # TODO: better way? possibly not due to system
      #   modules = [
      #     ./nixfiles/auron/home.nix
      #   ];
      #   extraSpecialArgs = {
      #     inherit inputs;
      #     inherit unstable;
      #   };
      # };
    };

    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Shadow
    darwinConfigurations."Shadow" = let
      system = "aarch64-darwin";
    in
      nix-darwin.lib.darwinSystem {
        inherit system;
        modules = [
          mac-app-util.darwinModules.default
          home-manager.darwinModules.default
          (mkHomeModuleConfig {
            inherit system;
            username = "beforan";
            module = ./nixfiles/Shadow/home.nix;
          })
          ./nixfiles/Shadow/configuration.nix
        ];
        specialArgs = {
          inherit inputs; # TODO: how to get unstable here?
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
    # But may be out of date with other changes to the flake over time
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
