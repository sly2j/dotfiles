if [[ $i == "cleanup" ]]; then
  rm -rf $DOTFILES/.zshrc
  rm -rf $DOTFILES/.zsh-custom
  rm -rf $DOTFILES/.oh-my-zsh
  exit 0
fi

if [ -f $DOTFILES/.zshrc -o -f $DOTFILES/.zsh-custom -o -f $DOTFILES/.oh-my-zsh ]; then
  echo "ERROR: zsh already configured on this system"
  echo "       Please run cleanup first"
  exit 1
fi

echo ln -s $SOURCE_DIR/zsh/zshrc-${MACHINE} $DOTFILES/.zshrc
ln -s $SOURCE_DIR/zsh/zshrc-${MACHINE} $DOTFILES/.zshrc

echo ln -s $SOURCE_DIR/zsh/zsh-custom-${MACHINE} $DOTFILES/.zsh-custom
ln -s $SOURCE_DIR/zsh/zsh-custom-${MACHINE} $DOTFILES/.zsh-custom

echo ln -s $SOURCE_DIR/tmux $DOTFILES/.tmux
ln -s $SOURCE_DIR/tmux $DOTFILES/.tmux

echo ln -s $SOURCE_DIR/zsh/oh-my-zsh $DOTFILES/.oh-my-zsh
ln -s $SOURCE_DIR/zsh/oh-my-zsh $DOTFILES/.oh-my-zsh
