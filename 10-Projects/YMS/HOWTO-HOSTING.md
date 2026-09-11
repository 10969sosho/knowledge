# HOW TO HOSTING & DEPLOYMENT — YMS (YAMAHA MUSIC SCHOOL)

## 1. Spesifikasi Environment
- **Server**: Alurelab (Emerald - `emerald.hidden-server.net:31988` / `160.187.143.18`)
- **Domain / URL**: https://yms.solusisurabaya.com
- **Path Repository**: `/home/alurelab/repositories/yms`
  - Backend: `/home/alurelab/repositories/yms/yms-backend`
  - Frontend: `/home/alurelab/repositories/yms/yms-frontend`
- **Path Deployment (DocumentRoot)**: `/home/alurelab/yms.solusisurabaya.com`
- **Tech Stack**:
  - Backend: Laravel 13.29.0, PHP 8.4.25, SQLite (`database/database.sqlite`)
  - Frontend: Next.js 16.3.4 (Static Export), React 19, Tailwind CSS, Lucide React
  - Web Server: LiteSpeed / Apache dengan mod_rewrite

## 2. Arsitektur & Routing
- Frontend Next.js di-build menggunakan mode `output: "export"`.
- Output static export (`out/`) disinkronkan langsung ke root web `/home/alurelab/yms.solusisurabaya.com`.
- Routing statis dilayani melalui aturan rewrite `.htaccess` yang memetakan URL ke file `.html` (misal `/salary-rules` -> `salary-rules.html`).
- Backend API (`/api/v1/*`) dilayani oleh `index.php` pada DocumentRoot yang memanggil bootstrap Laravel di `repositories/yms/yms-backend`.
- Autentikasi API menggunakan Laravel Sanctum Bearer token.

## 3. Langkah Deployment Step-by-Step

### A. Pull Git Terbaru
```bash
ssh -p 31988 alurelab@emerald.hidden-server.net
cd ~/repositories/yms
git pull origin main
```

### B. Database Migration & Backend Cache
```bash
cd ~/repositories/yms/yms-backend
php artisan migrate --force
php artisan config:clear
php artisan route:clear
php artisan cache:clear
```

### C. Backup DocumentRoot Produksi
```bash
mkdir -p ~/backups/yms
tar -czf ~/backups/yms/backup_yms_$(date +%Y%m%d_%H%M%S).tar.gz -C ~/yms.solusisurabaya.com .
```

### D. Build Frontend (Next.js Static Export)
```bash
cd ~/repositories/yms/yms-frontend
npm run build
```

### E. Deploy Hasil Build ke DocumentRoot
```bash
cd ~/repositories/yms/yms-frontend/out
cp -r * ~/yms.solusisurabaya.com/
```

### F. Verifikasi Deployment
```bash
# Verifikasi frontend utama
curl -s -k -I https://yms.solusisurabaya.com/

# Verifikasi halaman hasil build terbaru (misal: salary-rules)
curl -s -k -I https://yms.solusisurabaya.com/salary-rules

# Verifikasi backend API (harus mengembalikan 401 unauthenticated jika dipanggil tanpa token)
curl -s -k -I -H 'Accept: application/json' https://yms.solusisurabaya.com/api/v1/courses
```

## 4. Troubleshooting & Catatan Khusus
- **401 vs 500 Route [login] not defined**: Laravel API middleware `auth:sanctum` membutuhkan header `Accept: application/json` saat request. Jika tidak dikirim, Laravel akan mencoba me-redirect ke named route `login` yang tidak terdaftar di backend API stateless.
- **Shared Runtime Architecture**: `yms.solusisurabaya.com/index.php` mengeksekusi kernel Laravel langsung dari repository `yms-backend`, sehingga setiap migrasi dan update controller di repository langsung aktif tanpa copy manual seluruh folder vendor.
