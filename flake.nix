{
  description = "Home Manager configuration of beforan";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  }: let
    withSystem = system:
      home-manager.lib.homeManagerConfiguration {
        # Specify your home configuration modules here, for example,
        # the path to your home.nix.

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix

        pkgs = nixpkgs.legacyPackages.${system};
        modules = [./home.nix];
      };
  in {
    # TODO what about differing modules between configurations?
    # maybe revert withSystem back to separate configs /shrug
    homeConfigurations = {
      "beforan@cloud" = withSystem "x86_64-linux";
      "beforan@Shadow" = withSystem "aarch64-darwin";
    };
  };
}
