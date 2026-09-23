# HOW TO HOSTING & DEPLOYMENT — KBKB (kbkb.id)

## 1. Spesifikasi Environment
- **Server**: KBKB — `157.15.77.18` (`nvme2.natanetwork.id`)
- **Domain / URL**: https://kbkb.id
- **SSH**: port `31988`, user `kbkbid`, alias config: `ssh kbkb` (IdentityFile `~/.ssh/id_ed25519_kbkb` — **key ini passphrase-protected**; jalankan `ssh-add ~/.ssh/id_ed25519_kbkb` dulu kalau agent kosong)
- **Path di Server**: lihat isi `/home/kbkbid/` (repo app); deploy script: `/home/kbkbid/deploy-kbkb.sh`
- **Database**: MySQL `kbkbid_membership`
- **PHP / Node**: PHP 8.x / Node 20.x (Laravel + Vite build)

> Catatan: `deploy.md` & `deploy.sh` di repo masih menunjuk path Alurelab (`/home/alurelab/repositories/kabekabe` → membership.solusisurabaya.com) — **jangan pakai itu untuk kbkb.id**. SOP resmi: `REVISI_DETAIL.md` bagian §9.

## 2. Port & Service
- **Port Internal**: default web server (Apache/Nginx hosting) — tidak ada port Node tambahan.
- **Process Manager**: hosting panel (tidak pakai PM2).
- **Database**: MySQL `kbkbid_membership` (dev lokal: SQLite `database/database.sqlite`).

## 3. Langkah Deployment Step-by-Step
### A. Verifikasi Lokal
```bash
git status --short --branch
php artisan test        # wajib hijau (152 tests per 2026-09-23)
npm run build           # refresh Vite manifest (halaman baru harus muncul di public/build/manifest.json)
```

### B. Backup dulu (WAJIB)
```bash
ssh kbkb 'mysqldump kbkbid_membership > /home/kbkbid/kbkbid_membership.before_$(date +%Y%m%d_%H%M).sql'
ssh kbkb 'cp -a /home/kbkbid/<repo-dir> /home/kbkbid/<repo-dir>.bak_$(date +%Y%m%d_%H%M)'
```

### C. Push Git
```bash
git add <file>
git commit -m "deskripsi"
git push origin main
```

### D. Deploy di Server
```bash
ssh kbkb
bash /home/kbkbid/deploy-kbkb.sh
# atau manual: git pull → composer install --no-dev → php artisan migrate --force → npm ci && npm run build → config:cache && route:cache && view:cache
```
Hanya `migrate --force`. **DILARANG**: `migrate:fresh`, `migrate:refresh`, `db:wipe`.

### E. Verifikasi
```bash
curl -I https://kbkb.id
curl -I https://kbkb.id/login     # 200
curl -I https://kbkb.id/partner   # 200
curl -I https://kbkb.id/admin     # 200
# guest /vendor/dashboard harus redirect ke /partner (302)
```

## 4. Troubleshooting & Catatan Khusus
- **SSH Permission denied (publickey)**: kemungkinan key belum di-decrypt — passphrase-protected. Minta user jalankan `ssh-add ~/.ssh/id_ed25519_kbkb`.
- **ViteException "Unable to locate file in Vite manifest"**: `public/build/manifest.json` basi — jalankan `npm run build` lokal (manifest ikut ke-commit? tidak — `/public/build` di-gitignore, jadi build HARUS jalan di server saat deploy).
- **Login portal salah guard**: partner login harus `/partner`, bukan `/login` (akan ditolak dengan pesan portal salah).
- **Member code lama**: format `7030YYNNNN` (10 char) tetap valid; format baru `7030YYMMNNN` (11 char) untuk member baru.
