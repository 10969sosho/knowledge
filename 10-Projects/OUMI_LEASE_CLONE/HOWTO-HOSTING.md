# HOWTO-HOSTING — OUMI_LEASE_CLONE

Situs statis 1 file, tanpa backend.

## Opsi 1: cPanel (Alurelab / hidden-server)
1. Upload `index.html` ke `public_html/` (atau subfolder `oumi-lease/`).
2. Tidak ada PHP/Node yang perlu dijalankan; cukup tambah domain/subdomain di cPanel → docroot ke folder tsb.

## Opsi 2: preview lokal
```bash
cd ~/oumi-lease-clone && python3 -m http.server 8777
# buka http://127.0.0.1:8777/
```

## Opsi 3: static hosting (Vercel/Netlify/GitHub Pages)
Drag folder `~/oumi-lease-clone` saja — tidak ada build command, output dir = root.

## Catatan
- Gambar di-hotlink dari `www.oumi-lease.com`; untuk produksi sendiri, unduh asset ke folder lokal dan ganti path agar tidak bergantung pada site orang lain.
