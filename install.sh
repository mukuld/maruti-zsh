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
      ⚡ Minimalist Zsh Engine ⚡
EOF

# Verify Zsh is installed before proceeding
if ! command -v zsh >/dev/null 2>&1; then
    echo "❌ Error: Zsh is not installed on this system."
    echo "Please install Zsh using your system's package manager first."
    echo "Example (Debian/Ubuntu): sudo apt install zsh"
    exit 1
fi

# Save the exact directory where this script actually lives.
REPO_SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"

INSTALL_PATH=$HOME/.maruti-zsh
PLUGIN_PATH=$INSTALL_PATH/.zsh/plugins

# 1. Handle Powerlevel10k safely
echo "Downloading PowerLevel10k repo..."
if [ ! -d "$HOME/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/powerlevel10k"
else
    echo "PowerLevel10k already downloaded. Skipping."
fi

# 2. Deploy Maruti-Zsh configurations using explicit absolute paths
echo "Deploying Maruti-Zsh configurations..."

if [ "$REPO_SRC_DIR" != "$INSTALL_PATH" ]; then
    mkdir -p "$INSTALL_PATH"
    
    # Cleanly mirror core modular configurations, fonts, and git history tracking
    cp -r "$REPO_SRC_DIR/.zsh" "$INSTALL_PATH/"
    cp "$REPO_SRC_DIR/zshrc" "$INSTALL_PATH/"
    
    if [ -d "$REPO_SRC_DIR/fonts" ]; then
        cp -r "$REPO_SRC_DIR/fonts" "$INSTALL_PATH/"
    fi
    if [ -d "$REPO_SRC_DIR/.git" ]; then
        cp -r "$REPO_SRC_DIR/.git" "$INSTALL_PATH/"
    fi
fi

# Ensure plugin paths exist regardless of installation context
mkdir -p "$PLUGIN_PATH"

# Backup existing .zshrc safely (handles files, symlinks, and directories)
if [ -e "$HOME/.zshrc" ] || [ -L "$HOME/.zshrc" ]; then
    echo "⚠️ Existing .zshrc found. Backing up to ~/.zshrc.bak"
    mv -f "$HOME/.zshrc" "$HOME/.zshrc.bak"
fi

# Always deploy the master zshrc configuration from the active engine directory
cp "$INSTALL_PATH/zshrc" "$HOME/.zshrc"

# 3. Download Plugins into dedicated subfolders
echo "Downloading plugins..."
if [ ! -d "$PLUGIN_PATH/zsh-autosuggestions" ]; then
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "$PLUGIN_PATH/zsh-autosuggestions"
fi

if [ ! -d "$PLUGIN_PATH/zsh-syntax-highlighting" ]; then
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$PLUGIN_PATH/zsh-syntax-highlighting"
fi

# 4. Font deployment handling
if [[ "$OSTYPE" == "darwin"* ]]; then
    FONT_DIR="$HOME/Library/Fonts"
else
    FONT_DIR="$HOME/.fonts"
fi

# Assign the true source path for fonts dynamically
FONT_SRC="$INSTALL_PATH/fonts"
if [ "$REPO_SRC_DIR" != "$INSTALL_PATH" ] && [ -d "$REPO_SRC_DIR/fonts" ]; then
    FONT_SRC="$REPO_SRC_DIR/fonts"
fi

if [ -d "$FONT_SRC" ]; then
    echo "Installing fonts..."
    mkdir -p "$FONT_DIR"
    
    # Safely loop expansion to protect against empty directories under set -e
    for font in "$FONT_SRC"/*; do
        if [ -e "$font" ]; then
            cp "$font" "$FONT_DIR/"
        fi
    done
    
    if command -v fc-cache > /dev/null 2>&1; then
        fc-cache -f
    fi
else
    echo "No fonts directory found. Skipping font installation."
fi

echo "Initialization complete. Awaken the wind by running: source ~/.zshrc or by restarting your terminal"