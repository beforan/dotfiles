# This is the BASE Home Manager configuration for ALL Hosts.
#
# It is imported by more specific system configurations e.g. `./darwin.nix`
# Use the most specific system configuration modules you can in your Host configuration
#
{
  config,
  pkgs,
  inputs,
  ...
}: let
  # nixGLIntel = inputs.nixGL.packages."${pkgs.system}".nixGLIntel;
  # nixVulkanIntel = inputs.nixGL.packages."${pkgs.system}".nixVulkanIntel;
in {
  # imports = [
  #  (builtins.fetchurl {
  #    url = "https://raw.githubusercontent.com/Smona/home-manager/nixgl-compat/modules/misc/nixgl.nix";
  #    sha256 = "74f9fb98f22581eaca2e3c518a0a3d6198249fb1490ab4a08f33ec47827e85db";
  #  })
  # ];

  nixpkgs.config = {
    # Disable if you don't want unfree packages
    allowUnfree = true;
    # Workaround for https://github.com/nix-community/home-manager/issues/2942
    allowUnfreePredicate = _: true;
  };

  home.username = "beforan"; # For now, at least, this is always the same

  home.packages = with pkgs; [
    # bitwarden-desktop # TODO: not on macos

    # nixGLIntel # TODO move nixGL only to machines that need it
    # nixVulkanIntel

    # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (nerdfonts.override {fonts = ["FantasqueSansMono" "CascadiaCode"];})

    ## Core dev packages
    alejandra # assume systems using nix might need to edit nix

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # nixGL.prefix = "${nixGLIntel}/bin/nixGLIntel ${nixVulkanIntel}/bin/nixVulkanIntel";

  # terminal /shell stuff
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    plugins = [
      {
        name = "zsh-nvm";
        src = pkgs.fetchFromGitHub {
          owner = "lukechilds";
          repo = "zsh-nvm";
          rev = "745291dcf20686ec421935f1c3f8f3a2918dd106";
          sha256 = "sha256-4O1a5bsNoqwB0hB8YU1fEVafsPQK8l7jr3GlF68ckZg=";
        };
      }
    ];
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
    };
    shellAliases = {
      dotfiles = "code ~/src/.dotfiles";
      conda-activate = "source ~/opt/conda/bin/activate";
    };
    dirHashes = {
      s = "$HOME/src";
    };
    # TODO: should we always add snaps? what if snapd is not installed?
    initExtra = ''
      export PATH=/home/beforan/opt/appimage:$PATH
      export PATH=$PATH:/snap/bin
    '';
  };

  programs.starship = {
    enable = true;
    settings = pkgs.lib.importTOML ../../../dotfiles/starship.toml;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = true;
    git = true;
  };

  programs.bat.enable = true;

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
  };

  # other utilities
  programs.btop.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = builtins.fromTOML "hide_env_diff = true";
  };

  # core dev tooling

  # programs.vscode.enable = true; # TODO: should it be here? it's currently in `/home/dev`

  # git
  programs.git = {
    enable = true;
    delta.enable = true;
    includes = [{path = "~/src/.dotfiles/dotfiles/.gitconfig";}]; # TODO: make this less hardcoded to the target checkout path?
  };
  programs.lazygit.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    # TODO: either setup a dotfile or use a vim programs entry
    ".vimrc".text = ''
      syntax on
    '';
  };

  # Environment Variables
  home.sessionVariables = {
    EDITOR = "nano";
    VISUAL = "code";
  };

  programs.home-manager.enable = true;
}
