#!/bin/bash

set -e

# Set project directory
PROJECT_DIR=${PROJECT_PATH:-/opt/reverse-proxy}  # fallback if PROJECT_PATH is not set

echo "🔧 Creating project directory at $PROJECT_DIR..."
sudo mkdir -p "$PROJECT_DIR"

echo "📂 Copying files..."
sudo cp -r . "$PROJECT_DIR"

echo "📁 Creating subdirectories if missing..."
sudo mkdir -p "$PROJECT_DIR"/{certs,vhost.d,html}

echo "🔌 Creating Docker network if it doesn't exist..."
docker network create nginx-proxy || true

echo "🐳 Starting reverse proxy with Docker Compose..."
docker compose -f "$PROJECT_DIR/docker-compose.yml" up -d

echo "✅ Reverse proxy is up and running at ports 80/443!"
