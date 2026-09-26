# Singularitat (Klon singularity.engl.design)

Website edukasi satu halaman (Bahasa Jerman) tentang AGI & teknologische Singularität — konten, struktur (00–11 + Quellen + Impressum), dan estetika gelap sesuai referensi `https://singularity.engl.design/`.

## Stack
- **Static HTML tunggal**: `index.html` (CSS + JS inline, tanpa framework/build step).
- **Font self-hosted**: Space Grotesk (variable) + Space Mono 400/700 di `assets/fonts/*.woff2` — klaim "kein Tracking, keine Drittanbieter" tetap benar.
- **Fitur**: preloader counter 00–100%, HUD (wordmark, Ton/Impressum/credit), scale-nav 01–11 (IntersectionObserver), reveal-on-scroll, `<dialog>` Impressum & Datenschutz, toggle audio ambience (WebAudio drone, preferensi di `localStorage['singularity-audio']`).

## Struktur
```
PROJECTS/web/singularity/
├── index.html          # seluruh situs
└── assets/fonts/       # 3 file woff2
```

## QA
Playwright headless (1440 / 390 / 320 px): preloader hilang, 12 chapter, 23 sumber, reveal, scale active, dialog buka/tutup, audio toggle + localStorage, 0 console/HTTP error, 0 horizontal scroll, HUD tidak overflow (credit disembunyikan <380px). Lihat `/tmp/singqa/`.

## Catatan
- Referensi asli memakai WebGL tunnel + Lenis; versi ini sengaja scroll biasa (ponytail: tanpa WebGL).
- Backup edit: `index.html.bak_20260926_pre-fix`.
