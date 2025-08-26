{
  rebuild = "darwin-rebuild switch --flake $HOME/.config/nix/darwin#eyepop";
  kapply = "devbox run kapply";
  kdiff = "devbox run kdiff";
  hammerconfig = "cursor $HOME/.hammerspoon";
  stenstaging = "stern --context staging";
  sternprod = "stern --context production";
  sterncompute = "stern --context staging -n compute-api-staging compute-api -c compute-api";
  sternoperator = "stern --context staging -n eyepop-compute-operator-system compute-operator -c manager";
  sterninstance = "stern --context staging -n eyepop-sessions session -c session --exclude agent";
  sternwebapi = "stern --context staging -n web-api web-api -c web-api";
  sterndataset = "stern --context staging -n dataset-api dataset-api -c dataset-api";
}
