if [[ $1 == "cleanup" ]]; then
  rm -rf $DOTFILES/.zshrc
  exit 0
fi

if [ -f $DOTFILES/.zshrc -o -f $DOTFILES/.zsh-custom -o -f $DOTFILES/.oh-my-zsh ]; then
  echo "ERROR: zsh already configured on this system"
  echo "       Please run cleanup first"
  exit 1
fi

echo "Setting up ZIM"
cd $HOME
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
cd -

echo "Setting up theme"
echo "" >> ~/.zimrc
echo "## Custom theme" >> ~/.zimrc
echo "zmodule prompt-pwd" >> ~/.zimrc
echo "zmodule minimal" >> ~/.zimrc

echo "Setting up ssh keys"
echo '' >> ~/.zshrc
echo 'for key in `ls ~/.ssh/id_rsa* | grep -ve ".pub$"`; do' >> ~/.zshrc
echo '  ssh-add $key' >> ~/.zshrc
echo 'done' >> ~/.zshrc

if [ ${MACHINE} = "cdaq" ] || [ ${MACHINE} = "jlab" ]; then
  echo ln -s $SOURCE_DIR/zsh/launch-zsh-${MACHINE}.sh $DOTFILES/.launch-zsh.sh
  ln -s $SOURCE_DIR/zsh/launch-zsh-${MACHINE}.sh $DOTFILES/.launch-zsh.sh
fi
