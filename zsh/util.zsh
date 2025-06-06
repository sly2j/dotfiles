# Backup
function backup {
  iname=$1
  oname="$HOME/Data/backups/$1-$(date +'%Y%m%d-%H%M').tar"
  echo "backing up $iname to $oname"
  tar -cf $oname $iname
}
