if [ -f /group/jpsi-007/local/setup.sh ]; then
  source /etc/profile.d/modules.sh
  module use /group/c-csv/local/etc/modulefiles
  module use /group/jpsi-007/local/modulefiles
  module use $HOME/vcs2019/local/etc/modulefiles
  module load zsh/latest
  module load tmux/latest
  module load python3/latest
  module load vim/latest
  module load git/latest
  module load ruby/2.5.3
  module load cmake/latest
  module load gcc/latest
  module load clang-format
  module load parallel
fi

export DOTFILES=$HOME/sjjooste/.dotfiles
export TMUX_CMD="tmux -L sly"
