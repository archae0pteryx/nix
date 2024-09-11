{
  enable = true;
  shellAliases = {
    rebuild = "home-manager switch --flake $HOME/.config/nix/x86_64-linux";
    opensource = "cd $HOME/Code/opensource";
    eyepop = "cd $HOME/Code/eyepop";
    codespace = "code $HOME/Code/eyepop/eyepop.code-workspace";
    k = "kubectl";
    kc = "kubectl config";
    kns = "kubens";
    kx = "kubectx";
    tf = "tofu";
    tfa = "tofu apply";
    tfd = "tofu destroy";
    tfp = "tofu plan";
    tfda = "tofu destroy -auto-approve";
    tfaa = "tofu apply -auto-approve";
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
    nixconfig = "code $HOME/.config/nix";
    alacrittyconfig = "code $HOME/.config/alacritty";
    c = "cd $HOME/Code";
    ga = "git add";
    gc = "git commit -S -m";
    gp = "git push";
    gco = "git checkout";
    nixupdate =
      "sudo -i nix-channel --update && sudo -i nixos-rebuild switch && home-manager switch --flake $HOME/.config/home-manager";
    nixclean =
      "sudo -i nix-collect-garbage -d && sudo -i nix-store --optimise";
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
    function bencode
        if test (count $argv) -eq 0
            echo "Usage: bencode <string>"
            return 1
        end
        echo -n $argv | tr -d '\n' | base64 | xsel -bi
    end
    function ggg
      git add . && sleep 1 && git commit -S -am "$argv" && git push
    end
    set -gx PATH $HOME/.local/bin $PATH
    set -gx GOBIN $HOME/.local/bin
    set -gx GOPATH $HOME/Code/go

    set -gx PATH $HOME/.cargo/bin $PATH
  '';
}
