#!/usr/bin/env bash

set -euo pipefail

# shellcheck source=/dev/null
. ~/Documents/Github/2.1.Linux/1.Install/01_set_env_variables.sh

$DBG now in "$0"

# Exit if program is already installed
PROGRAM=code
if command -v "$PROGRAM" >/dev/null; then
    $DBG "$0" "$PROGRAM" is already installed
    [[ "$0" == "${BASH_SOURCE[0]}" ]] && exit 0 || return 0
fi

case $ID in
fedora)
    $DBG -e "\n$PROGRAM not implemented in $ID\n"
    ;;
linuxmint | ubuntu)
    sudo apt install -y wget apt-transport-https
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
    sudo apt update && sudo apt install -y code
    ;;
*)
    echo "Distribution $ID not recognized, exiting ..."
    exit 1
    ;;
esac

$RUN "$PROGRAM"
