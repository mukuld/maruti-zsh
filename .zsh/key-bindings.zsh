# Alt key bindings to traverse words
bindkey '^[[1;3D' backward-word
bindkey '^[[1;3C' forward-word

# Ctrl key bindings
bindkey '^H' backward-kill-word # Ctrl + Backspace. Delete previous word
bindkey '^[[3;5~' kill-word    # Ctrl + Delete: Delete the word in front of the cursor
bindkey '^U' kill-buffer 
bindkey '^L' kill-line 

# Bind Up and Down arros to history search
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# Key bindings to manage cursor movement
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
# Alt + . (Period): Insert the last arugment from your previous command
# This is incredibly useful for: mkdir test && cd [Alt+.]
bindkey '\e.' insert-last-word

# Key bindings for system tools
#bindkey '^K' clear-screen
# Ctrl + O: Open the current command in your $EDITOR (nano or vim)
# Perfect for when a one-line gets too long and you need a full screen to see it.
autoload -z edit-command-line
zle -N edit-command-line 	# zle is the Zsh Line Editor. Imagine it as a tiny text editor living inside the command line
bindkey '^O' edit-command-line

# Define the function
sudo-command-line() {
	[[ -z $BUFFER ]] && zle up-history
	if [[ $BUFFER == sudo\ * ]]; then
		LBUFFER="${LBUFFER#sudo }"	# LBUFFER = Everything to the left of the cursor
	else
		LBUFFER="sudo $LBUFFER"
	fi
}

# Create the widget
zle -N sudo-command-line

# Bind it to Alt+S
bindkey '\es' sudo-command-line

# Manage Nginx
# Jump to Nginx Configs
nginx-cd() { BUFFER="cd /etc/nginx/sites-available/"; zle accept-line }
zle -N nginx-cd
bindkey '^N' nginx-cd 	# Bind to Ctrl+N

# Jump to Web Root
www-cd() { BUFFER="cd /var/www/html/"; zle accept-line }
zle -N www-cd
bindkey '^W' www-cd 	# Bind to Ctrl+W

# Clear screen function
clear-ls-widget() {
	clear
	# -p adds a / to directories, -G adds color (Debian/Linux)
	ls -pG
	# Tell ZLE to redraw the prompt at the bottom
	zle redisplay
}

# Register the widget
zle -N clear-ls-widget

# Bind it to Ctrl+K
bindkey '^K' clear-ls-widget

# Adds ' | grep ' to the end of the current line and moves cursor to the end
wrap-grep() {
	BUFFER="$BUFFER | grep "
	CURSOR=$#BUFFER
}

# Register the widget
zle -N wrap-grep
bindkey '\eg' wrap-grep		# Bind to Alt+G
