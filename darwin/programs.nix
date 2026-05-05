{ userHome, hostname, pkgs, brewPrefix, ... }: {
  programs.home-manager.enable = true;
  programs.ripgrep.enable = true;
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  programs.git = import ../common/git.nix { inherit userHome; };
  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
    gitCredentialHelper.enable = true;
  };
  programs.gpg.enable = true;
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    includes = [ "config.d/*" ];
  };
  programs.zsh = import ./zsh.nix { inherit hostname brewPrefix; };
  programs.bash = {
    enable = true;
    initExtra = ''
      [ -f "$HOME/.env.shell" ] && set -a && source "$HOME/.env.shell" && set +a
    '';
  };
}
