## Use system Kerberos on MacOS
alias kinit=/usr/bin/kinit
alias kpasswd=/usr/bin/kpasswd
alias klist=/usr/bin/klist
alias kdestroy=/usr/bin/kdestroy
alias kutil=/usr/bin/kutil

git config --global credential.helper osxkeychain

export PATH=/opt/homebrew/bin:$PATH
