# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Created by newuser for 5.9
source ~/powerlevel10k/powerlevel10k.zsh-theme

setopt CORRECT
setopt CORRECT_ALL

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# 1. Run the loop first to establish cross-platform key baselines, completions, and history
for f in ~/.maruti-zsh/.zsh/*.zsh(N); do source "$f"; done

# 2. Source the plugins last so they can safely bind to your normalized environment
source ~/.maruti-zsh/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.maruti-zsh/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Set path to add binaries
export PATH=$PATH:/usr/sbin