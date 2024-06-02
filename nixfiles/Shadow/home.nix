{ pkgs, ... }: {
  imports = [
    ../shared/home.nix
  ];

  home.homeDirectory = "/Users/beforan";
}
