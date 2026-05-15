#!/bin/bash
# Exit immediately if a command exits with a non-zero status
set -e

cat << "EOF"
  __  __                _   _ 
 |  \/  |              | | (_)
 | \  / | __ _ _ __ _  | |_ _ 
 | |\/| |/ _` | '__| | | __| |
 | |  | | (_| | |  | |_| |_| |
 |_|  |_|\__,_|_|   \__|\__|_|
      ⚡ Purging Maruti-Zsh ⚡
EOF

export INSTALL_PATH=$HOME/.maruti-zsh

echo "This will completely remove Maruti-Zsh configuration, plugins, fonts, and powerlevel10k."
read -p "Are you sure you want to proceed? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "Uninstallation cancelled."
    exit 1
fi

# 1. Remove the custom configuration engine directory
if [ -d "$INSTALL_PATH" ]; then
    echo "Removing Maruti-Zsh engine directory ($INSTALL_PATH)..."
    rm -rf "$INSTALL_PATH"
else
    echo "Maruti-Zsh engine directory not found. Skipping."
fi

# 2. Remove Powerlevel10k
if [ -d "$HOME/powerlevel10k" ]; then
    echo "Removing Powerlevel10k theme folder..."
    rm -rf "$HOME/powerlevel10k"
else
    echo "Powerlevel10k directory not found. Skipping."
fi

# 3. Clean up the main .zshrc
if [ -f "$HOME/.zshrc" ]; then
    echo "Removing ~/.zshrc file..."
    rm -f "$HOME/.zshrc"
    
    # Optional: Restore standard fallback if system has one, or leave clean
    if [ -f /etc/skel/.zshrc ]; then
        echo "Restoring default system .zshrc fallback..."
        cp /etc/skel/.zshrc "$HOME/.zshrc"
    else
        echo "Creating a fresh, empty ~/.zshrc."
        touch "$HOME/.zshrc"
    fi
fi

echo "--------------------------------------------------"
echo "✨ Maruti-Zsh has been successfully uninstalled."
echo "Please restart your active terminal session."
echo "--------------------------------------------------"
