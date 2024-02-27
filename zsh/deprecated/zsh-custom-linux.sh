# Do nothing

if [ -f /etc/profile.d/modules.sh ]; then
  source /etc/profile.d/modules.sh
  if [ -d /usr/local/etc/modulefiles ]; then
    module use /usr/local/etc/modulefiles
  fi
fi

export LESSOPEN="| /usr/bin/highlight %s --out-format xterm256 --force"
[[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh
