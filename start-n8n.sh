#!/bin/bash

# Load Node.js environment
export PATH="/workspace/.npm-global/bin:$PATH"
export N8N_DATA_FOLDER="/workspace/n8n_data"

# Start n8n with proper configuration
n8n start \
  --tunnel \
  --host=0.0.0.0 \
  --port=5678 \
  --basic-auth-user=admin \
  --basic-auth-password=amtech123