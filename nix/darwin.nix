{ pkgs, home-manager, ... }:
{ 
  services.nix-daemon.enable = true;
  users.users.jachymputta.home = "/Users/jachymputta";
  users.users.jachymputta.shell = pkgs.zsh;
  
  services.skhd = {
    enable = true;
    skhdConfig = builtins.readFile ../extras/skhd/skhdrc;
  };
}
