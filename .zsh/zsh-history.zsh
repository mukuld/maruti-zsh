#Configuring history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Advanced History Options
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt SHARE_HISTORY        # Share history between terminals
setopt HIST_IGNORE_SPACE    # Commands prefixed with a space won't be saved (Useful for secrets)
