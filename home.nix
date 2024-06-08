{ config, pkgs, inputs, ... }:

{
  programs.home-manager.enable = true;

  home.sessionVariables = { 
  	EDITOR = "nvim";
	SHELL = "${pkgs.zsh}/bin/zsh";
	};
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    ripgrep
    tmate
    zsh
  ];
  
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
      theme = "robbyrussell";
    };
  };

  programs.atuin.enableZshIntegration = true;
  programs.atuin.enable = true;

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  programs.git = {
    enable = true;
    userName = "Jachym Putta";
    userEmail = "jachym.putta@gmail.com";
  };
}
