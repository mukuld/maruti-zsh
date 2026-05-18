# Zsh Completion System
# Initialize the completion system
autoload -Uz compinit && compinit

# Arrow-key navigable completion menu
zstyle ':completion:*' menu select

# Colorized completions using existing LS_COLORS
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Group completions by category (files, commands, options etc.)
zstyle ':completion:*' group-name ''

# Label each category group
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'

# Auto-find newly installed executables without restarting the shell
zstyle ':completion:*' rehash true