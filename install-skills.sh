#!/bin/bash

# Install Vibe skills and agents into ~/.vibe/
echo "Installing Vibe skills..."
mkdir -p ~/.vibe/skills
cp -r ./out/vibe/skills/* ~/.vibe/skills/

echo "Installing Vibe agents..."
mkdir -p ~/.vibe/agents
cp -r ./out/vibe/agents/* ~/.vibe/agents/

echo "Installation complete!"
