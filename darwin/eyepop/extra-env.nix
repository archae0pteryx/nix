''
  export LDFLAGS="-L/opt/homebrew/lib"
  export CPPFLAGS="-I/opt/homebrew/include"
  export PKG_CONFIG_PATH="/opt/homebrew/lib/pkgconfig:/opt/homebrew/Library/Homebrew/os/mac/pkgconfig:$PKG_CONFIG_PATH"
  export KUBECTL_EXTERNAL_DIFF="colordiff -N -u"
''