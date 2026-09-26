# HOW TO HOSTING & DEPLOYMENT — HASIL FASTINDO (ERP WMS)

## 1. Spesifikasi Environment
- **Server**: belum di-deploy (masih tahap pengembangan lokal)
- **Domain / URL**: -
- **Path di Server**: `-`
- **PHP / Node Version**: PHP 8.5 (Homebrew), Composer 2.9
- **Database**: SQLite (`database/database.sqlite`)

## 2. Port & Service
- **Port Internal**: `php artisan serve` → 8000 (default)
- **Process Manager**: tidak ada (lokal)
- **Database**: SQLite file-based; backup pattern: `database/database.sqlite.bak_<tanggal>_<label>`

## 3. Langkah Deployment Step-by-Step
### A. Build (Local / Server)
```bash
# belum ada frontend bundling step (Blade)
composer install --no-dev --optimize-autoloader
```

### B. Upload / Git Pull
```bash
git pull origin main
composer install --no-dev --optimize-autoloader
```

### C. Migrasi & Seeder
```bash
php artisan migrate --force
php artisan db:seed --force        # idempoten: reset + seed ulang
php artisan config:cache && php artisan route:cache
```

### D. Restart Service / Verifikasi
```bash
curl -I https://example.com
php artisan test --compact
```

## 4. Troubleshooting & Catatan Khusus
- **Unique key `locations.code` global**: kode BIN harus unik antar cabang → format `BIN-<CABANG>-<RACK>-<SHELF>` (contoh `BIN-SBY-A1-01`), bukan `BIN-A1-01` murni.
- **Seeder idempoten**: `DatabaseSeeder::resetTables()` menghapus child table dulu (urut FK) sehingga `php artisan db:seed` boleh dijalankan berulang tanpa konflik unique.
- **FIFO**: `Stock::fifoPick($branchId, $itemId, $qtyPcs)` → `[['stock'=>Stock,'qty'=>float]]`, urut `received_at` ASC (NULL terakhir).
- **Pint `--dirty` butuh git repo**: proyek ini belum `git init`, jadi jalankan `vendor/bin/pint app database`.
