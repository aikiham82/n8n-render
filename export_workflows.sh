#!/usr/bin/env bash

# Enhanced workflow export script for n8n on Render
# Usage: ./export_workflows.sh [export_directory]

set -euo pipefail

# Configuration
EXPORT_DIR="${1:-n8n-export-$(date +%Y%m%d-%H%M%S)}"
DATA_FOLDER="${DATA_FOLDER:-/home/node/.n8n}"
BACKUP_ROOT="${BACKUP_ROOT:-/backup}"

# Validate encryption key
if [[ -z "${N8N_ENCRYPTION_KEY:-}" ]]; then
  echo "Warning: N8N_ENCRYPTION_KEY is not set. This may cause issues with encrypted data."
  # Uncomment the following line to exit with error instead of just warning
  # exit 1
fi

echo "Starting n8n workflow export..."
echo "Export directory: $EXPORT_DIR"
echo "Data folder: $DATA_FOLDER"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_ROOT"

# Run the export
docker run --rm \
    -v "$DATA_FOLDER:/home/node/.n8n:ro" \
    -v "$BACKUP_ROOT:/backup" \
    -e N8N_ENCRYPTION_KEY="${N8N_ENCRYPTION_KEY:-}" \
    -e GENERIC_TIMEZONE="${GENERIC_TIMEZONE:-UTC}" \
    -e TZ="${TZ:-UTC}" \
    -u node \
    n8nio/n8n:latest \
    n8n export:workflow --backup --output="/backup/$EXPORT_DIR/" --data="/home/node/.n8n"

echo "✅ Workflows exported successfully to: $BACKUP_ROOT/$EXPORT_DIR/"
echo "📁 Export contents:"
ls -la "$BACKUP_ROOT/$EXPORT_DIR/" || echo "Could not list export contents"
