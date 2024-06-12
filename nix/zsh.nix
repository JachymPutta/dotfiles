{ config, pkgs, inputs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      # update = "sudo nixos-rebuild switch --flake .#jachym -L";
      # update = "sudo nix build .#nixosConfigurations.jachym.config.system.build.toplevel && sudo ./result/activate";
      update = "home-manager switch --flake .#jachym -L";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };
}
