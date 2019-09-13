if [ -f /group/jpsi-007/local/setup.sh ]; then
  source /group/jpsi-007/local/setup.sh
  source /group/jpsi-007/local/pro.sh
fi

export DOTFILES=$HOME/sjjooste/.dotfiles
export TMUX_CMD="tmux -L sly"
