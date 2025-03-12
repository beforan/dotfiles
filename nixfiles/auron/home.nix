{pkgs, ...}: {
  imports = [
    ../shared/home/linux.standalone.nix
    ../shared/home/dev/linux.nix
    ../shared/home/dev/k8s/home.nix
  ];

  # ONLY update on complete host reinstall
  # https://github.com/nix-community/home-manager/issues/5794
  home.stateVersion = "24.11";

  home.homeDirectory = "/home/beforan";

  home.packages = with pkgs; [
    # if we return to being a NixOS host, these packages may be preferable at a system level (`./configuration.nix`) instead
  ];
}
