{ config, pkgs, inputs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "eza";
      ll = "eza -l";
      tree = "eza -T";
      cat = "bat";
      grep = "rg";
      htop = "btop";
      switch = "sudo nixos-rebuild switch --flake .#jachym -L";
      update = "cd ~/dotfiles && home-manager switch --flake .#jachym -L && cd -";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "agkozak/agkozak-zsh-prompt"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "hlissner/zsh-autopair"; }
      ];
    };

    initExtra = ''
      ${builtins.readFile ../extras/zsh/zshrc}
      ${builtins.readFile ../extras/zsh/zsh_git}
    '';
  };
}
