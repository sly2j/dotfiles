module use "$HOME/.dotfiles/modulefiles/lcrc"
module load SciEnv

function lcrc_info() {
  echo -n "==================================================================="
  echo "====================="
  echo " COMPUTATION BALANCE"
  echo -n "==================================================================="
  echo "====================="
  /lcrc/soft/lcrc/bebop/bin/lcrc-sbank -q balance
  echo ""
  echo -n "==================================================================="
  echo "====================="
  echo " STORAGE QUOTA"
  echo -n "==================================================================="
  echo "====================="
  /lcrc/soft/lcrc/bebop/bin/lcrc-quota
  echo ""
  echo -n "==================================================================="
  echo "====================="
  echo " ACTIVE JOBS"
  echo -n "==================================================================="
  echo "====================="
  squeue -u $USER
}
  
ZSH_THEME="bira"
