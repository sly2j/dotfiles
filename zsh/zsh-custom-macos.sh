
# ------------------------------------------------------------------------------
# PATH
# ------------------------------------------------------------------------------
  # Add commonly used folders to $PATH
# don't execute PATH modifications for tmux 
# (this will screw up module command)
if [[ -z $TMUX ]]; then
  export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
  export PATH=/Applications/MacVim.app/Contents/bin:$PATH
fi # TMUX GUARD

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
# Add commonly used folders to $PATH
#
# In case of tmux, this screws up the manpath, so lets save try to defend against that
MANPATH_SAVE=$MANPATH
source /usr/local/opt/modules/init/zsh


module use $HOME/Environment/modulefiles

## fix manpath for tmux
if [[ $TMUX ]]; then
  export MANPATH=$MANPATH_SAVE
  unset MANPATH_SAVE
fi #TMUX guard

## The root module will also load the correct version of python etc
module load root

# ------------------------------------------------------------------------------
# ALIASES
# ------------------------------------------------------------------------------
alias root='root -l'
alias cppcompile='c++ -std=c++17 -stdlib=libc++'
alias g='git'


# ----------------------------------------------------------------------------
#    ssh tunnels 
#-----------------------------------------------------------------------------
function check_tunnel() {
  nc -z localhost $1 || echo "Tunnel dead."
}
function jlab_tunnel() {
  if [ -z "$1" -o -z "$2" ]; then
    echo 'No host or port given'
    echo 'Usage: jlab_tunnel [USER@]HOST PORT'
  else
    TLHOST=$1
    TLPORT=$2
    echo "Establishing JLab tunnel to $1 (port: $2)"
    ssh -t -L ${TLPORT}:localhost:1${TLPORT} sjjooste@login.jlab.org ssh -L 1${TLPORT}:localhost:${TLPORT} ${TLHOST}
  fi
}
## tunnel behind jlab firewall
function hallgw_tunnel() {
  if [ -z "$1" -o -z "$2" ]; then
    echo 'No host or port given'
    echo 'Usage: hallgw_tunnel [USER@]HOST PORT'
  else
    TLHOST=$1
    TLPORT=$2
    echo "Establishing JLab Hall GW tunnel to $1 (port: $2)"
    echo "Please use your JLab 2-factor authorization"
    ssh -t -L ${TLPORT}:localhost:1${TLPORT} sjjooste@hallgw.jlab.org ssh -L 1${TLPORT}:localhost:${TLPORT} ${TLHOST}
  fi
}
function hallgw_login() {
  if [ -z "$1" ]; then
    echo 'No host given'
    echo 'Usage: hallgw_login [USER@]HOST'
  else
    TLHOST=$1
    echo "Establishing JLab Hall GW passthrough to to $1"
    echo "Please use your JLab 2-factor authorization"
    ssh -t sjjooste@hallgw.jlab.org ssh ${TLHOST}
  fi
}
function simonadaq_vnc_tunnel() {
  if [ -z "$1" ] ; then
    echo 'No port offset given, defaulting to :1 (5901)'
    export PORT=5901
  else
    echo "VNC port offset :$1 ($((5900 + $1)))"
    export PORT=$((5900 + $1))
  fi
  hallgw_tunnel "cdaq@simonadaq" $PORT 
}
function simonadaq_login() {
  hallgw_login "cdaq@simonadaq" 
}
function ifarm1401_login() {
  hallgw_login "sjjooste@ifarm1401" 
}
function cdaql1_vnc_tunnel() {
  if [ -z "$1" ] ; then
    echo 'No port offset given, defaulting to :1 (5901)'
    export PORT=5901
  else
    echo "VNC port offset :$1 ($((5900 + $1)))"
    export PORT=$((5900 + $1))
  fi
  hallgw_tunnel "cdaq@cdaql1" $PORT 
}
function cdaql1_login() {
  hallgw_login "cdaq@cdaql1" 
}
function cdaql2_vnc_tunnel() {
  if [ -z "$1" ] ; then
    echo 'No port offset given, defaulting to :1 (5901)'
    export PORT=5901
  else
    echo "VNC port offset :$1 ($((5900 + $1)))"
    export PORT=$((5900 + $1))
  fi
  hallgw_tunnel "cdaq@cdaql2" $PORT 
}
function cdaql2_login() {
  hallgw_login "cdaq@cdaql2" 
}

