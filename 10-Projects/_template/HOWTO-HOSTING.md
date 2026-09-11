# HOW TO HOSTING & DEPLOYMENT — [NAMA PROYEK]

## 1. Spesifikasi Environment
- **Server**: [Alurelab / KBKB / VPS Lain]
- **Domain / URL**: https://example.com
- **Path di Server**: `/home/[user]/public_html/...` atau `/home/[user]/repositories/...`
- **PHP / Node Version**: PHP 8.x / Node 20.x

## 2. Port & Service
- **Port Internal**: [Contoh: 3001, 3002, 8000]
- **Process Manager**: PM2 / Supervisor / Nohup / cPanel Node App
- **Database**: MySQL / MariaDB / SQLite (`database/database.sqlite`)

## 3. Langkah Deployment Step-by-Step
### A. Build (Local / Server)
```bash
# Contoh build
npm run build
```

### B. Upload / Git Pull
```bash
git pull origin main
composer install --no-dev --optimize-autoloader
```

### C. Migrasi & Symlink (Jika Ada)
```bash
php artisan migrate --force
# WAJIB Symlink Next.js jika static export di cPanel:
# ln -s . public/_next/static
```

### D. Restart Service / Verifikasi
```bash
curl -I https://example.com
```

## 4. Troubleshooting & Catatan Khusus
- [Catat isu unik proyek ini di sini, misal CORS, symlink 404, file permission]
