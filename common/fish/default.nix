{ ... }: 
{
  enable = true;
  shellAliases = import ./aliases.nix;
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
    set -gx PATH /opt/homebrew/bin $PATH
  '';
}
