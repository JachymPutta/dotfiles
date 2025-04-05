{ pkgs, home-manager, ... }:
{ 
  nix = {
    enable = false; # NOTE: nix is managed with the det-sys installation
    package = pkgs.nix;
    settings = {
      "extra-experimental-features" = [ "nix-command" "flakes" ];
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
    };
    keyboard = { 
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };

  services = {
    aerospace = {
      enable = true;
      package = pkgs.aerospace;
      settings = pkgs.lib.importTOML ../extras/aerospace/aerospace.toml;
    };
    # Tailscale installs the CLI version, the GUI is installed via App Store
    # tailscale = {
    #   enable = true;
    #   package = pkgs.tailscale;
    # };
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };

    taps = [
      "railwaycat/emacsmacport"
    ];

    casks = [
      "arc"
      "steam"
      "discord"
      "signal"
      "visual-studio-code"
      "slack"
      "zoom"
      "wacom-tablet"
      "ghostty"
      "emacs-mac"
    ];
  };
}
