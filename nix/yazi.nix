{
  config,
  pkgs,
  inputs,
  ...
}:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  xdg.configFile."yazi/yazi.toml".source = ../extras/yazi/yazi.toml;
}
