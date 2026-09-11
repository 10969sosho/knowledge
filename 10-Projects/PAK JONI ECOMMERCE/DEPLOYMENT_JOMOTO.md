# DEPLOYMENT — JOMOTO CENTER

## Environment Target
| Item | Nilai |
|------|-------|
| SSH Host | `alurelab` (alias) |
| Server | `emerald.hidden-server.net` |
| Port | `31988` |
| SSH login | `alurelab` |
| Repository dir | `/home/alurelab/repositories/pak-joni-ecommerce` |
| Public/Deploy dir | `/home/alurelab/jomotocenter.com` |
| Git remote | `https://github.com/Gen-ei-Ryodan/pak-joni-ecommerce.git` |
| Branch | `main` |
| URL | `https://jomotocenter.com` |

## Catatan Lingkungan (Shared Hosting, cPanel)
- PHP server: 8.4.23 (path: `/opt/alt/php84/usr/bin`) — selalu export PATH di skrip.
- **`rsync` TIDAK tersedia** di server → gunakan `cp -r`.
- Laravel public dir di `/home/alurelab/jomotocenter.com` (bukan /public_html).

## Skrip Deploy: `deploy.sh`
Proses (sudah terverifikasi jalan):
1. SSH login.
2. Set PATH php84.
3. `cd repository` → `git fetch origin main` → `git reset --hard origin/main`.
4. `cp -r` folder: `app bootstrap config database public resources routes` ke public dir.
5. `cp` file: `artisan composer.json composer.lock package.json vite.config.js`.
6. `chmod -R 755 storage bootstrap/cache`.
7. `rm -f bootstrap/cache/packages.php services.php`.
8. `composer install --no-dev --optimize-autoloader --no-interaction`.
9. `php artisan optimize:clear`, `config:cache`, `route:cache`, `view:cache`, `event:cache`, `migrate --force`.

## Alur Deploy Lengkap (Lokal → Produksi)
```
LOCAL:
  git add . & git commit -m "..."
  git push origin main
  ./deploy.sh          # eksekusi dari project root

SERVER (otomatis oleh deploy.sh):
  git fetch && git reset --hard origin/main   # sync repo
  cp -r app/config/... → public dir
  composer install
  php artisan optimize + migrate --force
```

## Perintah Migrate manual (jika perlu)
```
ssh -p 31988 alurelab "cd /home/alurelab/jomotocenter.com && php artisan migrate:status"
```
Status `[x] Ran` artinya sudah jalan. Jalankan `php artisan migrate --force` untuk sisa yang belum; `migrate:rollback` dengan hati-hati.

## Verifikasi Post-Deploy
1. Buka halaman admin & storefront → pastikan HTTP 200.
2. Cek `storage/logs/laravel.log` untuk error baru.
3. Cek `migrate:status` untuk migration yang belum running.

## Checklist
- [x] rsync diganti `cp` di deploy.sh
- [x] composer.json PHP `^8.3`, tanpa platform override
- [x] migration stock running (batch 7 & 8)
- [x] optimizations (config/route/view/event cache) dijalankan deploy

## Catatan Keamanan
- **`rsync` tidak ada** — jangan gunakan.
- **Jangan commit `.env.dusk`** (mengandung APP_KEY). Pastikan dikecualikan.
- Jangan jalankan `migrate:fresh` di production (38 migration).

## Related
- [[PAK JONI ECOMMERCE]]
- [[STOCK_MANAGEMENT]]
- [[BUGS_JOMOTO]]