#!/bin/bash

# Load environment
source ~/.bashrc

# Verify Node.js version
NODE_VERSION=$(node -v)
if [[ $NODE_VERSION != v20* ]]; then
    echo "Wrong Node.js version ($NODE_VERSION). Installing Node.js 20..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install 20
    nvm use 20
fi

# Verify n8n installation
if ! command -v n8n &> /dev/null; then
    echo "Installing n8n..."
    npm install -g n8n --prefix=/workspace/.npm-global
    export PATH="/workspace/.npm-global/bin:$PATH"
fi

# Create config directory
mkdir -p /workspace/n8n_data/config

# Generate configuration file
cat > /workspace/n8n_data/config/.env <<EOL
N8N_HOST=0.0.0.0
N8N_PORT=5678
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=amtech123
N8N_ENCRYPTION_KEY=$(openssl rand -hex 16)
N8N_USER_FOLDER=/workspace/n8n_data
EOL

# Start n8n with proper configuration
export N8N_CONFIG_FILES=/workspace/n8n_data/config/.env
/workspace/.npm-global/bin/n8n start