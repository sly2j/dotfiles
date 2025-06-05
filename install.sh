#!/bin/bash
set -euo pipefail

# Set dotfiles path
export DOTFILES="${HOME}/.dotfiles2"
export CONFDIR="${XDG_CONFIG_HOME:-$HOME/.config}"


CHECKMARK="\033[0;32m✓\033[0m"

#######################################
# Neovim configuration
#######################################
export NVIM_DIR="${CONFDIR}/nvim"
echo "Linking Neovim config from ${DOTFILES}/nvim to ${NVIM_DIR}"

# Ensure config directory exists
mkdir -p "${NVIM_DIR}"

# Link Neovim config files
ln -sf "${DOTFILES}/nvim/init.lua" "${NVIM_DIR}/init.lua"
echo -e "  ${CHECKMARK} Linked init.lua"
ln -sf "${DOTFILES}/nvim/lua" "${NVIM_DIR}/lua"
echo -e "  ${CHECKMARK} Linked lua/ directory"

echo "Done linking Neovim config."

#######################################
# tmux configuration
#######################################
export TMUX_DIR="${CONFDIR}/tmux"
echo "Linking tmux config from ${DOTFILES}/tmux to ${TMUX_DIR}"
mkdir -p "$TMUX_DIR"
ln -sf "${DOTFILES}/tmux/tmux.conf" "${TMUX_DIR}/tmux.conf"
echo -e "  ${CHECKMARK} Linked tmux.conf"

#######################################
# Ensure TPM is installed and plugins are initialized
#######################################
TPM_PATH="${TMUX_DIR}/plugins/tpm"
if [ ! -d "${TPM_PATH}" ]; then
  echo "TPM not found. Cloning into ${TPM_PATH}..."
  git clone https://github.com/tmux-plugins/tpm "${TPM_PATH}"
  echo -e "  ${CHECKMARK} TPM installed"

  # Initial plugin install
  "${TPM_PATH}/bin/install_plugins"
  echo -e "  ${CHECKMARK} Plugins installed"
else
  echo "TPM already installed at ${TPM_PATH}"

  # Optional: update plugins if TPM is already present
  "${TPM_PATH}/bin/update_plugins" all
  echo -e "  ${CHECKMARK} Plugins updated"
fi

echo "Done linking tmux config."
