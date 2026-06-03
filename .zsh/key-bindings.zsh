# ==============================================================================
# Maruti-Zsh Key Bindings Module
# Cross-Platform Baseline + Custom Widgets
# ==============================================================================

# Explicitly ensure Zsh Line Editor (ZLE) baseline uses Emacs mode
bindkey -e

# Initialize an associative array to map standard layout strings via terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Backspace]="${terminfo[kbs]}"

# Apply clean terminfo mapping database properties safely 
[[ -n "${key[Home]}" ]]      && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}" ]]        && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}" ]]     && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Delete]}" ]]     && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}" ]]         && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}" ]]       && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}" ]]       && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}" ]]      && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[Backspace]}" ]]  && bindkey -- "${key[Backspace]}"  backward-delete-char

# ------------------------------------------------------------------------------
# Cross-Platform Modifier Redundancy (Linux & macOS Compatibility)
# ------------------------------------------------------------------------------

# Alt / Option / Ctrl key bindings to traverse words
bindkey '^[[1;3D' backward-word      # macOS iTerm Option + Left
bindkey '^[[1;3C' forward-word       # macOS iTerm Option + Right
bindkey '^[b'     backward-word      # macOS native Terminal Option + Left
bindkey '^[f'     forward-word       # macOS native Terminal Option + Right
bindkey "^[[1;5D" backward-word      # Linux standard Ctrl + Left
bindkey "^[[1;5C" forward-word       # Linux standard Ctrl + Right

# Ctrl key bindings for deletion
bindkey '^H'      backward-kill-word # Ctrl + Backspace (Standard Linux/macOS)
bindkey '^[^?'    backward-kill-word # macOS Option + Backspace fallback
bindkey '^[[3;5~' kill-word          # Ctrl + Delete: Delete word ahead

# Core structural line clearing
bindkey '^U' kill-buffer 
bindkey '^L' kill-line 

# Bind Up and Down arrows to history search
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# Key bindings to manage cursor movement
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# Alt + . (Period): Insert the last argument from your previous command
bindkey '\e.' insert-last-word

# ------------------------------------------------------------------------------
# Custom Maruti-Zsh Productivity Widgets
# ------------------------------------------------------------------------------

# Ctrl + O: Open the current command in your $EDITOR (nano or vim)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^O' edit-command-line

# Smart Sudo Toggle
sudo-command-line() {
	[[ -z $BUFFER ]] && zle up-history
	if [[ $BUFFER == sudo\ * ]]; then
		LBUFFER="${LBUFFER#sudo }"
	else
		LBUFFER="sudo $LBUFFER"
	fi
}
zle -N sudo-command-line
bindkey '\es' sudo-command-line  # Bind to Alt+S

# Navigation Shortcuts
# Jump to Nginx Configs
nginx-cd() { BUFFER="cd /etc/nginx/sites-available/"; zle accept-line }
zle -N nginx-cd
bindkey '^XN' nginx-cd   # Bind to Ctrl+X N

# Jump to Web Root
www-cd() { BUFFER="cd /var/www/html/"; zle accept-line }
zle -N www-cd
bindkey '^XW' www-cd   # Bind to Ctrl+X W

# Clear screen + automatic item contextual listing
clear-ls-widget() {
	clear
	if [[ "$OSTYPE" == "darwin"* ]]; then
		ls -pG
	else
		ls -p --color=auto
	fi
	zle redisplay
}
zle -N clear-ls-widget
bindkey '^K' clear-ls-widget  # Bind to Ctrl+K

# Smart Pipe Grep Widget (Alt+G)
wrap-grep() {
	BUFFER="$BUFFER | grep "
	CURSOR=$#BUFFER
}
zle -N wrap-grep
bindkey '\eg' wrap-grep