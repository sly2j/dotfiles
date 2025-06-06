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
else
  echo "TPM already installed at ${TPM_PATH}"
fi

# Only install/update plugins if running inside tmux
if [ -n "${TMUX:-}" ]; then
  echo "Running inside tmux session – installing plugins..."
  "${TPM_PATH}/bin/install_plugins"
  echo -e "  ${CHECKMARK} Plugins installed"

  "${TPM_PATH}/bin/update_plugins" all
  echo -e "  ${CHECKMARK} Plugins updated"
else
  echo "⚠️  Not in a tmux session. Skipping plugin install/update."
  echo "ℹ️  Run this manually later inside tmux: <prefix> + I"
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

# Link top-level dotfile
ln -sf "$DOTFILES/zsh/.zshenv" "$HOME/.zshenv"
echo -e "  ${CHECKMARK} Linked .zshenv"

# Link dotfiles
for file in $DOTFILES/zsh/{.zimrc,.zshrc} $DOTFILES/zsh/*.zsh; do
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
  echo -e "  ${CHECKMARK} Theme already exists at $THEME_DIR"
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

#######################################
# Optional: iTerm2 Color Theme Setup
#######################################
if [[ "$(uname)" == "Darwin" ]]; then
  echo "🖥  Detected macOS — downloading iTerm2 Catppuccin theme..."

  ITERM_THEME_DIR="$HOME/Downloads"
  MOCHA_URL="https://raw.githubusercontent.com/catppuccin/iterm/refs/heads/main/colors/catppuccin-mocha.itermcolors"
  MOCHA_FILE="${ITERM_THEME_DIR}/Catppuccin Mocha.itermcolors"

  mkdir -p "$ITERM_THEME_DIR"
  if [ ! -f "$MOCHA_FILE" ]; then
    echo "⬇️  Downloading Catppuccin Mocha iTerm2 theme..."
    curl -fsSL -o "$MOCHA_FILE" "$MOCHA_URL" && \
      echo -e "  ${CHECKMARK} Theme downloaded to $MOCHA_FILE"
  else
    echo -e "  ${CHECKMARK} iTerm2 theme already exists"
  fi

  echo -e "\n🎨 To apply the iTerm2 theme:"
  echo "  1. Open iTerm2 → Preferences → Profiles → Colors"
  echo "  2. Click 'Color Presets…' → 'Import…'"
  echo "  3. Select: $MOCHA_FILE"
  echo "  4. Then select 'Catppuccin Mocha' from the presets menu."
fi
