{pkgs, ...}: {
  imports = [
    ../shared/home.nix
  ];

  home.homeDirectory = "/home/beforan";

  # stuff here to stay out of macos/ublue's way
  # may want modularising differently later if there are more nixos targets
  # or may want to amend other targets to favour shared home manager /shrug

  home.packages = with pkgs; [
    bitwarden-desktop
  ];
}
