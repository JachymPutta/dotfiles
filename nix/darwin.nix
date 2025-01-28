{ pkgs, home-manager, ... }:
{ 
  services.nix-daemon.enable = true;
  nix = {
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
    yabai = {
      enable = true;
      package = pkgs.yabai;
      extraConfig = builtins.readFile ../extras/yabai/yabairc;
    };
    skhd = {
      enable = true;
      package = pkgs.skhd;
      skhdConfig = builtins.readFile ../extras/skhd/skhdrc;
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
      "brave-browser"
      "steam"
      "discord"
      "signal"
      "visual-studio-code"
      "slack"
      "zoom"
      "wacom-tablet"
      "emacs-mac"
    ];
  };
}
