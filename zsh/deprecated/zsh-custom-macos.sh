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
#MANPATH_SAVE=$MANPATH
source /usr/local/opt/modules/init/zsh
module use $HOME/.local/etc/modulefiles

## fix manpath for tmux
#if [[ $TMUX ]]; then
#  export MANPATH=$MANPATH_SAVE
#  unset MANPATH_SAVE
#fi #TMUX guard

## Spack init
## Using spack instead of modules
if [[ -z $TMUX ]]; then
  export SPACK_ROOT="/Users/sjoosten/.local/opt/spack"
  source $SPACK_ROOT/share/spack/setup-env.sh
  spack env activate work
fi
## fix man-path to also include system location: trailing colon
export MANPATH=$MANPATH:

## The root module will also load the correct version of python etc
# ROOT done through oncda
# module load root/6.18.00_2

# ----------------------------------------------------------------------------
#    ssh tunnels 
#-----------------------------------------------------------------------------
function check_tunnel() {
  nc -z localhost $1 || echo "Tunnel dead."
}

## workon function
function workon() {
  if [ -z "$1" ]; then
    'Error: no project name givem'
    exit 1
  elif [ "$1" = "jpsi" ]; then
    ## ensure tmux alive
    tmux new-session -d -s dummy
    ## attach to tmux, populate if needed
    python ~/.dotfiles/tmux/spawntmux-macos.py jpsi
  else
    echo "Error: unknown project name: $1"
    exit 1
  fi
}

alias eic-shell="docker-compose -f ~/.docker-compose.yml run --rm eic eic-shell"
alias yr-shell="docker-compose -f ~/.docker-compose.yml run --rm yr eic-shell"
alias lager-shell="docker-compose -f ~/.docker-compose.yml run --rm lager bash"
alias hcana-shell="docker-compose -f ~/.docker-compose.yml run --rm hcana bash"
alias less="less -R"


alias spack_dev="docker-compose -f ~/.docker-compose.yml run --rm spack bash"


# Python path
export PATH=/Users/sjoosten/Library/Python/3.7/bin:$PATH


## Fancy highlighting:
# use highlight with less
export LESSOPEN="| /usr/local/bin/highlight %s --out-format xterm256 --force"
[[ -s "/usr/local/etc/grc.zsh" ]] && source /usr/local/etc/grc.zsh

