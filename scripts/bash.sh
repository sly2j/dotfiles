if [[ $1 == "cleanup" ]]; then
  rm -rf $DOTFILES/.bashrc
  rm -rf $DOTFILES/.bash_aliases
  exit 0
fi

if [ -f $DOTFILES/.bashrc -o -f $DOTFILES/.bash_aliases ]; then
  echo "ERROR: bash already configured on this system"
  echo "       Please run cleanup first"
  exit 1
fi

echo ln -s $SOURCE_DIR/bash/bashrc-${MACHINE} $DOTFILES/.bashrc
ln -s $SOURCE_DIR/bash/bashrc-${MACHINE} $DOTFILES/.bashrc

echo ln -s $SOURCE_DIR/bash/bash_aliases-${MACHINE} $DOTFILES/.bash_aliases
ln -s $SOURCE_DIR/bash/bash_aliases-${MACHINE} $DOTFILES/.bash_aliases
