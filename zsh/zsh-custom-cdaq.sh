# ------------------------------------------------------------------------------
# PATH
# ------------------------------------------------------------------------------
export PATH=$HOME/.local/bin:$PATH
export PYTHONPATH=$HOME/.local/lib:$PYTHONPATH
export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH
export MANPATH=$HOME/.local/man:$HOME/.local/share/man:$MANPATH

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
source /etc/profile.d/modules.sh

if [ -f /group/jpsi-007/local/setup.sh ]; then
  source /group/jpsi-007/local/setup.sh
  source /group/jpsi-007/local/pro.sh
fi

## The root module will also load the correct version of python etc
#module load root

# ------------------------------------------------------------------------------
# ALIASES
# ------------------------------------------------------------------------------
alias root='root -b'
#alias cppcompile='g++ -std=c++17 -stdlib=libc++'
#alias g='git'

export VIM_RUNTIME=$DOTFILES/.vim
alias vim="vim -u $DOTFILES/.vimrc"

alias tmux="TERM=screen-256color tmux -L sly -f $DOTFILES/.tmux.conf"
alias ltmux="TERM=screen-256color tmux -L sly -f $DOTFILES/.tmux.conf list-sessions"
alias atmux="TERM=screen-256color tmux -L sly -f $DOTFILES/.tmux.conf attach-session -t"
alias wget='wget --no-check-certificate'
alias wgetdir='wget -r -l1 --no-parent '

alias cp='/bin/cp -i'
alias mv='/bin/mv -i'
alias rm='/bin/rm -i'

alias sgit='git -c core.editor=vim -c user.name="Sylvester Joosten" -c user.email="sjoosten@anl.gov"'
alias pip_search='pip search --trusted-host pypi.org --trusted-host files.pythonhosted.org'
alias pip_install='pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org'

## Need to redo this as we already loaded some stuff through bash
