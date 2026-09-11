# DEPLOYMENT — PHOTOBOX

## Environment Target
| Item | Nilai |
|------|-------|
| SSH Host | `alurelab` (alias) |
| Server | `emerald.hidden-server.net` |
| Port | `31988` |
| SSH login | `alurelab` |
| Repository dir | `/home/alurelab/repositories/photobox` |
| Git remote | `https://github.com/Gen-ei-Ryodan/photobox.git` |
| Branch | `main` |
| URL | `https://photobox.alureflow.com` |

## Alur Deploy — Otomatis (`deploy.sh`)

**Cara paling mudah** — jalankan dari folder `PHOTOBOX_WEB/`:

```bash
./deploy.sh
```

Script ini melakukan otomatis:
1. Cek koneksi SSH ke host `alurelab` (alias dari `~/.ssh/config`).
2. Cek status git lokal vs `origin/main`, dan minta push bila belum sinkron.
3. SSH ke server → `git pull`, `composer install --no-dev`, `npm install`, `npm run build`, `php artisan migrate --force`.
4. Copy asset `build/css/js` dari repo ke docroot publik `~/photobox.alureflow.com/`.
5. `optimize:clear` + `config:cache` + `route:cache` + `view:cache`.
6. Verifikasi HTTP `https://photobox.alureflow.com/` dan `/api/templates` (keduanya harus `200`).
7. Tampilkan tail `storage/logs/laravel.log` untuk memastikan tidak ada error baru.

> File: `PHOTOBOX_WEB/deploy.sh` (sudah di-commit & di-push). Konfigurasi SSH dibaca dari `~/.ssh/config`.

## Alur Deploy — Manual

```
LOCAL:
  git add . & git commit -m "..."
  git push origin main

SERVER:
  ssh alurelab
  cd repositories/photobox
  git pull origin main
  composer install --no-dev
  php artisan optimize:clear
  php artisan config:cache
  php artisan route:cache
  php artisan view:cache
```

## Upload Template Baru
```
LOCAL:
  sips -z 1800 600 foto/"2 photos"/XX.png --out resized/"2 photos"/XX.png
  scp resized/"2 photos"/XX.png alurelab:repositories/photobox/storage/app/private/photobox/templates/borders_new/XX.png

SERVER (via tinker):
  // 2-photo
  App\Models\Template::create(["name"=>"Template XX","slug"=>"template-xx","border_path"=>"photobox/templates/borders_new/XX.png","photo_config"=>["slots"=>[["x"=>64,"y"=>80,"width"=>467,"height"=>720],["x"=>64,"y"=>880,"width"=>467,"height"=>720]]],"supported_layouts"=>[2],"is_active"=>true,"sort_order"=>NEXT]);
  
  // 3-photo
  App\Models\Template::create(["name"=>"...","slug"=>"...","border_path"=>"...","photo_config"=>["slots"=>[["x"=>64,"y"=>120,"width"=>467,"height"=>480],["x"=>64,"y"=>660,"width"=>467,"height"=>480],["x"=>64,"y"=>1200,"width"=>467,"height"=>480]]],"supported_layouts"=>[3],"is_active"=>true,"sort_order"=>NEXT]);
  
  // 4-photo  
  App\Models\Template::create(["name"=>"...","slug"=>"...","border_path"=>"...","photo_config"=>["slots"=>[["x"=>64,"y"=>124,"width"=>467,"height"=>288],["x"=>64,"y"=>462,"width"=>467,"height"=>287],["x"=>64,"y"=>799,"width"=>467,"height"=>288],["x"=>64,"y"=>1136,"width"=>467,"height"=>288]]],"supported_layouts"=>[4],"is_active"=>true,"sort_order"=>NEXT]);
```

### 4 Konfigurasi Standar
| Count | y positions | height |
|-------|-------------|--------|
| 1-photo | y=218 | h=775 |
| 2-photo | y=92, 768 | h=514, 526 |
| 3-photo | y=190, 605, 1019 | h=341, 341, 340 |
| 4-photo | y=124, 461, 799, 1136 | h=287, 287, 287, 286 |

Border selalu dinormalisasi ke 600×1800 saat komposisi. Koordinat x/width mengikuti konfigurasi layout di `ImageProcessingService::LAYOUT_SLOTS`.

## Verifikasi Post-Deploy
1. Buka `https://photobox.alureflow.com` → HTTP 200
2. Cek `/api/templates` → JSON response dengan template baru
3. Cek `storage/logs/laravel.log` untuk error baru

## Peringatan
- **Jangan jalankan `migrate:fresh` / `db:wipe` di production** — ada data session nyata
- Template border PNG harus 600×1800px dengan area transparan untuk foto
- **Z-Index**: Foto di-insert dulu sebagai base, border PNG di-insert terakhir sebagai overlay (transparan)
- Slot positions di `photo_config` harus align dengan area transparan border

## Related
- [[PhotoBox]]
