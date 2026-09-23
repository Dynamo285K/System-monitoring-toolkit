#!/usr/bin/env bash


set -euo pipefail


if command -v netdata > /dev/null; then
	echo "Netdata already installed"
else 
	echo "Installing netdata" 
	wget -O /tmp/netdata-kickstart.sh https://get.netdata.cloud/kickstart.sh && \
       	sh /tmp/netdata-kickstart.sh --non-interactive && \
	echo "Netdata successfully installed"
fi


if systemctl is-active --quiet netdata; then
	echo "Netdata is active"
else
	echo "Netdata is not active"
	systemctl start netdata
fi




