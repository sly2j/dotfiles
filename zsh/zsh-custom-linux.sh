# Do nothing

if [ -f /etc/profile.d/modules.sh ]; then
  source /etc/profile.d/modules.sh
  if [ -d /usr/local/etc/modulefiles ]; then
    module use /usr/local/etc/modulefiles
  fi
fi
