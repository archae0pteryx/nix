{
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
  nixconfig = "code $HOME/.config/home-manager";
  alacrittyconfig = "code $HOME/.config/alacritty";
  c = "cd $HOME/Code";
  ga = "git add";
  gc = "git commit -S -m";
  gp = "git push";
  gco = "git checkout";

  activatefish = "source .venv/bin/activate.fish";
}
