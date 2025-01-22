{ pkgs, home-manager, ... }:
{ 
  services.nix-daemon.enable = true;
  nix = {
    package = pkgs.nix;
    settings = {
      "extra-experimental-features" = [ "nix-command" "flakes" ];
    };
  };

  users.users.jachym.home = "/Users/jachym";
  users.users.jachym.shell = pkgs.zsh;
  
  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    extraConfig = builtins.readFile ../extras/yabai/yabairc;
  };

  services.skhd = {
    enable = true;
    package = pkgs.skhd;
    skhdConfig = builtins.readFile ../extras/skhd/skhdrc;
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
