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

## The root module will also load the correct version of python etc
#module load root

# ------------------------------------------------------------------------------
# ALIASES
# ------------------------------------------------------------------------------
alias root='root -b'
#alias cppcompile='g++ -std=c++17 -stdlib=libc++'
#alias g='git'
