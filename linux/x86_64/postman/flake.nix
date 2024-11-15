{
  description = "Custom Postman package using the latest GitHub release";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in
    {
      packages.x86_64-linux.postman = pkgs.stdenv.mkDerivation rec {
        pname = "postman";
        version = "latest";

        src = pkgs.fetchurl {
          url = "https://dl.pstmn.io/download/latest/linux64";
          sha256 = "be6658b52ca0022108e441c5af8bafcec25d53258fc07d066a397775f51a78a0"; 
        };

        unpackPhase = "true"; # or remove if the archive doesn't need to be unpacked

        installPhase = ''
          mkdir -p $out/bin
          cp -r * $out/
        '';

        meta = with pkgs.lib; {
          description = "The latest version of Postman";
          homepage = "https://www.postman.com/";
          license = licenses.mit;
          platforms = platforms.linux;
        };
      };
    };
}
