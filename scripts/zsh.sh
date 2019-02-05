if [[ $1 == "cleanup" ]]; then
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
ln -s $SOURCE_DIR/zsh/zsh-custom-${MACHINE}.sh $DOTFILES/.zsh-custom

echo ln -s $SOURCE_DIR/zsh/oh-my-zsh $DOTFILES/.oh-my-zsh
ln -s $SOURCE_DIR/zsh/oh-my-zsh $DOTFILES/.oh-my-zsh

if [ ${MACHINE} = "cdaq" ]; then
  echo ln -s $SOURCE_DIR/zsh/launch-zsh-cdaq.sh $DOTFILES/.launch-zsh.sh
  ln -s $SOURCE_DIR/zsh/launch-zsh-cdaq.sh $DOTFILES/.launch-zsh.sh
fi

#checkout powerline9k theme
if [ -f $SOURCE_DIR/zsh/oh-my-zsh/custom/themes/powerline9k ]; then
  echo "powerline9k theme already installed"
else
  echo "Grabbing powerline9k theme"
  git clone https://github.com/bhilburn/powerlevel9k.git $SOURCE_DIR/zsh/oh-my-zsh/custom/themes/powerlevel9k
fi
