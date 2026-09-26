# HOW TO HOSTING & DEPLOYMENT — STP RENT A CAR (RENTAL_MOBIL)

## 1. Spesifikasi Environment
- **Server**: belum di-deploy (lokal / demo)
- **Domain / URL**: belum ada
- **Path**: `~/PROJECTS/finance/PROJECT/PROJECT ANTIGRAVITY/RENTAL_MOBIL`
- **Node**: v26 (dev), build = Vite 8 + React 19 + TS

## 2. Port & Service
- **Port dev**: bebas, contoh `npm run dev -- --port 5199` (cek `lsof -i :<port>` dulu)
- **Port preview**: `npm run preview -- --port 4173`
- **Process manager**: belum ada (nohup/manual)
- **Database**: tidak ada (murni front-end)

## 3. Langkah Deployment

### A. Build
```bash
npm ci
npm run lint
npm run build      # output di dist/
```

### B. Upload / Static Hosting
Artefak statis murni (`dist/`), jadi bisa di-host di mana saja:

```bash
# contoh cPanel (public_html)
rsync -av --delete dist/ user@server:/home/user/public_html/stp/
```

> Untuk cPanel Next.js static export lama diperlukan symlink `_next/static`;
> proyek ini memakai Vite, jadi cukup upload isi `dist/` apa adanya
> (tidak ada `public/_next` / symlink).

### C. SPA Fallback (jika pakai routing)
Saat ini hanya 1 halaman, tidak perlu rewrite. Bila kelak ditambah route:
arahkan semua path ke `index.html`.

### D. Verifikasi
```bash
curl -I https://example.com
npm run preview && curl -sI http://127.0.0.1:4173/ | head -1   # harus 200
```

## 4. Troubleshooting & Catatan Khusus
- **Elemen sticky + `whileInView` (framer-motion)** menyebabkan kartu semi-transparan saat overlap → pakai kartu sticky tanpa animasi opacity.
- **`lucide-react` v1**: ikon brand (`Instagram`, dll.) sudah tidak ada → pakai SVG inline.
- **`ag-browser open` dengan query string** tidak menjamin reload penuh; modul Vite yang sudah di-cache bisa tetap lama. Untuk QA akurat: restart dev server di port baru, atau pakai Playwright headless (tersedia di `~/.antigravity/tools/ag-browser/node_modules`).
- **Horizontal scroll di mobile**: `body { overflow-x: hidden }` aktif, dan overflow 7px berasal dari carousel `overflow-x-auto` (aman, tidak bisa di-scroll horizontal).
- Gambar eksternal memakai URL `images.unsplash.com` (butuh internet saat runtime); bila offline, ganti dengan aset lokal di `public/`.
