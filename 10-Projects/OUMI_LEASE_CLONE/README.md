# OUMI_LEASE_CLONE

Clone statis landing page [oumi-lease.com](https://www.oumi-lease.com) (近江リース) — satu file `index.html` (vanilla HTML/CSS/JS, tanpa build step).

## Lokasi
- Kode: `~/oumi-lease-clone/index.html`
- Gambar di-hotlink langsung dari CDN asli `www.oumi-lease.com` (tidak ada asset lokal).

## Isi halaman
Header fixed (transparent → solid on scroll), hero layered kota/awan/gunung + parallax drift, Message + 2 kartu Rental Man, What's Rental Man (blok navy), 3 Service (alternating grid), Service AREA (4 prefektur), Feature marquee 5 kartu (CSS infinite scroll, duplikasi track via JS), kartu 洗濯工場, SDGs, News, dual Company/Recruit, Contact (tel: link), footer. Responsive: hamburger menu < 900px.

## Verifikasi
- Playwright 1.63 headless: console errors = 0, horizontal overflow = 0 (390px & 1440px).
- Lihat lokal: `python3 -m http.server 8777` di folder proyek → http://127.0.0.1:8777/

## Catatan
- Konten teks = salinan copy dari situs asli (demo/learning). Kalau mau dipakai produksi, ganti teks + gambar dengan aset sendiri.
