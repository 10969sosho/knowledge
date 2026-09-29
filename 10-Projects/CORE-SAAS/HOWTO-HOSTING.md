# HOW TO HOSTING & DEPLOYMENT — CORE-SAAS (Backend)

## 1. Spesifikasi Environment
- **Server**: Belum di-deploy (lokal)
- **Domain / URL**: TBD
- **Path di Server**: TBD
- **PHP / Node Version**: PHP 8.5.5 (Homebrew) / Node 20+

## 2. Port & Service
- **Port Internal**: `php artisan serve --port=8000` (dev)
- **Process Manager**: -
- **Database**: SQLite `database/database.sqlite` (default). Untuk production pindah ke MySQL/MariaDB → set `DB_*` di `.env`.

## 3. Langkah Deployment Step-by-Step
### A. Build (Local / Server)
```bash
composer install --no-dev --optimize-autoloader
npm install && npm run build   # hanya jika ada frontend/Vite
```

### B. Upload / Git Pull
```bash
git init && git remote add origin <repo>
git pull origin main
composer install --no-dev --optimize-autoloader
```

### C. Env & Migrasi
```bash
cp .env.example .env && php artisan key:generate
# isi DB_* + LLM_API_URL / LLM_API_KEY / LLM_MODEL
php artisan migrate --force
php artisan config:cache && php artisan route:cache && php artisan view:cache
```

### D. Restart Service / Verifikasi
```bash
curl -I https://<domain>/
php artisan test --compact
```

## 4. Troubleshooting & Catatan Khusus
- Tanpa `LLM_API_KEY`, sentiment & reply otomatis memakai fallback lokal/template — bukan error. Cek `config('services.llm')`.
- Kalau LLM sering timeout: turunkan `LLM_TIMEOUT` dan pastikan `analyzeSentiment`/`generateReply` dipanggil asinkron (queue) agar tidak memblokir request.
- SQLite tidak aman untuk multi-worker production → wajib MySQL/MariaDB sebelum scale.
