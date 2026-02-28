# Check if ssh-agent is already running
if [[ -n "$SSH_AUTH_SOCK" ]] && pgrep -q ssh-agent; then
    return 0
fi

# Start ssh-agent
eval "$(ssh-agent -s)" >/dev/null
echo "ssh-agent launched. PID=$SSH_AGENT_PID"

# Add SSH keys based on OS
local ssh_keys=(~/.ssh/id_rsa ~/.ssh/id_ed25519)

case "$OSTYPE" in
    darwin*)
        for key in $ssh_keys; do
            [[ -f "$key" ]] && ssh-add --apple-use-keychain "$key" >/dev/null 2>&1
        done
        ;;
    linux-gnu*)
        # Check if keychain is available
        if command -v keychain >/dev/null 2>&1; then
            local existing_keys=()
            for key in $ssh_keys; do
                [[ -f "$key" ]] && existing_keys+=("$key")
            done
            [[ ${#existing_keys[@]} -gt 0 ]] && eval "$(keychain --eval --agents ssh $existing_keys)"
        fi
        ;;
esac
