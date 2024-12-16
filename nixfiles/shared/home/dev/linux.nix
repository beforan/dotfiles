# This module is for Linux only "global" (but via home manager) dev environment stuff
#
{pkgs, ...}: {
  imports = [
    ./home.nix
  ];

  home.packages = with pkgs; [
    ## Tools / SDKs

    ## Apps

    jetbrains-toolbox # nix for this, but it then installs jb stuff "locally" in home
  ];
}
