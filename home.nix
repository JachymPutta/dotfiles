{ config, pkgs, inputs, ... }:

{
  imports = [
    ./nix/atuin.nix
    ./nix/git.nix
    ./nix/nvim.nix
    ./nix/zoxide.nix
    ./nix/zsh.nix
    ./nix/yazi.nix
    ./nix/direnv.nix
    ./nix/tmux.nix
  ];

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "jachym";
    # homeDirectory = "/home/jachym";
    stateVersion = "24.11";
    sessionVariables = { 
      EDITOR = "nvim";
      SHELL = "${pkgs.zsh}/bin/zsh";
    };
    packages = with pkgs; [
      # Base
      tmate
      tmux
      htop
      wget

      # Shell
      ripgrep
      zsh
      atuin
      zoxide
      eza
      bat
      entr
      btop
      tldr
      dust
      carapace

      # File management
      yazi
      fzf
      pandoc
      zathura

      # C
      automake
      autoconf
      gnumake
      cmake
      clang-tools
      boost
      libiconv
      ccache

      # Rust -- keep project specific versions
      # rust-analyzer
      # rustc
      # cargo
      # just

      # Typst
      # typst-lsp
      # typst

      # Python
      (python3.withPackages (python-pkgs: [
        python-pkgs.pandas
        python-pkgs.numpy
      ]))
      ruff-lsp
      pyright

      # Lua
      lua-language-server

      # Node is needed for copilot etc
      nodejs
    ] ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
      perf-tools
      ghostty
      # gcc
    ] ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
      # clang
      yabai
      skhd
    ];
  };

  xdg.configFile."ghostty/config".source = ./extras/ghostty/config;
}
