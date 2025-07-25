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
if [ ${MACHINE} = "linux" ]; then
  case "${HOSTNAME}" in
    *agave* | *eic0* | *phy.anl*)
      MACHINE=phy
      ;;
    *lcrc* | *bebop*)
      MACHINE=lcrc
      ;;
    *alcf* | *theta*)
      MACHINE=alcf
      ;;
    *cdaq*)
      MACHINE=cdaq
      export DOTFILES=${DOTFILES_CDAQ}
      ;;
    *jlab*)
      MACHINE=jlab
      ;;
  esac
fi

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


echo "Executing main command: bash $SOURCE_DIR/scripts/${COMMAND}.sh ${@:2}"
env MACHINE=${MACHINE} DOTFILES=${DOTFILES} SOURCE_DIR=${SOURCE_DIR} \
  bash $SOURCE_DIR/scripts/${COMMAND}.sh ${@:2} || bash deploy.sh ${COMMAND} cleanup

echo "All done!"
