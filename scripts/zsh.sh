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
if [ -d $SOURCE_DIR/zsh/oh-my-zsh/custom/themes/powerline9k ]; then
  echo "powerline9k theme already installed"
else
  echo "Grabbing powerline9k theme"
  git clone https://github.com/bhilburn/powerlevel9k.git $SOURCE_DIR/zsh/oh-my-zsh/custom/themes/powerlevel9k
fi
if [ -d $SOURCE_DIR/zsh/oh-my-zsh/custom/themes/powerline9k ]; then
  echo "powerline10k theme already installed"
else
  echo "Grabbing powerline10k theme"
  git clone https://github.com/romkatv/powerlevel10k.git $SOURCE_DIR/zsh/oh-my-zsh/custom/themes/powerlevel10k
fi
if [ -d $SOURCE_DIR/zsh/oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
  echo "zsh-autosuggestions already installed"
else
  echo "grabbing zsh-autosuggestions"
  git clone https://github.com/zsh-users/zsh-autosuggestions.git $SOURCE_DIR/zsh/oh-my-zsh/plugins/zsh-autosuggestions
fi
if [ -d $SOURCE_DIR/zsh/oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
  echo "zsh-syntax-highlighting already installed"
else
  echo "grabbing zsh-syntax-highlighting"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $SOURCE_DIR/zsh/oh-my-zsh/plugins/zsh-syntax-highlighting
fi
