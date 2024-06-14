{ pkgs, home-manager, ... }:
{ 
  services.nix-daemon.enable = true;
  nix = {
    package = pkgs.nix;
    settings = {
      "extra-experimental-features" = [ "nix-command" "flakes" ];
    };
  };

  users.users.jachymputta.home = "/Users/jachymputta";
  users.users.jachymputta.shell = pkgs.zsh;
  
  services.skhd = {
    enable = true;
    skhdConfig = builtins.readFile ../extras/skhd/skhdrc;
  };
}
