#!/bin/zsh

## setup config directories
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-~/.config}
export ZDOTDIR=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}
export ZIM_HOME=${ZDOTDIR}/zim

# Make user-installed commands available before interactive configuration loads.
export PATH="$HOME/.local/bin:$PATH"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
