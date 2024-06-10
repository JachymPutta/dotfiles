{ config, pkgs, inputs, ... }:

{
  imports = [
    ./nix/atuin.nix
    ./nix/git.nix
    ./nix/nvim.nix
    ./nix/zoxide.nix
    ./nix/zsh.nix
  ];

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  home = {
    username = "jachym";
    homeDirectory = "/home/jachym";
    stateVersion = "24.05";
    sessionVariables = { 
      EDITOR = "nvim";
      SHELL = "${pkgs.zsh}/bin/zsh";
    };
    packages = with pkgs; [
      # Base
      ghostty
      ripgrep
      tmate
      zsh
      yazi

      # C
      clang
      valgrind
      perf-tools
      cmake

      # Rust
      rust-analyzer
      rustc
      cargo
    ];
  };

  xdg.configFile."ghostty/config".source = ./extras/ghostty/config;
}
