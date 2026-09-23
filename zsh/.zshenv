#!/bin/zsh

## setup config directories
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-~/.config}
export ZDOTDIR=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}
export ZIM_HOME=${ZDOTDIR}/zim

# Let Zim's completion module initialize compinit instead of the global zshrc.
export skip_global_compinit=1

# Make user-installed commands available before interactive configuration loads.
export PATH="$HOME/.local/bin:$PATH"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
