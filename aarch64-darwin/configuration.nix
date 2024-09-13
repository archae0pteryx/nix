{ config, pkgs, ... }:

{
  nix.package = pkgs.nix;

  environment.systemPackages = with pkgs; [ vim tmux ];
  environment.shells = [ pkgs.fish pkgs.bash ];

  # nixpkgs.hostPlatform = "aarch64-apple-darwin";
  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.permittedInsecurePackages = [
  #   "electron-27.3.11"
  # ];
  services.nix-daemon.enable = true;

  programs.zsh.enable = false;
  programs.fish.enable = true;
  programs.bash.enable = true;

  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps -p $PPID -o command | tail -n +2) != "fish" && -z $BASH_EXECUTION_STRING ]]
      then
        shopt -q login_shell && LOGIN_OPTION="--login" || LOGIN_OPTION=""
        exec fish $LOGIN_OPTION
      fi
    '';
  };
  system.stateVersion = 4;

  users.users.ryan = {
    name = "ryan";
    home = "/Users/ryan";
    shell = pkgs.bash;
  };
  homebrew = import ../common/homebrew.nix;
}
