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
  source /etc/profile.d/modules.sh
  module use /group/c-csv/local/etc/modulefiles
  module use /group/jpsi-007/local/modulefiles
  module use $HOME/vcs2019/local/etc/modulefiles
  module load tmux/latest
  module load python3/latest
  module load vim/latest
  module load git/latest
  module load ruby/2.5.3
  module load cmake/latest
  module load gcc/latest
  module load clang-format
  module load parallel
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

## go to online browser
alias go_monitor= '~/bin/Linux/firefox --new-window "cdaql1.jlab.org:8888" &'

# ------------------------------------------------------------------------------
# Fix display environment for tmux (preexec: runs before every command)
# ------------------------------------------------------------------------------
if [ -n "$TMUX" ]; then
  function refresh {
    export $(tmux -L sly show-environment | grep "^DISPLAY")
  }
else
  function refresh { }
fi
function preexec {
  refresh
}

## zsh highlighting
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
#!/bin/bash

