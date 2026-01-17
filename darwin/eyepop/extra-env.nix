{ brewPrefix }:
''
  export LDFLAGS="-L${brewPrefix}/lib -L${brewPrefix}/opt/libpq/lib"
  export CPPFLAGS="-I${brewPrefix}/include"
  export PKG_CONFIG_PATH="${brewPrefix}/lib/pkgconfig:${brewPrefix}/Library/Homebrew/os/mac/pkgconfig:$PKG_CONFIG_PATH"
  export KUBECTL_EXTERNAL_DIFF="colordiff -N -u"
  export PATH="${brewPrefix}/opt/rustup/bin:$PATH"
  [ -s "${brewPrefix}/opt/nvm/nvm.sh" ] && \. "${brewPrefix}/opt/nvm/nvm.sh"
  [ -s "${brewPrefix}/opt/nvm/etc/bash_completion.d/nvm" ] && \. "${brewPrefix}/opt/nvm/etc/bash_completion.d/nvm"
''
