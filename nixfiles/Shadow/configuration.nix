{ pkgs, ... }: {
  imports = [
    ../shared/configuration.nix
  ];

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.beforan = {
    description = "Jon";
    home = "/Users/beforan";
    shell = pkgs.zsh;
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs;
    [
      sl
    ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # TODO exclude from home-manager then? may need to modularise zsh to use both ways

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;


  # defaults. not sure what a comprehensive list of these is...
  # or how the defaults correspond to what I've set in the gui over the years...
  system.defaults = {
      dock.autohide = true;
      dock.mru-spaces = false;
  };

  security.pam.enableSudoTouchIdAuth = true;

  # support rosetta
  # still requires manual installation tho:
  # `softwareudpate --install-rosetta --agree-to-license`
  nix.extraOptions = ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

}
