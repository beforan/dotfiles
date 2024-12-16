# This module is for macOS only, any arch
#
{pkgs, ...}: {
  imports = [
    ./home.nix
  ];

  home.packages = with pkgs; [
    iina
  ];
}
