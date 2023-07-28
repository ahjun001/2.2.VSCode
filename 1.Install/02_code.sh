#!/usr/bin/env bash

# 02_code.sh
# Install Visual Studio Code, VSCode

set -euo pipefail
IFS=$'\n\t'
# shellcheck source=/dev/null
. ~/Documents/Github/2.1.Linux/1.Install/01_set_env_variables.sh

# Exit if command is already installed
if command -v code >>"$INSTALL_LOG"; then
    if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then [[ "$0" == "${BASH_SOURCE[0]}" ]] && exit 0 || return 0; else return 0; fi
fi

case $ID in
fedora)
    # PKG_FMT='rpm'
    # PKG_MGR='dnf'
    # MY_TERM_COMMAND='konsole'
    # MY_FLAGS='-e'
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    dnf check-update
    sudo dnf install code
    ;;
linuxmint | ubuntu)
    # PKG_FMT='deb'
    # PKG_MGR='apt'
    # MY_TERM_COMMAND='gnome-terminal'
    # MY_FLAGS='-x'
    sudo apt-get install wget gpg
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg
    sudo apt install apt-transport-https
    sudo apt update
    sudo apt install code # or code-insiders
    ;;
*)
    echo "Distribution $ID not recognized, exiting ..."
    exit 1
    ;;
esac

#     ls "$LOCAL_RES_DIR"code*."$PKG_FMT" &>/dev/null || (
#         read -r -n 1 -s -p "Set firefox about:preferences Downloads to 'Always ask where to save files'

# Save in ${LOCAL_RES_DIR}

# Press any key to continue ..." &&
#             "$MY_TERM_COMMAND" "$MY_FLAGS" firefox https://code.visualstudio.com/Download
#     )

#     CODE_FILE=$(ls "$LOCAL_RES_DIR"code*."$PKG_FMT") && sudo "$PKG_MGR" install "$CODE_FILE"
# fi

echo " $0 : Exiting ..."
