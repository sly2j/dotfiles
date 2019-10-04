source /etc/profile.d/modules.sh
module use "$HOME/.dotfiles/modulefiles/phy"
module load zsh
module load tmux
module load vim

## extra setup for EIC0
export GOPATH="/opt/software/local/stow/go_1.13.1"
if [[ -d ${GOPATH} ]]; then
  export PATH="${GOPATH}/bin:${PATH}"
else 
  unset GOPATH
fi

export SINGULARITY_PATH="/opt/software/local/stow/singularity_3.4.1"
if [[ -d ${SINGULARITY_PATH} ]]; then
  export PATH="${SINGULARITY_PATH}/bin:${PATH}"
else
  unset SINGULARITY_PATH
fi
