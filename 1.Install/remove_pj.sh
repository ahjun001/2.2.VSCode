#!/usr/bin/env bash

set -euo pipefail

# shellcheck source=/dev/null
. ~/Documents/Github/2.1.Linux/1.Install/01_set_env_variables.sh

# Exit if program is already installed
PROGRAM="${PROGRAM:?}"
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
    rm -r ~/.config/Code/ # remove configuration files
    rm -r ~/.vscode/      # remove VSCode extensions and other cached data
    rm ~/.local/share/applications/code.desktop
    sudo rm /usr/share/applications/code.desktop
    sudo rm /usr/share/pixmaps/code.png # remove desktop and menu shortcuts
    sudo add-apt-repository --remove \
        "deb [arch=amd64] https://packages.microsoft.com/repos/vscode  \
        stable main" # remove the apt repository
    ;;
*)
    echo "Distribution $ID not recognized, exiting ..."
    exit 1
    ;;
esac
