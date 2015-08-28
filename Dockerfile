FROM million12/zabbix-agent
ADD zabbix_module_docker_centos7.so /usr/local/lib/zabbix_module_docker_centos7.so
COPY start.sh /start.sh
