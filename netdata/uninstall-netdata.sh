#!/usr/bin/env bash


set -euo pipefail


if (( $# == 0 )) || [[ "$1" != "yes" && "$1" != "no" ]]; then
	echo "Use \"yes\" argument if you want to remove config files, \"no\" if you don't"
	echo "Usage: sudo $0 yes/no"
	exit 1
fi

if [[ $EUID -ne 0 ]]; then
   echo "Error: This script has to be run with root permissions (use sudo)."
   exit 1
fi

if command -v netdata; then
	echo "Uninstalling netdata"
	wget -O /tmp/netdata-kickstart.sh https://get.netdata.cloud/kickstart.sh && \
	sudo sh /tmp/netdata-kickstart.sh --uninstall --yes --non-interactive && \
	echo "Netdata successfully uninstalled"
else
	echo "Netdata not installed"
	echo "Checking if config should be uninstalled..."
fi

if [[ "$1" = "yes" ]]; then
	echo "Uninstalling config files"
	rm -rvf /etc/netdata && \
	rm -rvf /var/cache/netdata && \
	rm -rvf /var/lib/netdata && \
	echo "Successfully uninstalled config files"
else  
	echo "Leaving config files"
fi
