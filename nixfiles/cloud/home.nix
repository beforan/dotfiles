{pkgs, ...}: {
  imports = [
    ../shared/home/linux.standalone.nix
  ];

  home.homeDirectory = "/home/beforan";
}
