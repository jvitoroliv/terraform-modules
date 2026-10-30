#!/usr/bin/env bash
set -euo pipefail

# Usage: ./scripts/new_pr_env.sh <pr-number>
# Example: ./scripts/new_pr_env.sh 123
#
# Creates a new PR environment under envs/pr/pr-123/
# by copying the _template directory.

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_DIR="${REPO_ROOT}/envs/pr"
TEMPLATE_DIR="${ENV_DIR}/_template"

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <pr-number>" >&2
  exit 1
fi

PR_NUMBER="$1"
NEW_ENV="${ENV_DIR}/pr-${PR_NUMBER}"

if [[ -d "$NEW_ENV" ]]; then
  echo "❌ Environment for PR-${PR_NUMBER} already exists at $NEW_ENV"
  exit 1
fi

echo "Creating new PR environment: pr-${PR_NUMBER}"

cp -r "$TEMPLATE_DIR" "$NEW_ENV"

# Rename example tfvars if exists
if [[ -f "$NEW_ENV/pr.auto.tfvars.example" ]]; then
  mv "$NEW_ENV/pr.auto.tfvars.example" "$NEW_ENV/pr.auto.tfvars"
fi

# Replace placeholder PR ID inside locals.tf
sed -i.bak "s/pr_id *= .*/pr_id = \"pr-${PR_NUMBER}\"/" "$NEW_ENV/locals.tf" && rm -f "$NEW_ENV/locals.tf.bak"

echo "✅ Environment created at $NEW_ENV"