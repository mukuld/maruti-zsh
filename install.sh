#!/bin/bash
cat << "EOF"
  __  __                _   _ 
 |  \/  |              | | (_)
 | \  / | __ _ _ __ _  | |_ _ 
 | |\/| |/ _` | '__| | | __| |
 | |  | | (_| | |  | |_| |_| |
 |_|  |_|\__,_|_|   \__|\__|_|
      ⚡ Minimalist Zsh Engine ⚡
EOF

export INSTALL_PATH=~/.maruti-zsh
export PLUGIN_PATH=$INSTALL_PATH/.zsh/plugins

echo "Downloading PowerLevel10k repo."
cd ~/
git clone https://github.com/romkatv/powerlevel10k.git ~/

echo "Deploying Maruti-Zsh configurations..."
mkdir -p $PLUGIN_PATH
cp -r .zsh/*.zsh $INSTALL_PATH/
cp zshrc ~/.zshrc

echo "Downloading plugins."
git clone https://github.com/zsh-users/zsh-autosuggestions $PLUGIN_PATH
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $PLUGIN_PATH
# Copy the patched fonts. I prefer FiraCode
if [ ! -d ~/.fonts ]; then
	mkdir -p ~/.fonts
fi
cp fonts/FiraCodeNerdFont-Medium.ttf ~/.fonts
fc-cache -f
echo "Initialization complete. Awaken the wind by running: source ~/.zshrc"
