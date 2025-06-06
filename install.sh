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

#######################################
# Setup zsh
#######################################
ZSH_CONFDIR="${CONFDIR}/zsh"
ZIM_HOME="${ZSH_CONFDIR}/zim"
BACKUP_DIR="${ZSH_CONFDIR}/old-zsh-backup/$(date +%Y%m%d-%H%M%S)"
echo "Setting up zsh configuration in $ZSH_CONFDIR"

# Create config directory
mkdir -p "$ZSH_CONFDIR"

for item in $HOME/.zshrc $HOME/.zimrc $HOME/.zim $HOME/.zshenv .zprofile $ZIM_HOME; do
    if [ -e $item ]; then
        echo "📦 Found existing $item. Backing up to $BACKUP_DIR"
        mkdir -p "$BACKUP_DIR"
        mv "$item" "$BACKUP_DIR/"
    fi
done

# Link dotfiles
for file in $DOTFILES/zsh/{.zshenv,.zimrc,.zshrc} $DOTFILES/zsh/*.zsh; do
  base=$(basename "$file")
  ln -sf "$file" "$ZSH_CONFDIR/$base"
  echo -e "  ${CHECKMARK} Linked $base"
done

# Install zimfw to $ZIM_HOME
if [ ! -e "$ZIM_HOME/zimfw.zsh" ]; then
  echo "⬇️  Installing zimfw to ${ZIM_HOME}..."
  mkdir -p "$ZIM_HOME"
  curl -fsSL -o "$ZIM_HOME/zimfw.zsh" \
    https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

echo -e "${CHECKMARK} Zsh setup complete."

#######################################
# Setup Zsh extras: Syntax Highlighting & Starship prompt
#######################################

echo "Installing Catppuccin zsh-syntax-highlighting theme..."
THEME_DIR="${ZSH_CONFDIR}/catppuccin-zsh-syntax-highlighting"
if [ ! -d "$THEME_DIR" ]; then
  git clone --depth=1 https://github.com/catppuccin/zsh-syntax-highlighting.git "$THEME_DIR"
  echo -e "  ${CHECKMARK} Cloned Catppuccin syntax highlighting theme"
else
  echo "  ${CHECKMARK} Theme already exists at $THEME_DIR"
fi

#######################################
# Install Starship prompt binary
#######################################
if ! command -v starship >/dev/null 2>&1; then
  echo "⬇️  Installing Starship prompt..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y
  echo -e "  ${CHECKMARK} Starship installed"
else
  echo -e "  ${CHECKMARK} Starship already installed"
fi

# Link Starship config
mkdir -p "${CONFDIR}/starship"
ln -sf "${DOTFILES}/zsh/starship.toml" "${CONFDIR}/starship/starship.toml"
echo -e "  ${CHECKMARK} Linked starship.toml"
