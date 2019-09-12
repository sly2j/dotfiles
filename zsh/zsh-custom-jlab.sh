if [ -f /group/jpsi-007/local/setup.sh ]; then
  source /group/jpsi-007/local/setup.sh
  source /group/jpsi-007/local/pro.sh
fi

if [[ $HOSTNAME == "hallgw"* ]]; then
  ZSH_THEME="bira"
fi
