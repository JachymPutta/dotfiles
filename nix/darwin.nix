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
    aerospace = {
      enable = true;
      package = pkgs.aerospace;
      settings = {
        gaps = {
          outer.left = 8;
          outer.bottom = 8;
          outer.top = 8;
          outer.right = 8;
        };
        mode.main.binding = {
          ctrl-shift-1 = "workspace 1";
          ctrl-shift-2 = "workspace 2";
          ctrl-shift-3 = "workspace 3";
          ctrl-shift-4 = "workspace 4";

          ctrl-cmd-1 = "move-node-to-workspace 1";
          ctrl-cmd-2 = "move-node-to-workspace 2";
          ctrl-cmd-3 = "move-node-to-workspace 3";
          ctrl-cmd-4 = "move-node-to-workspace 4";

          alt-h = "focus left";
          alt-j = "focus down";
          alt-k = "focus up";
          alt-l = "focus right";
        };
      };
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
      "zen-browser"
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
