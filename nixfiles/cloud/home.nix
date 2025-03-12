{pkgs, ...}: {
  imports = [
    ../shared/home/linux.standalone.nix
  ];

  # ONLY update on complete host reinstall
  # https://github.com/nix-community/home-manager/issues/5794
  home.stateVersion = "24.11";

  home.homeDirectory = "/home/beforan";
}
