{ pkgs, ... }: {
  imports = [
    ../shared/home.nix
  ];

  home.homeDirectory = "/home/beforan";
}
