{
  enable = true;
  shellAliases = {
    rebuild = "home-manager switch --flake $HOME/.config/home-manager";
    opensource = "cd $HOME/Code/opensource";
    eyepop = "cd $HOME/Code/eyepop";
    k = "kubectl";
    kc = "kubectl config";
    kns = "kubens";
    kx = "kubectx";
    tf = "opentofu";
    tfa = "opentofu apply";
    tfd = "opentofu destroy";
    tfaa = "opentofu apply --auto-approve";
    tg = "terragrunt";
    tga = "terragrunt apply";
    tgp = "terragrunt plan";
    tgd = "terragrunt destroy";
    tgaa = "terragrunt apply --auto-approve";
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    dc = "docker compose";
    dcb = "docker compose build";
    dcd = "docker compose down";
    nixconfig = "code $HOME/.config/home-manager";
    alacrittyconfig = "code $HOME/.config/alacritty";
    c = "cd $HOME/Code";
    ga = "git add";
    gc = "git commit -S -m";
    gp = "git push";
    gco = "git checkout";
    nixupdate =
      "sudo -i nix-channel --update && sudo -i nixos-rebuild switch && home-manager switch --flake ~/.config/home-manager";
    nixclean =
      "sudo -i nix-collect-garbage -di && sudo -i nix-store --optimise";
    starshipconfig = "code $HOME/.config/starship.toml";
    activatefish = "source .venv/bin/activate.fish";
  };
  shellInit = ''
    if status --is-interactive
        if not set -q TMUX
            tmux new-session
        end
        starship init fish | source
    end
    function delete_crds
      set search_string $argv[1]
      kubectl get crds -o name | grep $search_string | awk -F / '{ print $2 }' | xargs kubectl delete crd
    end
    set -gx PATH /home/rimraf/.local/bin $PATH
  '';
}
