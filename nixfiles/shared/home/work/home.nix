# This is the BASE module system-level Work Stuff
#
# It may be imported by more specific system configurations e.g. `./linux.nix`
# Use the most specific system configuration modules you can in your Host configuration
#
{pkgs, ...}: {
  home.packages = with pkgs; [
    slack
  ];
}
