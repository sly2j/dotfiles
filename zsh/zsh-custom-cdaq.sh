# ------------------------------------------------------------------------------
# PATH
# ------------------------------------------------------------------------------
export PATH=$HOME/.local/bin:$PATH:$HOME/whit/bin
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
alias root='root -l'
#alias cppcompile='g++ -std=c++17 -stdlib=libc++'
#alias g='git'

alias vim="vim -u $DOTFILES/.vimrc"

alias tmux="tmux -u -L sly -f $DOTFILES/.tmux.conf"
alias ltmux="tmux -u -L sly list-sessions"
alias atmux="tmux -u -L sly attach-session -t"
alias wget='wget --no-check-certificate'
alias wgetdir='wget -r -l1 --no-parent '

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

alias go_online="cd $HOME/hallc-online/hallc_replay"
alias go_jpsi="cd $HOME/jpsi-007/online_jpsi/replay_jpsi"

alias cp='/bin/cp -i'
alias mv='/bin/mv -i'
alias rm='/bin/rm -i'

alias sgit='git -c core.editor=vim -c user.name="Sylvester Joosten" -c user.email="sjoosten@anl.gov"'
alias pip_search='pip search --trusted-host pypi.org --trusted-host files.pythonhosted.org'
alias pip_install='pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org'

## Need to redo this as we already loaded some stuff through bash
alias mux_sly='tmux -L sly attach-session -t jpsi'
alias mux_whit='tmux -L whit attach-session -t 0'
alias mux_default='tmux -L default attach-session -t http_web_display'
alias mux_runinfod="tmux -u -L replay attach-session -t runinfod"

# ------------------------------------------------------------------------------
# Fix display environment for tmux (preexec: runs before every command)
# ------------------------------------------------------------------------------
# if we are not in screen/tmux: update display cache
# if we are in screen/tmux: update the value of DISPLAY from the cache
#function update-x11-forwarding() {
#  if [ -z "$STY" -a -z "$TMUX" ]; then
#    echo $DISPLAY > $DOTFILES/.display.txt
#  else
#    export DISPLAY=`cat $DOTFILES/.display.txt`
#  fi
#}
#update-x11-forwarding
if [ -n "$TMUX" ]; then
  function refresh {
#    export $(tmux -L sly show-environment | grep "^SSH_AUTH_SOCK")
    export $(tmux -L sly show-environment | grep "^DISPLAY")
  }
else
  function refresh { }
fi
function preexec {
  refresh
}
