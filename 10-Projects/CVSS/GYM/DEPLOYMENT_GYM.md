# DEPLOYMENT — GYM Member Portal

## Environment Target
| Item | Nilai |
|------|-------|
| SSH Host | `alurelab` (alias) |
| Server | `emerald.hidden-server.net` |
| Port | `31988` |
| SSH login | `alurelab` |
| Identity File | `~/.ssh/id_ed25519` |
| Repository dir | `/home/alurelab/repositories/gym` |
| Public/Domain dir | `/home/alurelab/gym.alureflow.com` |
| Git remote | `https://github.com/10969sosho/gym.git` |
| Branch | `main` |
| URL | `https://gym.alureflow.com` |

## Catatan Server (Shared Hosting, cPanel)
- PHP path: `/opt/alt/php84/usr/bin` — wajib export PATH di setiap command
- **Symlink TIDAK berfungsi** untuk Apache — gunakan `cp -r` untuk file statis
- `deploy.sh` auto-sync file baru dari `repositories/gym/public/` ke public dir
- `index.php` custom: `$basePath = '/home/alurelab/repositories/gym'`

## Skrip Deploy: `deploy.sh`
Lokasi: project root (`gym-app/deploy.sh`)

Proses:
1. SSH login ke alurelab
2. Set PATH php84
3. `cd repository` → `git fetch && git reset --hard origin/main`
4. Update `.env` → production settings
5. `composer install --no-dev --optimize-autoloader`
6. `php artisan optimize:clear` + cache (config, route, view, event)
7. `php artisan migrate --force`

## Alur Deploy Lengkap
```
LOCAL:
  git add . && git commit -m "..."
  git push origin main
  ./deploy.sh

SERVER (otomatis oleh deploy.sh):
  git fetch && git reset --hard origin/main
  composer install --no-dev
  php artisan optimize + migrate --force
```

## Perintah Manual (jika perlu)
```bash
# Cek status migration
ssh -p 31988 alurelab "cd /home/alurelab/repositories/gym && php artisan migrate:status"

# Rollback (hati-hati)
ssh -p 31988 alurelab "cd /home/alurelab/repositories/gym && php artisan migrate:rollback --force"

# Cek log
ssh -p 31988 alurelab "tail -50 /home/alurelab/repositories/gym/storage/logs/laravel.log"
```

## Verifikasi Post-Deploy
1. `curl -s -o /dev/null -w "%{http_code}" https://gym.alureflow.com` → 302 (redirect ke login)
2. `curl -s -o /dev/null -w "%{http_code}" https://gym.alureflow.com/member/login` → 200
3. `curl -s -o /dev/null -w "%{http_code}" https://gym.alureflow.com/login` → 200
4. Cek `storage/logs/laravel.log` untuk error

## Environment Production
```
APP_ENV=production
APP_DEBUG=false
APP_URL=https://gym.alureflow.com
DB_CONNECTION=sqlite
SESSION_DRIVER=database
CACHE_STORE=database
QUEUE_CONNECTION=database
```

## Related
- [[GYM]]
- [[ARCHITECTURE_GYM]]
- [[DATABASE_GYM]]
