{ userHome, hostname, pkgs, brewPrefix, ... }: {
  programs.home-manager.enable = true;
  programs.ripgrep.enable = true;
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  # git config lives in ~/.dotfiles (git package), including the gh
  # credential helper.
  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
    gitCredentialHelper.enable = false;
  };
  programs.gpg.enable = true;
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    includes = [ "config.d/*" ];
  };
  programs.zsh = import ./zsh.nix { inherit hostname brewPrefix userHome; };
  programs.bash = {
    enable = true;
    initExtra = ''
      [ -f "$HOME/.config/env_exports" ] && source "$HOME/.config/env_exports"
      [ -s "${brewPrefix}/opt/nvm/nvm.sh" ] && \. "${brewPrefix}/opt/nvm/nvm.sh"
      [ -s "${brewPrefix}/opt/nvm/etc/bash_completion.d/nvm" ] && \. "${brewPrefix}/opt/nvm/etc/bash_completion.d/nvm"
    '';
  };
}
