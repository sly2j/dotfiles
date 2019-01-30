if [[ $i == "cleanup" ]]; then
  rm -rf $DOTFILES/.tmux.conf
  $DOTFILES/.tmux
  exit 0
fi

if [ -f $DOTFILES/.tmux.conf -o -f $DOTFILES/.tmux ]; then
  echo "ERROR: tmux already configured on this system"
  echo "       Please run cleanup first"
  exit 1
fi

echo ln -s $SOURCE_DIR/tmux/tmux-${MACHINE}.conf $DOTFILES/.tmux.conf
ln -s $SOURCE_DIR/tmux/tmux-${MACHINE}.conf $DOTFILES/.tmux.conf

echo ln -s $SOURCE_DIR/tmux $DOTFILES/.tmux
ln -s $SOURCE_DIR/tmux $DOTFILES/.tmux
