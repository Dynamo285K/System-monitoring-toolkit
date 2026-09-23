#!/usr/bin/env bash

set -euo pipefail


if ! command -v netdata &>/dev/null; then
	echo "Netdata not installed."

	answer=''
	while [[ "$answer" != "y" && "$answer" != "n" ]]; do
		read -r -p "Do you want to istall? \"[y/n]\"" answer
	done

	if [[ "$answer" = "n" ]]; then
		echo "You have to install \"Netdata\" first."
		exit 1
	elif [[ "$answer" = "y" ]]; then
		echo "Installing \"Netdata\"..."
		./setup-netdata.sh && \
		echo "Following with load test..."
	fi
fi

# Test
# Install stress command if neeeded
if ! command -v stress &>/dev/null; then
	sudo apt-get update && sudo apt install -y stress
fi

# Cpu test for 2 cores for 100%
echo "Starting cpu test for 2 cores for 100%..."
stress --cpu 2 --timeout 30s
echo "Cpu test has finished"

# Mem test for 600M
echo "Starting mem test for 600M..."
stress --vm 1 --vm-bytes 600M --timeout 30s
echo "Mem test has finished"

# Cpu & mem test for 2 cores and 500M mem
echo "Starting cpu & mem test for 2 cores and 500M mem..."
stress --cpu 2 --vm 1 --vm-bytes 500M --timeout 30s
echo "Cpu & mem test has finished"





