# HOW TO HOSTING & DEPLOYMENT — SINGULARITY

## 1. Spesifikasi Environment
- **Server**: bebas static hosting (Cloudflare Pages / Netlify / cPanel `public_html` / `python -m http.server`)
- **Domain / URL**: contoh `https://singularity.example.com`
- **Path**: satu folder berisi `index.html` + `assets/`
- **PHP / Node**: tidak perlu — murni static

## 2. Port & Service
- **Port Internal**: - (saat preview lokal: `python3 -m http.server 8742`)
- **Process Manager**: -
- **Database**: -

## 3. Langkah Deployment Step-by-Step
### A. Build
```bash
# Tidak ada build step
```
### B. Upload
```bash
rsync -av --delete PROJECTS/web/singularity/ user@server:/path/domain/
# atau unggah via File Manager cPanel
```
### C. Migrasi & Symlink (Jika Ada)
```bash
# Tidak ada. Pastikan path font relatif tetap: assets/fonts/*.woff2
```
### D. Verifikasi
```bash
curl -I https://domain/                 # 200
curl -I https://domain/assets/fonts/space-grotesk-var.woff2  # 200
```
QA browser: buka halaman, cek preloader hilang, scroll s/d Quellen, buka Impressum, toggle Ton (cek localStorage key `singularity-audio`).

## 4. Troubleshooting & Catatan Khusus
- Font 404 → folder `assets/fonts` belum ikut ter-upload (harus 3 file woff2).
- Audio hanya start setelah gesture pertama (autoplay policy) bila preferensi tersimpan "1".
- Semua konten external link (Quellen) — jangan di-proxy; situs sendiri tanpa resource pihak ketiga.
