{ pkgs, home-manager, ... }:
{
  nix = {
    enable = false; # NOTE: nix is managed with the det-sys installation
    package = pkgs.nix;
    settings = {
      "extra-experimental-features" = [
        "nix-command"
        "flakes"
      ];
    };
  };

  users.users = {
    jachym = {
      home = "/Users/jachym";
      shell = pkgs.zsh;
    };
  };

  system = {
    defaults = {
      dock.autohide = true;
      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        ShowPathbar = true;
      };
      screencapture.target = "clipboard";
      controlcenter.BatteryShowPercentage = true;
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };

  environment.systemPackages = with pkgs; [
    coreutils
  ];

  # services = {
  # NOTE: this wasn't working for some reason -- switched to brew
  # aerospace = {
  #   enable = true;
  #   package = pkgs.aerospace;
  #   settings = pkgs.lib.importTOML ../extras/aerospace/aerospace.toml;
  # };
  # Tailscale installs the CLI version, the GUI is installed via App Store
  # tailscale = {
  #   enable = true;
  #   package = pkgs.tailscale;
  # };
  # };

  security.pam.services.sudo_local.touchIdAuth = true;

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap"; # NOTE: removes all casks not listed here
    };

    taps = [
      "nikitabobko/tap"
    ];

    casks = [
      "aerospace"
      "battle-net"
      "curseforge"
      "discord"
      "ghostty"
      "google-chrome"
      "orbstack"
      "signal"
      "slack"
      "steam"
      "visual-studio-code"
      "wacom-tablet"
      "zen"
      "zoom"
    ];
  };
}
