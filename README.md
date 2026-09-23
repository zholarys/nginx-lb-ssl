# Nginx Load Balancer + SSL Termination

A Docker Compose lab demonstrating Nginx as a reverse proxy: SSL termination, HTTP-to-HTTPS redirect, and round-robin load balancing across multiple backend instances.

## Architecture

- 3 backend instances (Nginx serving static content) representing application servers
- 1 Nginx load balancer terminating SSL and distributing traffic across the backend pool
- Self-signed certificate for local demonstration (production would use Let's Encrypt via certbot)

## What it shows

- Nginx `upstream` block for load balancing
- SSL/TLS termination at the proxy layer
- Automatic HTTP → HTTPS redirect
- A `/health` endpoint for monitoring integration

## Stack

Docker Compose, Nginx, OpenSSL

## Usage

\`\`\`bash
docker compose up -d
\`\`\`

Test load balancing:
\`\`\`bash
for i in {1..6}; do curl -sk https://localhost:8443; done
\`\`\`

Test HTTPS redirect:
\`\`\`bash
curl -I http://localhost:8080
\`\`\`
