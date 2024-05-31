{
  config,
  pkgs,
  ...
}: {
  nixpkgs = {
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "beforan";
  home.homeDirectory = "/home/beforan";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # base system stuff

    # viable stuff currently layered in rpm-ostree:
    # python? # in many distros it would be there by default like bash - not sure about nixos. we can add per-project versions via nix or venv too

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (nerdfonts.override {fonts = ["FantasqueSansMono" "CascadiaCode"];})

    cheat

    # "global" dev environment stuff
    # tools
    alejandra
    dotnet-sdk_8
    nodejs_20

    # apps
    vscode # TODO use programs.vscode? not sure if needed
    gitkraken # TODO may not need if lazygit is awesome
    jetbrains.rider
    # jetbrains.datagrip

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs.git = {
    enable = true;
    includes = [{path = "~/src/.dotfiles/.gitconfig";}];
  };

  programs.lazygit.enable = true;
  programs.btop.enable = true;

  programs.zsh = {
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
    initExtra = builtins.readFile ./.zshrc;
  };

  programs.starship = {
    enable = true;
    settings = pkgs.lib.importTOML ./starship.toml;
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

  programs.bun.enable = true;

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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
