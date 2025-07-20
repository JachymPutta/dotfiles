{
  config,
  pkgs,
  inputs,
  ...
}:

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
    username = "jachym";
    # homeDirectory = "/home/jachym";
    stateVersion = "25.05";
    sessionVariables = {
      EDITOR = "nvim";
      SHELL = "${pkgs.zsh}/bin/zsh";
    };
    packages =
      with pkgs;
      [
        # Base
        tmate
        tmux
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
        fd
        xh
        presenterm

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

        # Rust
        rust-analyzer
        clippy
        rustfmt

        # Python
        (python3.withPackages (python-pkgs: [
          python-pkgs.pandas
          python-pkgs.numpy
        ]))
        ruff
        pyright

        # Lua
        lua-language-server

        # Nix
        nil
        nixfmt-rfc-style

        # Node is needed for copilot etc
        nodejs
        jemalloc

        # Zig
        zls
      ]
      ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
        # Linux specific packages
        perf-tools
      ]
      ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
        # Mac specific packages
      ];
  };

  # Extra configs
  xdg.configFile."ghostty/config".source = ./extras/ghostty/config;
  xdg.configFile."zathura/zathurarc".source = ./extras/zathura/zathurarc;

  home.file.".dailies.toml".source = ./extras/dailies/dailies.toml;
  home.file.".aerospace.toml".source = ./extras/aerospace/aerospace.toml;
}
