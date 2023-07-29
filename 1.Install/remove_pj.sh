#!/usr/bin/env bash

set -euo pipefail

# shellcheck source=/dev/null
. ~/Documents/Github/2.1.Linux/1.Install/01_set_env_variables.sh

$DBG now in "$0"

# Exit if program is already installed
PROGRAM=code
if ! command -v "$PROGRAM" >/dev/null; then
    $DBG "$0" "$PROGRAM" is already uninstalled
    [[ "$0" == "${BASH_SOURCE[0]}" ]] && exit 0 || return 0
fi

case $ID in
fedora)
    $DBG -e "\n$PROGRAM not implemented in $ID\n"
    ;;
linuxmint | ubuntu)
    sudo apt remove code
    # intentionally does not remove other settings
    [[ "$0" == "${BASH_SOURCE[0]}" ]] && exit 0 || return 0

    # if needed, check with claude.ai for further details
    rm -fr ~/.config/Code/ # remove configuration files
    rm -fr ~/.vscode/      # remove VSCode extensions and other cached data
    rm -f ~/.local/share/applications/code.desktop
    sudo rm -f /usr/share/applications/code.desktop
    sudo rm -f /usr/share/pixmaps/code.png                            # remove desktop and menu shortcuts
    sudo rm -f /etc/apt/sources.list.d/vscode.list && sudo apt update # remove the apt repository
    ;;
*)
    echo "Distribution $ID not recognized, exiting ..."
    exit 1
    ;;
esac
