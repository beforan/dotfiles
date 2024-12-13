# This module is explicitly for hosts which are not running nixos,
# it will install core packages via home manager that on a nixos host you would install in the system configuration instead
{pkgs, ...}: {
  home.packages = with pkgs; [
    fastfetch
  ];
}
