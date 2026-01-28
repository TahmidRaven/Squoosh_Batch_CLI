#!/bin/bash

CYAN='\033[0;36m'
NC='\033[0m'

# Ensure we are in Bash
if [ -z "$BASH_VERSION" ]; then
    exec bash "$0" "$@"
fi

# WSL Check
if [ ! -d "/run/WSL" ] && [ ! -f "/proc/sys/fs/binfmt_misc/WSLInterop" ]; then
    printf "${CYAN}-----xoxo-----xoxo-----xoxo-----xoxo-----xoxo-----xoxo-----${NC}\n"
    echo "ERROR: WSL not detected!"
    exit 1
fi

echo "Setting up NVM and Node 16 (The stable version for Squoosh)..."

# Install NVM if not present
if [ ! -d "$HOME/.nvm" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install and switch to Node 16
nvm install 16
nvm use 16

# Install Squoosh CLI specifically for this version
npm install -g @squoosh/cli

# Ensure the flag is in bashrc for future sessions
if ! grep -q "no-experimental-fetch" ~/.bashrc; then
    echo 'export NODE_OPTIONS="--no-experimental-fetch"' >> ~/.bashrc
fi

printf "${CYAN}-----xoxo-----xoxo-----xoxo-----xoxo-----xoxo-----xoxo-----${NC}\n"
echo "SETUP COMPLETE ON NODE $(node -v)!"
echo "You're ready to bulk. Run: sh squoosh_batch.sh"
printf "${CYAN}-----xoxo-----xoxo-----xoxo-----xoxo-----xoxo-----xoxo-----${NC}\n"
