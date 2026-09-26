# HOW TO HOSTING & DEPLOYMENT — KACAMATA (Toko Kacamata)

## 1. Spesifikasi Environment
- **Server**: belum di-deploy (masih tahap pengembangan lokal)
- **Domain / URL**: -
- **Path di Server**: `-`
- **PHP / Node Version**: PHP 8.5, Laravel 13.33, Composer 2
- **Database**: SQLite (`database/database.sqlite`) — schema juga kompatibel MySQL

## 2. Port & Service
- **Port Internal**: `php artisan serve` → 8000 (default)
- **Process Manager**: tidak ada (lokal)
- **Database**: SQLite file-based; backup pattern: `database/database.sqlite.bak_<tanggal>_<label>`

## 3. Langkah Setup (Lokal)
```bash
composer install
cp .env.example .env && php artisan key:generate
touch database/database.sqlite
php artisan migrate
```

## 4. Langkah Deployment Step-by-Step
### A. Build (Local / Server)
```bash
npm run build          # bila sudah ada bundling Vite/Tailwind
composer install --no-dev --optimize-autoloader
```

### B. Upload / Git Pull
```bash
git pull origin main
composer install --no-dev --optimize-autoloader
```

### C. Migrasi & Seeder
```bash
# WAJIB backup dulu sebelum fresh/seed di server yang berisi data:
cp database/database.sqlite database/database.sqlite.bak_$(date +%Y%m%d_%H%M%S)

php artisan migrate --force
php artisan db:seed --force
# hanya untuk environment kosong/baru:
php artisan migrate:fresh --seed
php artisan config:cache && php artisan route:cache
```

### D. Verifikasi
```bash
php artisan test --compact
vendor/bin/pint app database
curl -I https://example.com
```

## 5. Troubleshooting & Catatan Khusus
- **`migrate:fresh` = DESTRUKTIF** (drop semua table). Jangan dipakai di server berisi data; backup SQLite dulu.
- **Seeder `DatabaseSeeder.php` adalah satu file berisi semua data** (bukan per-tabel). Reset & seed ulang aman karena DB kosong setelah `fresh`.
- **Kolom lensa memakai `index_val`**, bukan `index` (`index` reserved di SQL).
- **Return type helper relasi**: method yang mengembalikan `$this->transactions()->...` harus bertipe `HasMany`, bukan `Builder` (relation ≠ Builder, akan TypeError).
- **Scope lokal Laravel 13**: `scopeActive()` (nama lawas) **masih didukung**, selain `#[Scope]` attribute.
- **Pint**: repo ini belum `git init`, jadi `pint --dirty` tidak bisa dipakai → jalankan `vendor/bin/pint app database`.
- File backup `.bak_*` di `app/Models/` aman dari autoloader (tidak berakhiran `.php`).
