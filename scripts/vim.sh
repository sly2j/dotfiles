if [[ $1 == "cleanup" ]]; then
  rm -rf $DOTFILES/.vimrc
  rm -rf $DOTFILES/.vim
  rm -rf $DOTFILES/.clang-format
  if [ -f $DOTFILES/.launch-zsh.sh ]; then
    rm -rf $DOTFILES/.launch-zsh.sh
  fi
  exit 0
fi

if [ -f $DOTFILES/.vim -o -f $DOTFILES/.vimrc -o -f $DOTFILES/.clang-format ]; then
  echo "ERROR: vim already configured on this system"
  echo "       Please run cleanup first"
  exit 1
fi

echo mkdir $DOTFILES/.vim
mkdir $DOTFILES/.vim
for i in $SOURCE_DIR/vim/*; do
  echo ln -s $i $DOTFILES/.vim/
  ln -s $i $DOTFILES/.vim/
done
echo rm $DOTFILES/.vim/bundle $DOTFILES/vimrc-*
rm $DOTFILES/.vim/bundle $DOTFILES/.vim/vimrc-*
echo mkdir $DOTFILES/.vim/bundle
mkdir $DOTFILES/.vim/bundle
for i in $SOURCE_DIR/vim/bundle/*; do
  echo ln -s $i $DOTFILES/.vim/bundle/
  ln -s $i $DOTFILES/.vim/bundle/
done
echo mkdir $DOTFILES/.vim/undodir

echo ln -s $SOURCE_DIR/vim/vimrc-${MACHINE} $DOTFILES/.vimrc
ln -s $SOURCE_DIR/vim/vimrc-${MACHINE} $DOTFILES/.vimrc

echo ln -s $SOURCE_DIR/vim/clang-format-dotfile $DOTFILES/.clang-format
ln -s $SOURCE_DIR/vim/clang-format-dotfile $DOTFILES/.clang-format

## post install hooks
if [ ${MACHINE} = "cdaq" -o ${MACHINE} = "jlab" ]; then
  echo "REMOVING YouCompleteMe Plugin for machine: ${MACHINE}"
  rm $DOTFILES/.vim/bundle/YouCompleteMe
  if [ -f $HOME/.clang-format ]; then
    echo "$HOME/.clang-format already found"
  else
    echo cp $SOURCE_DIR/vim/clang-format-dotfile $HOME/.clang-format
    cp $SOURCE_DIR/vim/clang-format-dotfile $HOME/.clang-format
  fi
else
  echo "BUILDING YouCompleteMe Plugin for machine ${MACHINE}"
  cd $DOTFILES/.vim/bundle/YouCompleteMe
  ./install.py --clang-completer
  cd -
fi
