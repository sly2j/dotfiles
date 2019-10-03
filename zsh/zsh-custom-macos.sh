## Extra fix for macos autocompletion
ZSH_DISABLE_COMPFIX=true
# ------------------------------------------------------------------------------
# PATH
# ------------------------------------------------------------------------------
  # Add commonly used folders to $PATH
# don't execute PATH modifications for tmux 
# (this will screw up module command)
if [[ -z $TMUX ]]; then
  export PATH="/usr/local/opt/llvm/bin:/Applications/MacVim.app/Contents/bin:$PATH:/usr/local/texlive/2019/bin/x86_64-darwin/"
fi # TMUX GUARD

# ------------------------------------------------------------------------------
# ENVIRONMENT MODULES
# ------------------------------------------------------------------------------
# Add commonly used folders to $PATH
#
# In case of tmux, this screws up the manpath, so lets save try to defend against that
MANPATH_SAVE=$MANPATH
source /usr/local/opt/modules/init/zsh

module use $HOME/.dotfiles/modulefiles/CSI357144

## fix manpath for tmux
if [[ $TMUX ]]; then
  export MANPATH=$MANPATH_SAVE
  unset MANPATH_SAVE
fi #TMUX guard

## The root module will also load the correct version of python etc
module load root/6.18.00_2

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

function b010_login() {
  if [ -z "$1" ]; then
    echo 'No host given'
    echo 'Usage: b010_login [USER@]HOST'
  else
    TLHOST=$1
    echo "Establishing b010 login GW passthrough to to $1"
    ssh -J sjoosten@login.phy.anl.gov -t -X sjoosten@lab-lan1.phy.anl.gov ssh -X ${TLHOST}
  fi
}
function b010_tunnel() {
  if [ -z "$1" -o -z "$2" ]; then
    echo 'No host or port given'
    echo 'Usage: b010_tunnel [USER@]HOST PORT'
  else
    TLHOST=$1
    TLPORT=$2
    echo "Establishing b010 tunnel through ANL PHY to $1 (port: $2)"
    ssh -J sjoosten@login.phy.anl.gov -t -L ${TLPORT}:localhost:1${TLPORT} sjoosten@lab-lan1.phy.anl.gov ssh -L 1${TLPORT}:localhost:${TLPORT} ${TLHOST}
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

function sodium_login() {
  b010_login "10.10.241.20"
}
function sodium_vnc_tunnel() {
  if [ -z "$1" ] ; then
    echo 'No port offset given, defaulting to :1 (5901)'
    export PORT=5901
  else
    echo "VNC port offset :$1 ($((5900 + $1)))"
    export PORT=$((5900 + $1))
  fi
  if [ -z "$2" ]; then
    echo "No user given, defaulting to $USER"
    export USR=$USER
  else
    echo "User: $2"
    export USR=$2
  fi
  b010_tunnel "$USR@10.10.241.20" $PORT
}

## workon function
function workon() {
  if [ -z "$1" ]; then
    'Error: no project name givem'
    exit 1
  elif [ "$1" = "jpsi" ]; then
    cd $HOME/work/Jpsi-007
    module purge
    module load env/jpsi-007/pro
  else
    echo "Error: unknown project name: $1"
    exit 1
  fi
}
