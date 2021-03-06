#!/bin/sh
set -eu
# Agent ConfigFile
CONFIG_FILE="/usr/local/etc/zabbix_agentd.conf"
# Set TERM
export TERM=xterm
# Bash Colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
white=`tput setaf 7`
bold=`tput bold`
reset=`tput sgr0`
separator=$(echo && printf '=%.0s' {1..100} && echo)
# Logging Finctions
log() {
  if [[ "$@" ]]; then echo "${bold}${green}[LOG `date +'%T'`]${reset} $@";
  else echo; fi
}
start_agent() {
  zabbix_agentd -f -c ${CONFIG_FILE}
}
if [[ $ZABBIX_SERVER != "127.0.0.1" ]]; then
  log "Changing Zabbix Server IP to ${bold}${white}${ZABBIX_SERVER}${reset}."
  sed -i 's/Server=127.0.0.1/Server='$ZABBIX_SERVER'/g' ${CONFIG_FILE}
  echo 'LoadModule=zabbix_module_docker_centos7.so' >> ${CONFIG_FILE}
  echo 'LoadModulePath=/usr/local/lib' >> ${CONFIG_FILE}
  echo 'AllowRoot=1' >> ${CONFIG_FILE}
  echo 'User=root' >> ${CONFIG_FILE}
fi
log "Startting agent..."
log `start_agent`
