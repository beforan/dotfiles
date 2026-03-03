# This module is for Linux only "global" (but via home manager) dev environment stuff
#
{pkgs, ...}: {
  imports = [
    ./home.nix
  ];

  home.packages = with pkgs; [
    ## Tools / SDKs

    ## Apps

    # jetbrains-toolbox # just download locally; essentially appimage - it then installs jb tools "locally" in user home
  ];
}
