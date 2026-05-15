#Configuring history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Advanced History Options
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY	# Write to the history file immediately
