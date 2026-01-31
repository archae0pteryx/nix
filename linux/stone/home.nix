{ pkgs, ... }:
let username = "nix";
in {
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.11";

  home.packages = import ./packages.nix { inherit pkgs; };
  programs = import ./programs.nix { inherit pkgs; };

  # XFCE settings via xfconf
  xfconf.settings = import ./xfce.nix;

  # Dotfiles
  home.file = { ".vimrc".source = ../../common/vimrc; };

  home.sessionVariables = {
    EDITOR = "nvim";
    GOPATH = "$HOME/Code/go";
    GOBIN = "$HOME/Code/go/bin";
    CARGO_HOME = "$HOME/.cargo";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/Code/go/bin"
    "$HOME/.cargo/bin"
    "$HOME/.bun/bin"
  ];
}
