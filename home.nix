{ config, pkgs, inputs, ... }:

{
  imports = [
    ./nix/atuin.nix
    ./nix/git.nix
    ./nix/nvim.nix
    ./nix/zoxide.nix
    ./nix/zsh.nix
    ./nix/yabai.nix
  ];

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  home = {
    username = if pkgs.stdenv.isDarwin then "jachymputta" else "jachym";
    #homeDirectory = "/Users/jachymputta";
    stateVersion = "24.05";
    sessionVariables = { 
      EDITOR = "nvim";
      SHELL = "${pkgs.zsh}/bin/zsh";
    };
    packages = with pkgs; [
      # Base
      
      ripgrep
      tmate
      zsh
      yazi
      atuin

      # C
      # clang
      gcc
      automake
      autoconf
      gnumake
      cmake

      # Rust
      rust-analyzer
      rustc
      cargo

      # Typst
      typst-lsp

      # Python
      (python3.withPackages (python-pkgs: [
        python-pkgs.pandas
        python-pkgs.numpy
        python-pkgs.pillow
      ]))

      # Web
      nodejs
    ] ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
      perf-tools
      ghostty
    ] ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
      yabai
    ];
  };

  xdg.configFile."ghostty/config".source = ./extras/ghostty/config;
}
