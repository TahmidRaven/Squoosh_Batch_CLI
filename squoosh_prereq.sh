#!/bin/bash

CYAN='\033[0;36m'
NC='\033[0m'

if [ -z "$BASH_VERSION" ]; then
    exec bash "$0" "$@"
fi

if [ ! -d "/run/WSL" ] && [ ! -f "/proc/sys/fs/binfmt_misc/WSLInterop" ]; then
    printf "${CYAN}-----xoxo-----xoxo-----xoxo-----xoxo-----xoxo-----xoxo-----${NC}\n"
    echo "ERROR: WSL not detected!"
    echo "This script must be run inside a WSL Ubuntu terminal."
    echo "Please install WSL on Windows first using: wsl --install -d Ubuntu"
    printf "${CYAN}-----xoxo-----xoxo-----xoxo-----xoxo-----xoxo-----xoxo-----${NC}\n"
    exit 1
fi

if command -v squoosh-cli >/dev/null 2>&1; then
    printf "${CYAN}-----xoxo-----xoxo-----xoxo-----xoxo-----xoxo-----xoxo-----${NC}\n"
    echo "Squoosh CLI is already installed!"
    echo "You are ready to process images."
    printf "${CYAN}-----xoxo-----xoxo-----xoxo-----xoxo-----xoxo-----xoxo-----${NC}\n"
    exit 0
fi

echo "Starting Squoosh CLI environment setup for WSL..."

sudo apt update
sudo apt install -y curl gnupg ca-certificates apt-transport-https

curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

sudo npm install -g @squoosh/cli

if ! grep -q "no-experimental-fetch" ~/.bashrc; then
    echo 'export NODE_OPTIONS="--no-experimental-fetch"' >> ~/.bashrc
fi

export NODE_OPTIONS="--no-experimental-fetch"

printf "${CYAN}-----xoxo-----xoxo-----xoxo-----xoxo-----xoxo-----xoxo-----${NC}\n"
echo "SETUP COMPLETE!"
echo "You can now run your squoosh_batch_raven.sh script."
printf "${CYAN}-----xoxo-----xoxo-----xoxo-----xoxo-----xoxo-----xoxo-----${NC}\n"
# tahmidraven says buy bitches!
