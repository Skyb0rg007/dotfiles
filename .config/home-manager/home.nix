{ config, pkgs, ... }:

let
  exercismDir = "${config.home.homeDirectory}/Courses/exercism";
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ssoss";
  home.homeDirectory = "/home/ssoss";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  imports = [
    ./modules/tcl.nix
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.alejandra
    pkgs.bat
    pkgs.exercism
    pkgs.jq
    pkgs.pipes
    pkgs.sops
    pkgs.rlwrap
    pkgs.vim-full # XXX: nixvim / config via outOfStore nix setup

    # Ansible
    (pkgs.ansible.override { windowsSupport = true; })
    pkgs.ansible-lint
    pkgs.python312Packages.argcomplete

    # Standard ML compilers
    pkgs.mlkit
    pkgs.mlton
    pkgs.mosml
    pkgs.polyml
    pkgs.smlnj
    # smltojs

    pkgs.gh
    pkgs.gh-copilot

    # Languages
    pkgs.chez
    pkgs.cmake
    pkgs.gforth
    pkgs.jimtcl
    pkgs.koka
    pkgs.lua54Packages.lua
    pkgs.lua54Packages.luacheck
    pkgs.marst # ALGOL60 to C
    pkgs.mercury
    pkgs.rakudo # zef(?)
    pkgs.souffle
    pkgs.swiProlog
    # XXX: GNU Smalltalk
    # XXX: NodeJS (nvm)
    # XXX: Golang
    # XXX: Coq, Lean (elan)
    # XXX: Haskell (cabal + stack)
    # XXX: OCaml (opam)
    # XXX: Rust
    # XXX: Clojure (Leiningen)

    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

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
    # ".secret".source = config.sops.secrets."example-key".path;
  };

  home.sessionVariables = {
    NIX_SHELL_PRESERVE_PROMPT = "1"; 
    GFORTHHIST = "${config.xdg.stateHome}/gforth/history";
    RAKUDO_HIST = "${config.xdg.stateHome}/rakudo-history";
    # XXX: move to programs.bash.historyFile
    HISTFILE = "${config.xdg.stateHome}/bash/history";
    RLWRAP_HOME = "${config.xdg.stateHome}/rlwrap";
    # XXX: vim executable from package
    # MANPAGER = "vim -M +MANPAGER -";
    # TODO: host-based config
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    fastfetch.enable = true;

    fzf.enable = true;

    git = {
      enable = true;
      userName = "ssoss";
      userEmail = "skyler.soss@gmail.com";
    };

    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    # nixvim = {
    #   enable = true;
    # };

    nnn = {
      enable = true;
      bookmarks = {
        p = "${config.home.homeDirectory}/Projects";
        c = "${config.home.homeDirectory}/Courses/Compilers";
        r = "${config.home.homeDirectory}/Research";
        m = "${config.home.homeDirectory}/Research/masters";
        e = "${exercismDir}";
      };
    };

    texlive = {
      enable = true;
    };

    # XXX: tmux vim integration
    tmux = {
      enable = true;
      baseIndex = 1;
      extraConfig = ''
      '';
      keyMode = "vi";
      mouse = true;
      plugins = [
        {
          plugin = pkgs.tmuxPlugins.resurrect;
          extraConfig = ''
            set -g @resurrect-strategy-vim 'session'
          '';
        }
      ];
      shortcut = "Space";
      escapeTime = 0;
    };
  };

  sops = {
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    secrets = {
      # XXX: Get this to work via template / some other method
      "exercism/token" = {}; 
      # "github-copilot/copilot-vim/token" = {};
    };
  };
}
