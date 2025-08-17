{
  pkgs,
  ...
}:

{
  imports = [
    ./nix/atuin.nix
    ./nix/carapace.nix
    ./nix/direnv.nix
    ./nix/git.nix
    ./nix/nushell.nix
    ./nix/nvim.nix
    ./nix/tmux.nix
    ./nix/yazi.nix
    ./nix/zoxide.nix
    ./nix/zsh.nix
  ];

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";

  home = {
    username = "jachym";
    # homeDirectory = "/home/jachym";
    stateVersion = "25.05";
    sessionVariables = {
      EDITOR = "nvim";
      SHELL = "${pkgs.nushell}/bin/nu";
    };
    packages =
      with pkgs;
      [
        # Base
        tmate
        tmux
        wget

        # Shell
        zsh
        nushell
        ripgrep
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
