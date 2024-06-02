{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # TODO consider darwin shared config, or better shared home manager module config
    inputs.mac-app-util.homeManagerModules.default
    ../shared/home.nix
  ];

  home.homeDirectory = "/Users/beforan";
}
