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

  home = {
    username = if pkgs.stdenv.isDarwin then "jachymputta" else "jachym";
    #homeDirectory = "/home/jachym";
    stateVersion = "24.05";
    sessionVariables = { 
      EDITOR = "nvim";
      SHELL = "${pkgs.zsh}/bin/zsh";
    };
    packages = with pkgs; [
      # Base
      ripgrep
      zsh
      atuin
      tmate
      tmux
      htop
      wget

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

      # Web
      nodejs
    ] ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
      perf-tools
      ghostty
      gcc
    ] ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
      clang
      yabai
      skhd
    ];
  };

  xdg.configFile."ghostty/config".source = ./extras/ghostty/config;
}
