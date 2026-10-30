#!/usr/bin/env bash
set -euo pipefail

# Usage: ./scripts/render_dns.sh <pr-number> <base-domain>
# Example: ./scripts/render_dns.sh 123 dev.gameplatform.example.com
#
# Produces suggested DNS records for PR env.

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <pr-number> <base-domain>" >&2
  exit 1
fi

PR_NUMBER="$1"
BASE_DOMAIN="$2"

APP_HOST="server-pr${PR_NUMBER}.${BASE_DOMAIN}"
LOBBY_HOST="lobby-pr${PR_NUMBER}.${BASE_DOMAIN}"

cat <<EOF
Suggested DNS records for PR-${PR_NUMBER}:

- A / ALIAS (ALB DNS)
  ${APP_HOST}
  ${LOBBY_HOST}

If using wildcard certs, ensure *.${BASE_DOMAIN} is covered.

Use terraform module 'route53-record' with names:
  - ${APP_HOST}
  - ${LOBBY_HOST}
EOF