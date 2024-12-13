{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # TODO consider darwin shared config, or better shared home manager module config
    inputs.mac-app-util.homeManagerModules.default
    ../shared/home.nix
    ../shared/home.dev.nix
  ];

  home.packages = with pkgs; [
    slack # TODO: work shared module?

    # TODO: macos specific shared stuff?
    iina
  ];

  home.homeDirectory = "/Users/beforan";
}
