# ------------------------------------------------------------------------------
# Default ls colors
# ------------------------------------------------------------------------------
unset LS_COLORS

# ------------------------------------------------------------------------------
# FUNCTIONS
# ------------------------------------------------------------------------------
# File search functions
function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }

# Create a folder and move into it in one command
function mkcd() { mkdir -p "$@" && cd "$_"; }

# ------------------------------------------------------------------------------
# ENVIRONMENT MODULES --> in .zshrc directly so oh-my-zsh can find tmux
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# ALIASES
# ------------------------------------------------------------------------------
alias root='root -l'
alias ltmux="tmux -u list-sessions"
alias atmux="tmux -u attach-session -t"
## these need system python, not fancy python
function rootls() {
  OLDPATH=PATH
  export PATH="/usr/bin:$PATH"
  `root-config --bindir`/rootls $@
  export PATH=$OLDPATH
}
function rootbrowse() {
  OLDPATH=PATH
  export PATH="/usr/bin:$PATH"
  `root-config --bindir`/rootbrowse $@
  export PATH=$OLDPATH
}
function pyroot() {
  /usr/bin/python
}

function lcrc_info() {
  echo -n "==================================================================="
  echo "====================="
  echo " COMPUTATION BALANCE"
  echo -n "==================================================================="
  echo "====================="
  /lcrc/soft/lcrc/bebop/bin/lcrc-sbank -q balance
  echo ""
  echo -n "==================================================================="
  echo "====================="
  echo " STORAGE QUOTA"
  echo -n "==================================================================="
  echo "====================="
  /lcrc/soft/lcrc/bebop/bin/lcrc-quota
  echo ""
  echo -n "==================================================================="
  echo "====================="
  echo " ACTIVE JOBS"
  echo -n "==================================================================="
  echo "====================="
  squeue -u $USER
}
  

#alias cppcompile='g++ -std=c++17 -stdlib=libc++'
#alias g='git'
# ------------------------------------------------------------------------------
# Fix display environment for tmux (preexec: runs before every command)
# WARNING: this will print loads of junk if not using X forwarding
#  --> Disabled for LCRC as we should not be forwarding X
# ------------------------------------------------------------------------------
#if [ -n "$TMUX" ]; then
#  function refresh {
#    export $(tmux -L sly show-environment | grep "^DISPLAY")
#  }
#else
#  function refresh { }
#fi
#function preexec {
#  refresh
#}

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red,bold
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=green
ZSH_HIGHLIGHT_STYLES[alias]=none
ZSH_HIGHLIGHT_STYLES[builtin]=none
ZSH_HIGHLIGHT_STYLES[function]=none
ZSH_HIGHLIGHT_STYLES[command]=none
ZSH_HIGHLIGHT_STYLES[precommand]=none
ZSH_HIGHLIGHT_STYLES[commandseparator]=none
ZSH_HIGHLIGHT_STYLES[hashed-command]=none
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[globbing]=none
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=cyan
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=cyan
ZSH_HIGHLIGHT_STYLES[assign]=none
