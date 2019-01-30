if [[ $1 == "cleanup" ]]; then
  rm -rf $DOTFILES/.rootlogon.C
  rm -rf $DOTFILES/.rootstyle.C
  exit 0
fi

if [ -f $DOTFILES/.rootlogon.C -o -f $DOTFILES/.rootstyle.C ]; then
  echo "ERROR: rootlogon.C already configured on this system"
  echo "       Please run cleanup first"
  exit 1
fi

echo ln -s $SOURCE_DIR/root/rootlogon.C $DOTFILES/.rootlogon.C
ln -s $SOURCE_DIR/root/rootlogon.C $DOTFILES/.rootlogon.C
echo ln -s $SOURCE_DIR/root/rootstyle.C $DOTFILES/.rootstyle.C
ln -s $SOURCE_DIR/root/rootstyle.C $DOTFILES/.rootstyle.C
