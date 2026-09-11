---
title: Lead Hunter - Threads
tags:
  - project
  - threads
  - scraper
  - lead
created: 2026-08-07
---

# Lead Hunter - Threads Monitor

Dashboard web + scraper untuk memantau orang yang butuh jasa digital (website, aplikasi, ERP, dll) dari Threads, dan menampilkan lead dengan link post.

## Lokasi Proyek
`/Users/10969sosho/PROJECT/CVSS/EXPLORE/THREADS`

## Cara Menjalankan
```bash
npm start            # atau: node index.js
```
Dashboard: `http://localhost:3000`

Proses dijalankan permanen (background) dengan:
```bash
nohup node index.js > app.log 2>&1 & disown
```
- Cek log: `tail -f app.log`
- Hentikan: `kill -9 $(pgrep -f "index.js")`

## Arsitektur / Alur
1. **`index.js`** — memulai Express server (dashboard), tidak auto-scrape.
2. **`server.js`** — API kontrol: login/start/stop, kelola keyword, baca lead. Loop scraper berjalan per siklus (`CHECK_INTERVAL`).
3. **`services/threads.js`** — Playwright + Brave Browser, mengekstrak post dari hasil pencarian Threads.
4. **`public/index.html`** — dashboard UI (polling tiap 3 detik).

Semua kontrol dari UI: **Login Threads → Start Scraper → Stop**.

## Filter Lead (6 lapis)
1. **Buang comment/reply** — intercept respons GraphQL (`page.on('response')`), buang post dengan `is_reply: true`.
2. **Buang post lama** — lewat dari `MAX_POST_AGE_HOURS` (default 1 jam).
3. **Buang junk/loker** — regex `JUNK_PATTERN` di `server.js` (lowongan, hiring, buzzer, training/workshop, promo vendor, survei/riset/skripsi, reseller/affiliate, dst).
4. **Kecocokan inti keyword** — buang kata pembuka niat-beli (`butuh/cari/rekomendasi/ada yang bisa/jasa`, dst lihat `INTENT_LEADERS`), lalu pastikan sisa inti keyword (mis. `aplikasi kasir`) benar-benar ada di teks post. Memberantas fuzzy-match Threads.
5. **Buang bahasa non-Latin** — regez `NONLATIN` (Thai, Han, Hangul, Cyrillic, Devanagari, dst) untuk menolak lowongan/posting luar negeri.
6. **Buang diskusi umum** — regez `TALKING_ABOUT` (kata `sebenarnya`, `menurutku`, `jadi developer`, `belajar bikin`, dst) untuk buang post yang baru mengomentari, bukan membutuhkan.

## Konfigurasi (`.env`)
| Variabel | Keterangan | Default |
|---|---|---|
| `PORT` | Port dashboard | `3000` |
| `CHECK_INTERVAL` | Siklus cek (ms) | `60000` |
| `HEADLESS` | Jalankan browser tersembunyi | `true` |
| `MAX_POST_AGE_HOURS` | Batas usia post (jam) | `1` |
| `WAHA_URL`, `WAHA_API_KEY`, `WAHA_SESSION`, `WA_NUMBER` | (belum dipakai, cadangan untuk kirim WA) | - |

## Keyword
Disimpan di `config/keywords.json`, bisa diedit live dari UI. **Pola yang benar = frasa niat-beli, bukan kata generik** — kata generik (`butuh aplikasi`, `cek`, `rekomendasi`) di Threads mengembalikan mayoritas diskusi/curhat/vendor. Contoh frasa yang dipakai:
- `butuh jasa bikin website`, `jasa pembuatan company profile`, `cari yang bisa bikinin aplikasi`
- `jasa bikin aplikasi kasir`, `butuh aplikasi stok untuk toko`, `software laporan keuangan usaha`
- `butuh jasa web developer`, `jasa pembuatan software akuntansi

## Data
- `data/leads.json` — semua lead yang ditemukan (disimpan real-time saat ditemukan).
- `data/sent.json` — ID post yang sudah diproses (mencegah duplikat antar siklus).
- `data/session.json` — session login Threads (Playwright storageState).

## Catatan Teknis
- Threads **tidak punya `<article>`** — post ada di `div[data-pressable-container]`, link `/@user/post/ID`.
- Pencarian default ke tab **Recent** (diklik otomatis).
- Login Threads via OIDC Instagram; browser dibuka manual sekali, session disimpan.
- WAHA belum diintegrasikan (menyusul).

## Related

- [[PROJECT INDEX]]
- [[CVSS/CVSS]]
- [[Node.js]]
