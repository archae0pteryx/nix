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
    matchBlocks = {
      "stone" = {
        hostname = "10.0.3.50";
        user = "nix";
        extraOptions = {
          BindAddress = "10.0.1.30";
        };
      };
    };
  };
  programs.zsh = import ./zsh.nix { inherit hostname brewPrefix; };
}
