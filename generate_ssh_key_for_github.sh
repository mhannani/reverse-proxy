#!/bin/bash

set -e

KEY_PATH="$HOME/.ssh/id_ed25519"

# Step 1: Generate SSH key if not exists
if [ -f "$KEY_PATH" ]; then
  echo "✅ SSH key already exists at $KEY_PATH"
else
  echo "🔐 Generating a new SSH key at $KEY_PATH..."
  ssh-keygen -t ed25519 -C "github-deploy-key" -f "$KEY_PATH" -N ""
fi

# Step 2: Add key to ssh-agent (optional but nice for dev)
echo "🔧 Adding SSH key to ssh-agent..."
eval "$(ssh-agent -s)"
ssh-add "$KEY_PATH"

# Step 3: Output keys for copy-paste
echo ""
echo "📎 PRIVATE KEY (for GitHub Secret: SSH_KEY)"
echo "------------------------------------------------------------"
cat "$KEY_PATH"
echo "------------------------------------------------------------"

echo ""
echo "📎 PUBLIC KEY (for GitHub Deploy Keys)"
echo "------------------------------------------------------------"
cat "$KEY_PATH.pub"
echo "------------------------------------------------------------"