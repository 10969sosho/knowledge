#!/usr/bin/env bash
# ==============================================================================
# MASTER DEPLOY SCRIPT — Alurelab & KBKB Hosting
# Digunakan oleh: Mac (Antigravity/OpenCode), Poco (Hermes Bot), Infinix (Sandbox)
# ==============================================================================
set -e

TARGET="${1}"
REPO="${2}"
DOMAIN="${3:-}"

show_help() {
  echo "Usage: $0 <target: alurelab|kbkb> <repo_name> [domain]"
  echo "Examples:"
  echo "  $0 alurelab kawasaki kawasaki.alurelab.com"
  echo "  $0 kbkb deppa kbkb.id"
  exit 1
}

if [ -z "$TARGET" ] || [ -z "$REPO" ]; then
  show_help
fi

# Map target server
case "$TARGET" in
  alurelab|emerald)
    SSH_HOST="emerald"
    # fallback jika alias host belum ada di ssh config
    SSH_CMD="ssh -p 31988 alurelab@160.187.143.18"
    ;;
  kbkb)
    SSH_HOST="kbkb"
    SSH_CMD="ssh -p 31988 kbkbid@157.15.77.18"
    ;;
  *)
    echo "❌ Target tidak dikenal: $TARGET (Pilih 'alurelab' atau 'kbkb')"
    exit 1
    ;;
esac

# Cek apakah host alias bisa langsung diakses
if ssh -o BatchMode=yes -o ConnectTimeout=5 "$SSH_HOST" "exit" 2>/dev/null; then
  EXEC_CMD="ssh $SSH_HOST"
else
  EXEC_CMD="$SSH_CMD"
fi

echo "🚀 [START] Deploying '$REPO' to $TARGET..."
TIMESTAMP=$(date -u +"%Y%m%d_%H%M%S")

# Remote execution script
$EXEC_CMD bash <<EOF
set -e
REPO_PATH="\$HOME/repositories/$REPO"

if [ ! -d "\$REPO_PATH" ]; then
  echo "❌ Error: Repository directory \$REPO_PATH tidak ditemukan di $TARGET!"
  exit 1
fi

echo "📦 [1/5] Updating Git repository at \$REPO_PATH..."
cd "\$REPO_PATH"

# Simpan state sebelumnya untuk rollback
PREV_COMMIT=\$(git rev-parse --short HEAD 2>/dev/null || echo "unknown")
echo "   Previous commit: \$PREV_COMMIT"

# Fetch & Reset to latest main
git fetch origin main
git reset --hard origin/main
NEW_COMMIT=\$(git rev-parse --short HEAD)
echo "   Updated to commit: \$NEW_COMMIT"

# Laravel Pipeline
if [ -f "artisan" ]; then
  echo "⚡ [2/5] Detected Laravel project..."
  if command -v composer &>/dev/null; then
    composer install --no-dev --optimize-autoloader --quiet || composer install --no-dev
  fi

  echo "🗄️ [3/5] Running migrations..."
  php artisan migrate --force

  echo "🧹 [4/5] Clearing & optimizing cache..."
  php artisan optimize:clear
  php artisan optimize || true
fi

# Node / Next.js Pipeline
if [ -f "package.json" ]; then
  echo "⚡ [2/5] Detected Node.js / Next.js project..."
  if command -v npm &>/dev/null; then
    npm ci --quiet 2>/dev/null || npm install --quiet
    if grep -q '"build":' package.json; then
      echo "🏗️ Building frontend assets..."
      npm run build
    fi
  fi
fi

# Centralized vs Copy docroot sync check
DOCROOT=""
if [ -d "\$HOME/public_html/$REPO" ]; then
  DOCROOT="\$HOME/public_html/$REPO"
elif [ -d "\$HOME/public_html" ] && [ -f "\$HOME/public_html/index.php" ]; then
  # Single domain direct docroot
  if grep -q "\$REPO" "\$HOME/public_html/index.php" 2>/dev/null; then
    DOCROOT="\$HOME/public_html"
  fi
fi

if [ -n "\$DOCROOT" ]; then
  echo "🔄 [5/5] Syncing assets to docroot: \$DOCROOT..."
  # Pastikan storage copy/symlink dan manifest build ter-copy
  if [ -d "\$REPO_PATH/public/build" ]; then
    mkdir -p "\$DOCROOT/build"
    cp -r "\$REPO_PATH/public/build/"* "\$DOCROOT/build/" 2>/dev/null || true
  fi
fi

echo "✅ [SUCCESS] Deployment \$REPO completed successfully! (Commit: \$NEW_COMMIT)"
EOF

# Health Check jika domain diisi
if [ -n "$DOMAIN" ]; then
  echo "🌐 Checking health status on https://$DOMAIN ..."
  HTTP_CODE=$(curl -sk -o /dev/null -w "%{http_code}" -L "https://$DOMAIN" || echo "000")
  echo "   HTTP Status: $HTTP_CODE"
  if [ "$HTTP_CODE" = "200" ] || [ "$HTTP_CODE" = "301" ] || [ "$HTTP_CODE" = "302" ]; then
    echo "🎉 Live verification PASSED!"
  else
    echo "⚠️ Warning: HTTP code is $HTTP_CODE (Please verify domain manually)"
  fi
fi

echo "🏁 [DONE] Finished deployment at $(date)."
