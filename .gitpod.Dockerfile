FROM gitpod/workspace-full

# Persist n8n data across sessions
ENV N8N_DATA_FOLDER=/workspace/n8n_data
VOLUME /workspace/n8n_data

# Install required dependencies
RUN sudo apt-get update && \
    sudo apt-get install -y build-essential python3