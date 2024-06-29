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

  home.stateVersion = "24.05";

  home.username = "beforan"; # For now, at least, this is always the same

  # TODO modularise this lot
  home.packages = with pkgs; [
    # nixGLIntel # TODO move nixGL only to machines that need it
    # nixVulkanIntel

    # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (nerdfonts.override {fonts = ["FantasqueSansMono" "CascadiaCode"];})

    # "global" dev environment stuff
    # tools
    alejandra
    dotnetCorePackages.sdk_8_0
    nodejs_20

    python312 # ensure a system version of python is available; mainly for pipx. Projects should use venvs and/or nix
    pipx

    azure-cli

    # apps
    vscode # TODO use programs.vscode? not sure if needed
    gitkraken # TODO may not need if lazygit is awesome
    # jetbrains.rider
    # jetbrains.datagrip

    # TODO flatpak godot probably
    # (config.lib.nixGL.wrap godot_4) # TODO keep looking out for Mono just in case ;)

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
    # TODO do we do this at system level on non-standalone installs?
    enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
    };
    shellAliases = {
      dotfiles = "code ~/src/.dotfiles";
    };
    dirHashes = {
      s = "$HOME/src";
    };
  };

  programs.starship = {
    enable = true;
    settings = pkgs.lib.importTOML ../../dotfiles/starship.toml;
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

  # dev tooling

  # git
  programs.git = {
    enable = true;
    delta.enable = true;
    includes = [{path = "~/src/.dotfiles/dotfiles/.gitconfig";}];
  };
  programs.lazygit.enable = true;

  programs.bun.enable = true;

  programs.poetry = {
    enable = true;
    settings = {
      virtualenvs.create = true;
      virtualenvs.in-project = true;
    };
    # TODO: poethepoet?
  };

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
  };

  # Environment Variables
  home.sessionVariables = {
    # EDITOR = "nano";
    VISUAL = "code";
  };

  programs.home-manager.enable = true;
}
