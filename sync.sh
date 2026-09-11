#!/usr/bin/env bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

echo "🔄 [Knowledge Sync] Pulling latest changes..."
git pull --rebase origin main || true

if [[ -n $(git status -s) ]]; then
  echo "📝 [Knowledge Sync] Changes detected, committing..."
  git add .
  git commit -m "sync: auto-update knowledge [$(date '+%Y-%m-%d %H:%M:%S')]"
  git push origin main
  echo "✅ [Knowledge Sync] Successfully pushed to origin main."
else
  echo "✨ [Knowledge Sync] Everything up to date."
fi
