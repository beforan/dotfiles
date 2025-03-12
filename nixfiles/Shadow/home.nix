{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.mac-app-util.homeManagerModules.default
    ../shared/home/darwin.nix
    ../shared/home/dev/home.nix
    ../shared/home/dev/k8s/home.nix
    ../shared/home/work/home.nix
  ];

  # ONLY update on complete host reinstall
  # https://github.com/nix-community/home-manager/issues/5794
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    # Host specific packages
  ];

  home.homeDirectory = "/Users/beforan";
}
