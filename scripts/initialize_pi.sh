#!/bin/bash
# Frank Meadows - Modular Pi Bootstrap v1.3
# Focused on: Gatus (Observability), Beszel (Resources), Dozzle (Logs)

set -e # Exit on error
set -o pipefail

echo "🚀 Starting Raspberry Pi Bootstrap..."

# --- 1. SYSTEM REFRESH ---
echo "🔄 Updating system packages..."
sudo apt update && sudo apt full-upgrade -y

# --- 2. INSTALL ESSENTIALS ---
echo "🛠️ Installing essential tools..."
sudo apt install -y vim git curl htop build-essential ca-certificates

# --- 3. DOCKER ENGINE SETUP ---
if ! [ -x "$(command -v docker)" ]; then
    echo "🐳 Installing Docker Engine..."
    curl -sSL https://get.docker.com | sh
    sudo usermod -aG docker "$USER"
    sudo apt install -y docker-compose-plugin
else
    echo "🐳 Docker already installed, skipping..."
fi

# --- 4. CONFIGURATION: GATUS ---
STACK_DIR="/opt/stacks/monitoring"
sudo mkdir -p "$STACK_DIR/gatus-config"
sudo chown -R "$USER:$USER" /opt/stacks

echo "📝 Writing Gatus configuration..."
cat <<EOF > "$STACK_DIR/gatus-config/config.yaml"
endpoints:
  - name: TerraMaster
    url: http://10.0.0.250
    interval: 30s
    conditions:
      - "[STATUS] == 200"

  - name: Synology
    url: http://10.0.0.249
    interval: 30s
    conditions:
      - "[STATUS] == 200"
EOF

# --- 5. AGENT STACK DEPLOYMENT ---
echo "🚢 Deploying Observability Agents..."
cat <<EOF > "$STACK_DIR/docker-compose.yml"
services:
  gatus:
    image: twinproduction/gatus:latest
    container_name: gatus
    restart: unless-stopped
    ports:
      - 8080:8080
    volumes:
      - ./gatus-config:/config

  beszel-agent:
    image: henrygd/beszel-agent:latest
    container_name: beszel-agent
    restart: unless-stopped
    network_mode: host
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro # Secure read-only mount
    environment:
      - PORT=45876

  dozzle-agent:
    image: amir20/dozzle:latest
    container_name: dozzle-agent
    restart: unless-stopped
    command: agent
    ports:
      - 7007:7007
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro # Secure read-only mount
EOF

docker compose -f "$STACK_DIR/docker-compose.yml" up -d

echo "------------------------------------------------"
echo "✅ BOOTSTRAP COMPLETE"
echo "Active Dashboard: http://$(hostname -I | awk '{print $1}'):8080"
echo "------------------------------------------------"