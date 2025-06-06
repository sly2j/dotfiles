export CONDA_ROOT=
if [ -d "$HOME/Software/opt/miniforge3" ]; then
    export CONDA_ROOT=$HOME/Software/opt/miniforge3/
fi
if [ -z $CONDA_ROOT ]; then
    return 0
fi

# Conda path
export PATH="${CONDA_ROOT}/bin:$PATH"
# Conda
__conda_setup="$("${CONDA_ROOT}/bin/conda" 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    [ -f "${CONDA_ROOT}/etc/profile.d/conda.sh" ] && source "$_"
fi
unset __conda_setup

# Env switcher
function workon {
  request=
  case $1 in
    tf | tensorflow) request=tf ;;
    torch | pytorch) request=torch ;;
    root) request=root ;;
    base) request=base ;;
    *) echo "ERROR: Unknown environment: $1" && return 1 ;;
  esac
  if [ -z $request ]; then
      echo "ERROR: Environment not found on this system: $1" && return 1
  elif [ "$request" = "base" ]; then
      conda activate base
  else
      for pyversion in py3.12 py3.11 py3.10 ; do
        if [ -d ${CONDA_ROOT}/envs/${request}-${pyversion} ]; then
            conda activate ${request}-${pyversion}
            break
        fi
    done
  fi
}

# Disable conda's prompt change (spaceship already does this)
export CONDA_CHANGEPS1=false
