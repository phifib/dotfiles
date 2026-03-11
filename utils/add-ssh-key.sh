#!/bin/bash
# Generate a new SSH key (ed25519) and add to ssh-agent.
# Usage: ./add-ssh-key.sh [email]
#   email  Optional comment for the key (default: $USER@$(hostname))

set -e
EMAIL="${1:-$USER@$(hostname -s 2>/dev/null || echo localhost)}"
KEY_PATH="${HOME}/.ssh/id_ed25519"

echo "SSH key comment: $EMAIL"
echo "Key path: $KEY_PATH"
echo ""

if [ -f "$KEY_PATH" ]; then
  echo "A key already exists at $KEY_PATH"
  echo "To create another key, run: ssh-keygen -t ed25519 -C \"your_email\" -f ~/.ssh/id_ed25519_github"
  exit 1
fi

mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

echo "Generating new ED25519 key (you can set a passphrase or press Enter for none)..."
ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_PATH"

eval "$(ssh-agent -s)" 2>/dev/null || true
ssh-add --apple-use-keychain "$KEY_PATH" 2>/dev/null || ssh-add "$KEY_PATH" 2>/dev/null || true

echo ""
echo "Done. Your public key:"
echo "----------------------------------------"
cat "${KEY_PATH}.pub"
echo "----------------------------------------"
echo ""
echo "Add this key to:"
echo "  GitHub:  Settings → SSH and GPG keys → New SSH key"
echo "  GitLab:  Preferences → SSH Keys → Add new key"
echo "  Server:  append the line above to ~/.ssh/authorized_keys on the server"
echo ""
