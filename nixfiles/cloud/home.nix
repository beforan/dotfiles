{pkgs, ...}: {
  imports = [
    ../shared/home.nix
    ../shared/home.standalone.nix
  ];

  home.homeDirectory = "/home/beforan";
}
