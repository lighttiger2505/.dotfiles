# Check if ssh-agent is already running
if [[ -S "$SSH_AUTH_SOCK" ]]; then
    return 0
fi

# Start ssh-agent
eval "$(ssh-agent -s)" >/dev/null

# Add SSH keys based on OS
# Pick up every private key named id_* (N. = nullglob + regular files only)
local ssh_keys=(~/.ssh/id_*(N.))
ssh_keys=(${ssh_keys:#*.pub})

case "$OSTYPE" in
    darwin*)
        for key in $ssh_keys; do
            ssh-add --apple-use-keychain "$key" >/dev/null 2>&1
        done
        ;;
    linux-gnu*)
        # Check if keychain is available
        if command -v keychain >/dev/null 2>&1; then
            (( $#ssh_keys )) && eval "$(keychain --eval --agents ssh $ssh_keys)"
        fi
        ;;
esac
