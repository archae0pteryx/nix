{ pkgs, ... }: {
  programs.nvm = {
    enable = true;
    package = pkgs.nvm;
  };
}