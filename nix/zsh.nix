{
  config,
  ...
}:

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
      cd = "z";
      grep = "rg";
      htop = "btop";
      switch = "sudo nixos-rebuild switch --flake .#jachym -L";
      update = "home-manager switch --flake ~/dotfiles/#jachym-x86 -L ";
      updatearm = "home-manager switch --flake ~/dotfiles/#jachym-aarm -L ";
      darwin = "sudo nix run nix-darwin -- switch --flake ~/dotfiles ";
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
        { name = "jeffreytse/zsh-vi-mode"; }
      ];
    };

    initContent = ''
      ${builtins.readFile ../extras/zsh/zshrc}
      ${builtins.readFile ../extras/zsh/zsh_git}
    '';
  };
}
