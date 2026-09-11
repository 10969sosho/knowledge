#!/usr/bin/env bash
set -e

PROJECT_NAME="$1"

if [ -z "$PROJECT_NAME" ]; then
  echo "⚠️  Gunakan: ./init-project.sh <nama-project>"
  exit 1
fi

TARGET_DIR="/Users/10969sosho/knowledge/10-Projects/$PROJECT_NAME"

if [ -d "$TARGET_DIR" ]; then
  echo "ℹ️  Folder project '$PROJECT_NAME' sudah ada di $TARGET_DIR"
  exit 0
fi

mkdir -p "$TARGET_DIR"

# Generate HOWTO-HOSTING.md dari template
cat << TEMPLATE > "$TARGET_DIR/HOWTO-HOSTING.md"
# HOW TO HOSTING & DEPLOYMENT — $PROJECT_NAME

## 1. Spesifikasi Environment
- **Server**: [Alurelab (Emerald) / KBKB / VPS Lain]
- **Domain / URL**: https://$PROJECT_NAME.example.com
- **Path di Server**: \`/home/alurelab/repositories/$PROJECT_NAME\`
- **PHP / Node Version**: PHP 8.x / Node 20.x

## 2. Port & Service
- **Port Internal**: [Contoh: 3003]
- **Process Manager**: PM2 / Nohup / cPanel Node App
- **Database**: MySQL / MariaDB / SQLite (\`database/database.sqlite\`)

## 3. Langkah Deployment Step-by-Step
### A. Build (Local / Server)
\`\`\`bash
npm run build
\`\`\`

### B. Upload / Git Pull
\`\`\`bash
git pull origin main
composer install --no-dev --optimize-autoloader
\`\`\`

### C. Migrasi & Symlink (Jika Ada)
\`\`\`bash
php artisan migrate --force
# WAJIB Symlink Next.js jika static export di cPanel:
# ln -s . public/_next/static
\`\`\`

### D. Verifikasi
\`\`\`bash
curl -I https://$PROJECT_NAME.example.com
\`\`\`

## 4. Troubleshooting & Catatan Khusus
- [Catat isu unik proyek ini di sini]
TEMPLATE

# Generate README.md proyek
cat << README > "$TARGET_DIR/README.md"
# $PROJECT_NAME

## Deskripsi Singkat
- **Klien / Proyek**: $PROJECT_NAME
- **Tech Stack**: [Laravel / Next.js / React / dll.]
- **Tanggal Dibuat**: $(date '+%Y-%m-%d')

## Catatan Arsitektur & Database
- [Catatan penting struktur tabel atau flow aplikasi]
README

echo "✅ Docs untuk '$PROJECT_NAME' berhasil dibuat di $TARGET_DIR"
echo "   - $TARGET_DIR/HOWTO-HOSTING.md"
echo "   - $TARGET_DIR/README.md"

# Auto-sync ke git & HP Poco
/Users/10969sosho/knowledge/sync.sh
ssh -o RemoteCommand=none -o RequestTTY=no hppoco "proot-distro login debian -- /root/knowledge-hub/auto-pull.sh" 2>/dev/null || true
