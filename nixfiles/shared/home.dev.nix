# This module is for "global" (but via home manager) dev environment stuff
#  - Bear in mind due to idiosyncracies, many apps (and dependent runtimes) are easier
#    installed via Flatpak or even directly where the system allows (i.e. non Atomic distros).
#  - As a result many of these are not managed by home manager currently while we work out the best way
#  - README docs should cover these cases
#
#
# WARNING: some stuff may or may not depend on nixGL and that will need sorting/testing
{pkgs, ...}: {
  home.packages = with pkgs; [
    ## Tools / SDKs

    # dotnetCorePackages.sdk_8_0

    python312 # ensure a system version of python is available; mainly for pipx. Projects should use venvs and/or nix
    pipx

    # azure-cli

    # no node - nvm is installed with zsh in `shared/home.nix`, so use that to manage user-space node versions

    ## Apps

    # vscode # TODO use programs.vscode? not sure if needed
    # gitkraken # TODO may not need if lazygit is awesome

    jetbrains-toolbox # nix for this, but it then installs jb stuff "locally" in home

    # TODO flatpak godot probably
    # (config.lib.nixGL.wrap godot_4) # TODO keep looking out for Mono just in case ;)

    # k8s
    minikube
    kubectl
  ];

  # TODO: maybe per project flake?
  programs.bun.enable = true;

  # TODO: maybe per project flake?
  programs.poetry = {
    enable = true;
    settings = {
      virtualenvs.create = true;
      virtualenvs.in-project = true;
    };
    # TODO: poethepoet?
  };
}
