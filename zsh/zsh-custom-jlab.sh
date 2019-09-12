if [ -f /group/jpsi-007/local/setup.sh ]; then
  source /group/jpsi-007/local/setup.sh
fi
module load zsh
module load vim
module load tmux

if [[ $HOSTNAME == "hallgw"* ]]; then
  ZSH_THEME="bira"
fi
