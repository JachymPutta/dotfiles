{
  pkgs,
  ...
}:
{
  programs.tmux = {
    enable = true;
    historyLimit = 1000000;
    baseIndex = 1;
    prefix = "C-a";
    extraConfig = builtins.readFile ../extras/tmux/tmux.conf;
    plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode
      catppuccin
      sensible
      vim-tmux-navigator
      yank
    ];
  };
}
