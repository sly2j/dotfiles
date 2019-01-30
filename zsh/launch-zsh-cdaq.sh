#!/bin/bash

# Add commonly used folders to $PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# CDAQ: also use extra bin directories
export PATH="$HOME/bin:$PATH"

source /group/jpsi-007/local/setup.sh
module load zsh
ZDOTDIR=$HOME/sjjooste/.dotfiles zsh
