#!/bin/bash
set -e

echo "Installing Ollama..."
curl -fsSL https://ollama.ai/install.sh | sh

echo "Starting Ollama server..."
ollama serve &

echo "Waiting for Ollama to be ready..."
for i in {1..60}; do
    if ollama list >/dev/null 2>&1; then
        echo "Ollama is ready!"
        break
    fi
    echo "Waiting... ($i/60)"
    sleep 2
done

echo "Pulling models..."
ollama pull hf.co/lmstudio-community/medgemma-4b-it-GGUF:Q4_K_M
ollama pull nomic-embed-text:latest

echo "Installing Python packages..."
pip install uv

echo "Setup complete!"