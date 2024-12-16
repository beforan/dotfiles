{pkgs, ...}: {
  imports = [
    ../shared/home/linux.standalone.nix
    ../shared/home/dev/linux.nix
    ../shared/home/dev/k8s/home.nix
  ];

  home.homeDirectory = "/home/beforan";

  home.packages = with pkgs; [
    # if we return to being a NixOS host, these packages may be preferable at a system level (`./configuration.nix`) instead
  ];
}
