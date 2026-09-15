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
      export NVM_DIR="$HOME/.nvm"
      if [ -s "${brewPrefix}/opt/nvm/nvm.sh" ]; then
        # Home Manager can prepend Homebrew ahead of inherited NVM paths in
        # nested shells. nvm reuses existing NVM paths in-place, so clear stale
        # entries first and then put the default version at the front.
        \. "${brewPrefix}/opt/nvm/nvm.sh" --no-use
        nvm deactivate --silent >/dev/null 2>&1 || true
        nvm use --silent default >/dev/null 2>&1 || true
      fi
      [ -s "${brewPrefix}/opt/nvm/etc/bash_completion.d/nvm" ] && \. "${brewPrefix}/opt/nvm/etc/bash_completion.d/nvm"
    '';
  };
}
