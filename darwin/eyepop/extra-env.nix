{ brewPrefix, userHome }:
''
  export LDFLAGS="-L${brewPrefix}/lib -L${brewPrefix}/opt/libpq/lib"
  export CPPFLAGS="-I${brewPrefix}/include"
  export PKG_CONFIG_PATH="${brewPrefix}/lib/pkgconfig:${brewPrefix}/Library/Homebrew/os/mac/pkgconfig:$PKG_CONFIG_PATH"
  export KUBECTL_EXTERNAL_DIFF="colordiff -N -u"
  export PATH="${brewPrefix}/opt/rustup/bin:$PATH"
  export EYEPOP_ROOT="${userHome}/Code/eyepop"
''
