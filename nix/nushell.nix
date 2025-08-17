{
  ...
}:
{
  programs.nushell = {
    enable = true;

    shellAliases = {
      # ls = "eza";
      # ll = "eza -l";
      # cat = "bat";
      tree = "eza -T";
      cd = "z";
      grep = "rg";
      htop = "btop";
      switch = "sudo nixos-rebuild switch --flake .#jachym -L";
      update = "home-manager switch --flake ~/dotfiles/#jachym-x86 -L ";
      updatearm = "home-manager switch --flake ~/dotfiles/#jachym-aarm -L ";
      darwin = "sudo nix run nix-darwin -- switch --flake ~/dotfiles ";
    };

    configFile.source = ../extras/nushell/config.nu;
    extraConfig = builtins.readFile ../extras/nushell/git.nu;
  };
}
