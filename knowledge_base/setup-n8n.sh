#!/bin/bash

# Install Node.js v20 using NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$HOME/.nvm"
. "$NVM_DIR/nvm.sh"
nvm install 20
nvm use 20

# Set up global npm directory
mkdir -p "$HOME/.npm-global"
npm config set prefix "$HOME/.npm-global"
export PATH="$HOME/.npm-global/bin:$PATH"
echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> ~/.bashrc

# Install n8n
npm install -g n8n

# Create required folders
mkdir -p "$HOME/n8n_data/config"
mkdir -p "$HOME/.n8n"

# Create .env file for n8n settings
cat <<EOF > "$HOME/n8n_data/config/.env"
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=supersecret
N8N_ENCRYPTION_KEY=$(openssl rand -hex 24)
N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true
EOF

# Load the .env variables
export $(cat "$HOME/n8n_data/config/.env" | xargs)

# Fix file permissions
chmod 600 "$HOME/.n8n/config" 2>/dev/null || true

# Start n8n
n8n
