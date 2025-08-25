{
  ...
}:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };

  xdg.configFile."starship.toml".source = ../extras/starship/starship.toml;
}
