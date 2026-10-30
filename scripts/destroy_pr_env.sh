#!/usr/bin/env bash
set -euo pipefail

# Usage: ./scripts/destroy_pr_env.sh <pr-number>
# Example: ./scripts/destroy_pr_env.sh 123
#
# Destroys the PR environment under envs/pr/pr-123/.
# Runs terraform destroy with safety checks.

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_DIR="${REPO_ROOT}/envs/pr"

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <pr-number>" >&2
  exit 1
fi

PR_NUMBER="$1"
PR_ENV="${ENV_DIR}/pr-${PR_NUMBER}"

if [[ ! -d "$PR_ENV" ]]; then
  echo "❌ Environment directory not found: $PR_ENV"
  exit 1
fi

cd "$PR_ENV"

echo "⚠️  About to destroy environment pr-${PR_NUMBER}"
echo "Sleeping 5s... (Ctrl+C to cancel)"
sleep 5

terraform init -input=false -reconfigure
terraform destroy -auto-approve -input=false \
  -var="pr_id=pr-${PR_NUMBER}" \
  -var="force_destroy=true"

echo "Removing local directory $PR_ENV"
rm -rf "$PR_ENV"

echo "✅ Environment pr-${PR_NUMBER} destroyed"