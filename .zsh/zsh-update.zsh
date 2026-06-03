# ==============================================================================
# Maruti-Zsh Automated Update Engine
# Checks for upstream repository updates every X days cleanly
# ==============================================================================

# Configuration
_MARUTI_UPDATE_DAYS=7
_MARUTI_LAST_CHECK_FILE="$HOME/.maruti-zsh/.update_check"

_maruti_check_for_updates() {
    # Check if the repository directory exists and is a git repository
    if [ ! -d "$HOME/.maruti-zsh/.git" ]; then
        return 0
    fi

    local current_time
    current_time=$(date +%s)
    
    # If the tracking file exists, see if enough time has passed
    if [ -f "$_MARUTI_LAST_CHECK_FILE" ]; then
        local last_check
        last_check=$(cat "$_MARUTI_LAST_CHECK_FILE" 2>/dev/null || echo 0)
        local delta=$(( current_time - last_check ))
        local sec_per_day=86400
        
        # If the interval hasn't passed yet, exit early to keep startup fast
        if [ "$delta" -lt $(( _MARUTI_UPDATE_DAYS * sec_per_day )) ]; then
            return 0
        fi
    fi

    # Update the timestamp file immediately so we don't nag on every single terminal opening
    echo "$current_time" > "$_MARUTI_LAST_CHECK_FILE"

    echo "⚡ Checking for Maruti-Zsh updates..."
    
    # Perform a quiet git fetch inside a subshell to check upstream status
    (
        cd "$HOME/.maruti-zsh" && \
        git fetch --quiet origin 2>/dev/null
    )

    # Compare local HEAD with remote branch tracking HEAD
    local local_commit remote_commit
    local_commit=$(cd "$HOME/.maruti-zsh" && git rev-parse HEAD)
    remote_commit=$(cd "$HOME/.maruti-zsh" && git rev-parse @{u} 2>/dev/null || echo "$local_commit")

    if [ "$local_commit" != "$remote_commit" ]; then
        echo ""
        echo "🎉 A new update for Maruti-Zsh is available!"
        echo -n "Would you like to update now? [Y/n]: "
        read -r response
        
        # Default to Yes if they just hit Enter
        if [[ "$response" =~ ^([yY][eE][sS]|[yY]|^$) ]]; then
            echo "Updating Maruti-Zsh configurations..."
            (
                cd "$HOME/.maruti-zsh" && \
                git pull --rebase origin main && \
                echo "Running the installation engine to sync changes..." && \
                ./install.sh
            )
        else
            echo "Skipping update. We will remind you again in $_MARUTI_UPDATE_DAYS days."
        fi
    fi
}

# Run the update check function when the shell session spawns
_maruti_check_for_updates