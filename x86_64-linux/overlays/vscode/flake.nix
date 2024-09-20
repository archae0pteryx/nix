{
  description = "Custom VSCode build";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }:
    let
      vscode-latest = nixpkgs.lib.mkDerivation {
        pname = "vscode";
        version = "1.93.1";
        src = nixpkgs.fetchurl {
          url = "https://update.code.visualstudio.com/1.93.1/linux-x64/stable";
          sha256 = "4a8598a8016630229f26f243b653bc14b0cc28795038f55ea224543f149fe510";
        };
        installPhase = ''
          mkdir -p $out/bin
          tar -xzf $src --strip-components=1 -C $out
          ln -s $out/code $out/bin/code
        '';
      };
    in
    {
      packages.x86_64-linux.vscode = vscode-latest;
    };
}
