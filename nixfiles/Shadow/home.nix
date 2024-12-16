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

  home.packages = with pkgs; [
    # Host specific packages
  ];

  home.homeDirectory = "/Users/beforan";
}
