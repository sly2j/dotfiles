# ------------------------------------------------------------------------------
# PATH
# ------------------------------------------------------------------------------
# Add commonly used folders to $PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# ------------------------------------------------------------------------------
# FUNCTIONS
# ------------------------------------------------------------------------------
# File search functions
function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }

# Create a folder and move into it in one command
function mkcd() { mkdir -p "$@" && cd "$_"; }

# ------------------------------------------------------------------------------
# ENVIRONMENT MODULES
# ------------------------------------------------------------------------------
source /usr/local/opt/modules/init/zsh
module use $HOME/Environment/modulefiles

## The root module will also load the correct version of python etc
module load root

# ------------------------------------------------------------------------------
# ALIASES
# ------------------------------------------------------------------------------
alias root='root -l'
alias cppcompile='g++ -std=c++17 -stdlib=libc++'
alias g='git'
