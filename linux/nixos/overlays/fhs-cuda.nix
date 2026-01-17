{ pkgs ? import <nixpkgs> {} }:
(pkgs.buildFHSUserEnv {
  name = "cuda-env";
  targetPkgs = pkgs: [
    pkgs.git
    pkgs.gitRepo
    pkgs.gnupg
    pkgs.autoconf
    pkgs.curl
    pkgs.procps
    pkgs.gnumake
    pkgs.util-linux
    pkgs.m4
    pkgs.gperf
    pkgs.unzip
    pkgs.cudatoolkit
    pkgs.linuxPackages.nvidia_x11
    pkgs.libGLU
    pkgs.libGL
    pkgs.xorg.libXi
    pkgs.xorg.libXmu
    pkgs.freeglut
    pkgs.xorg.libXext
    pkgs.xorg.libX11
    pkgs.xorg.libXv
    pkgs.xorg.libXrandr
    pkgs.zlib
    pkgs.ncurses5
    pkgs.stdenv.cc
    pkgs.binutils
  ];
  multiPkgs = pkgs: [ pkgs.zlib ];
  runScript = "bash";
  profile = ''
    export CUDA_PATH=${pkgs.cudatoolkit}
    # export LD_LIBRARY_PATH=${pkgs.linuxPackages.nvidia_x11}/lib
    export EXTRA_LDFLAGS="-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib"
    export EXTRA_CCFLAGS="-I/usr/include"
  '';
}).env