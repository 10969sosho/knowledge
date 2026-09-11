# HOW TO HOSTING & DEPLOYMENT — KAWASAKI DEALER MANAGEMENT SYSTEM

## 1. Spesifikasi Environment
- **Server**: Alurelab (Emerald - `emerald.hidden-server.net:31988` / `160.187.143.18`)
- **Domain / URL**: https://kawasaki.solusisurabaya.com
- **Path Repository**: `/home/alurelab/repositories/kawasaki`
- **Path Deployment (DocumentRoot)**: `/home/alurelab/kawasaki.solusisurabaya.com`
- **Tech Stack**:
  - Backend: Laravel 13.29.0, PHP 8.4.25
  - Frontend: Next.js 16.3.4 (Static SSG / Export), React 19, Tailwind CSS
  - Database: MariaDB / MySQL
  - Web Server: LiteSpeed / Apache dengan mod_rewrite

## 2. Arsitektur Deployment & Routing
- Frontend di-export secara statis (`output: "export"`, `trailingSlash: true`).
- Aset frontend ditempatkan langsung di `/home/alurelab/kawasaki.solusisurabaya.com/public/`.
- Backend Laravel berjalan di direktori yang sama dengan routing API dialihkan via `.htaccess` ke `public/index.php`.
- **API Prefix**: `/api/v3` di-forward ke Laravel API routes.
- **Symlink Penting**: `public/_next/static -> .` agar request `/_next/static/*` berhasil terbaca langsung.

## 3. Langkah Deployment Step-by-Step

### A. Pull Git Terbaru
```bash
ssh -p 31988 alurelab@emerald.hidden-server.net
cd ~/repositories/kawasaki
git pull origin main
```

### B. Build Frontend (SSG Export)
1. Siapkan environment production:
```bash
cd ~/repositories/kawasaki/frontend
cat << 'ENV' > .env.production
NEXT_PUBLIC_API_URL=https://kawasaki.solusisurabaya.com/api/v3
ENV
```

2. Konfigurasi `next.config.ts` untuk static export:
```ts
import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  output: "export",
  images: {
    unoptimized: true,
  },
  trailingSlash: true,
  typescript: {
    ignoreBuildErrors: true,
  },
};

export default nextConfig;
```

3. Generate static param split helper untuk route dinamis `[id]` (menghasilkan helper `generateStaticParams()` dan memindahkan logic ke `_Client.tsx` jika diperlukan oleh Next.js export).
4. Build:
```bash
npm run build
```

### C. Backup Target Deployment
```bash
mkdir -p ~/backups/kawasaki
tar -czf ~/backups/kawasaki/backup_prod_$(date +%Y%m%d_%H%M%S).tar.gz -C ~/kawasaki.solusisurabaya.com .
```

### D. Sync Backend Laravel & Update Route Prefix
1. Salin file backend yang diperbarui (`app/`, `routes/`, `database/`):
```bash
cp -r ~/repositories/kawasaki/backend/app ~/kawasaki.solusisurabaya.com/
cp -r ~/repositories/kawasaki/backend/routes ~/kawasaki.solusisurabaya.com/
cp -r ~/repositories/kawasaki/backend/database ~/kawasaki.solusisurabaya.com/
```
2. Pastikan prefix API di `routes/api.php` mengarah ke `v3`:
```bash
sed -i "s/Route::prefix('v1')/Route::prefix('v3')/" ~/kawasaki.solusisurabaya.com/routes/api.php
```
3. Clear cache Laravel:
```bash
cd ~/kawasaki.solusisurabaya.com
php artisan config:clear
php artisan route:clear
php artisan cache:clear
```

### E. Deploy Aset Frontend ke Production Public
1. Copy chunks dan media Next.js:
```bash
cp -r ~/repositories/kawasaki/frontend/out/_next/static/* ~/kawasaki.solusisurabaya.com/public/_next/
```
2. Copy halaman statis HTML:
```bash
cd ~/repositories/kawasaki/frontend/out
for item in *; do
  if [ "$item" != "_next" ] && [ "$item" != "favicon.ico" ]; then
    cp -r "$item" ~/kawasaki.solusisurabaya.com/public/
  fi
done
cp favicon.ico ~/kawasaki.solusisurabaya.com/public/favicon.ico/favicon.ico
```

### F. Verifikasi Deployment
```bash
curl -s -k -I https://kawasaki.solusisurabaya.com/
curl -s -k -I https://kawasaki.solusisurabaya.com/api/v3/dealers
```

## 4. Troubleshooting & Catatan Khusus
- **Dynamic SSG Error**: Next.js 16 SSG melarang `generateStaticParams` langsung di client component (`'use client'`). Komponen page dynamic `[id]` harus dipisah menjadi Server Wrapper (`page.tsx`) dengan `generateStaticParams()` dan Client Implementation (`_Client.tsx`).
- **Symlink Static**: Jangan menghapus symlink `public/_next/static -> .`.
- **API URL Base**: Frontend dikompilasi dengan endpoint `https://kawasaki.solusisurabaya.com/api/v3` agar cocok dengan reverse proxy & rewrite `.htaccess`.
