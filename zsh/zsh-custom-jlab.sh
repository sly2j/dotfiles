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
alias root='root -b'
alias ltmux="tmux -u list-sessions"
alias atmux="tmux -u attach-session -t"
#alias cppcompile='g++ -std=c++17 -stdlib=libc++'
#alias g='git'
function rootls() {
  module load python
  `root-config --bindir`/rootls $@
  module unload python
}
function rootbrowse() {
  module load python
  `root-config --bindir`/rootbrowse $@
  module unload python
}

# ------------------------------------------------------------------------------
# Fix display environment for tmux (preexec: runs before every command)
# ------------------------------------------------------------------------------
#if [ -n "$TMUX" ]; then
#  function refresh {
#    export $(tmux -L sly show-environment | grep "^DISPLAY")
# }
#lse
# function refresh { }
#i
#unction preexec {
# refresh
#
