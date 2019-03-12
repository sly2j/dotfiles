#!/bin/bash

COMMAND=$1
export DOTFILES="$HOME"  ## default dotfiles, will be altered for know systems if needed
export DOTFILES_CDAQ="$HOME/sjjooste/.dotfiles"
export SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

## detect system
UNAME="$(uname -s)"
case "${UNAME}" in
  Linux*)  MACHINE=linux;;
  Darwin*) MACHINE=macos;;
  *)       MACHINE="UNKNOWN"
esac

if [ ${MACHINE} = "UNKNOWN" ]; then
  echo "ERROR: Unknown machine ($UNAME), cannot proceed"
  exit 1
fi

## special known systems
if [ ${MACHINE} = "linux" -a ${HOSTNAME} = "agave.phy.anl.gov"]; then
  MACHINE=phys
fi
if [ ${MACHINE} = "linux" -a ${USER} = "cdaq" ]; then
  MACHINE=cdaq
  export DOTFILES=${DOTFILES_CDAQ}
fi
if [ ${MACHINE} = "linux" -a -f /site/12gev_phys/jlab.sh ]; then
  MACHINE=jlab
fi
export MACHINE

if [ -z $2 ]; then
  echo "Deploying ${COMMAND} on machine ${MACHINE}"
else
  echo "Running ${@:2} on machine ${MACHINE} for ${COMMAND}"
fi

case "${COMMAND}" in
  zsh*)  echo "Known command: ${COMMAND}";;
  bash*)  echo "Known command: ${COMMAND}";;
  root*)  echo "Known command: ${COMMAND}";;
  vim*)  echo "Known command: ${COMMAND}";;
  tmux*)  echo "Known command: ${COMMAND}";;
  *) echo "ERROR: unknown command" && exit 1
esac

echo "Ensuring all submodules are initialized"
git submodule init
git submodule update --init --recursive

if [ -z $ZSH_CUSTOM ]; then
  export ZSH_CUSTOM=$DOTFILES/.oh-my-zsh/custom
fi
git clone https://github.com/bhilburn/powerlevel9k.git $ZSH_CUSTOM/themes/powerlevel9k
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

echo "Executing main command: bash $SOURCE_DIR/scripts/${COMMAND}.sh ${@:2}"
env MACHINE=${MACHINE} DOTFILES=${DOTFILES} SOURCE_DIR=${SOURCE_DIR} \
  bash $SOURCE_DIR/scripts/${COMMAND}.sh ${@:2}

echo "All done!"
