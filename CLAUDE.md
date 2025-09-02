# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This repository contains a Docker-based deployment configuration for n8n (workflow automation platform) on Render.com. It's a deployment template that sets up n8n with proper Render configuration, environment variables, and database integration.

## Key Files and Architecture

- `render.yaml` - Render deployment configuration defining the web service, disk storage, and deployment settings
- `Dockerfile` - Simple Docker configuration extending the official n8n image
- `.env` - Environment variable template with n8n configuration including database, webhooks, and performance settings
- `database.sql` - PostgreSQL database dump containing n8n schema and data
- `export_workflows.sh` - Bash script for exporting n8n workflows from the deployment
- `mcp.json` - MCP (Model Context Protocol) server configuration for n8n integration

## Deployment Architecture

The project deploys n8n as a containerized web service on Render with:
- PostgreSQL database backend (Render-managed)
- Persistent disk storage mounted at `/home/node/.n8n` (critical path - do not modify)
- Docker runtime using the latest n8n image
- Environment-based configuration management

## Important Configuration Notes

- **Storage Path**: The mount path `/home/node/.n8n` is hardcoded in n8n and must not be changed
- **WEBHOOK_URL**: Must be set to the actual Render domain (e.g., `https://your-app.onrender.com/`) to avoid localhost issues
- **N8N_ENCRYPTION_KEY**: Required for data encryption, should be a secure random string
- **Database**: Uses PostgreSQL with environment variables auto-populated by Render

## Common Development Tasks

Since this is a deployment configuration repository, development tasks are primarily infrastructure-related:

- **Export workflows**: `./export_workflows.sh [directory]`
- **Deploy to Render**: Push to main branch (auto-deploys via Render Blueprint)
- **Database restore**: Import `database.sql` to Render PostgreSQL instance
- **Local testing**: `docker build . && docker run -p 5678:5678 --env-file .env <image>`

## Environment Variables

Key variables that should be configured in Render dashboard:
- `WEBHOOK_URL` - Your n8n domain endpoint
- `N8N_ENCRYPTION_KEY` - Encryption key for data security
- Database variables (auto-populated by Render PostgreSQL service)

## MCP Integration

The repository includes MCP server configuration (`mcp.json`) that connects to a remote n8n instance via Docker container with API authentication. The MCP server uses:
- Docker runtime execution
- N8N API integration with JWT authentication
- Error logging and console output management