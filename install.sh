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

# Save the exact path where the user executed this script from
REPO_SRC_DIR=$(pwd)

export INSTALL_PATH=$HOME/.maruti-zsh
export PLUGIN_PATH=$INSTALL_PATH/.zsh/plugins

# 1. Handle Powerlevel10k safely
echo "Downloading PowerLevel10k repo..."
if [ ! -d "$HOME/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/powerlevel10k"
else
    echo "PowerLevel10k already downloaded. Skipping."
fi

# 2. Deploy Maruti-Zsh configurations using explicit absolute paths
echo "Deploying Maruti-Zsh configurations..."
mkdir -p "$INSTALL_PATH/.zsh"
mkdir -p "$PLUGIN_PATH"

# Copy files explicitly from our saved source directory context
cp -r "$REPO_SRC_DIR"/.zsh/*.zsh "$INSTALL_PATH/.zsh/" 2>/dev/null || true
cp "$REPO_SRC_DIR"/zshrc "$HOME/.zshrc"

# 3. Download Plugins into dedicated subfolders
echo "Downloading plugins..."
if [ ! -d "$PLUGIN_PATH/zsh-autosuggestions" ]; then
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "$PLUGIN_PATH/zsh-autosuggestions"
fi

if [ ! -d "$PLUGIN_PATH/zsh-syntax-highlighting" ]; then
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$PLUGIN_PATH/zsh-syntax-highlighting"
fi

# 4. Font deployment handling
if [ -d "$REPO_SRC_DIR/fonts" ]; then
    echo "Installing fonts..."
    mkdir -p "$HOME/.fonts"
    cp "$REPO_SRC_DIR"/fonts/* "$HOME/.fonts/"
    fc-cache -f
else
    echo "No fonts directory found. Skipping font installation."
fi

echo "Initialization complete. Awaken the wind by running: source ~/.zshrc or by restarting your terminal"
