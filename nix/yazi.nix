{
  ...
}:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };

  xdg.configFile."yazi/yazi.toml".source = ../extras/yazi/yazi.toml;
}
