# STP RENT A CAR & PARIWISATA INDONESIA — Web Demo

Demo web rental mobil & pariwisata (single page, interaktif).

## Identitas
- **Brand**: STP RENT A CAR & PARIWISATA INDONESIA
- **Legal**: PT Dolan Kreatif Nusantara
- **WA**: 081249907117 → `https://wa.me/6281249907117`
- **IG**: [@situkangpiknik](https://instagram.com/situkangpiknik)

## Lokasi
`~/PROJECTS/finance/PROJECT/PROJECT ANTIGRAVITY/RENTAL_MOBIL`

## Stack
- Vite 8 + React 19 + TypeScript
- Tailwind CSS v4 (`@tailwindcss/vite`, theme tokens di `src/index.css`)
- `lucide-react` (ikon), `lenis` (smooth scroll), `framer-motion` (animasi)
- Lint: `oxlint` (`npm run lint`)

## Perintah
```bash
npm install
npm run dev          # dev server
npm run build        # tsc -b && vite build → dist/
npm run preview      # serve build produksi
npm run lint
```

## Struktur
```
src/
  main.tsx          # init Lenis + raf loop + window.lenis
  App.tsx           # loading state + booking state bersama
  index.css         # @theme (gold/ink/moss/ivory) + util .glass/.gold-text/.noise
  data.ts           # armada, destinasi, trip, faq, testimoni, estimator, waLink
  components/
    Loader.tsx      # intro counter 0-100%
    Navbar.tsx      # progress bar scroll + menu mobile
    Hero.tsx        # booking bar mengambang (mobil/tanggal/kota/layanan)
    Highlights.tsx  # sticky stacked cards overlap
    Fleet.tsx       # filter kategori + Booking via WA
    Destinations.tsx# carousel destinasi & armada (tab)
    Booking.tsx     # kalender ketersediaan + estimator + jadwal trip
    Stories.tsx     # testimoni + FAQ accordion
    SiteFooter.tsx  # CTA + footer + tombol WA mengambang
```

## Fitur
1. Loading screen animasi counter 0–100%.
2. Lenis smooth scroll; anchor nav memakai `window.lenis.scrollTo` (`scrollToId()` di `data.ts`).
3. Hero + booking bar mengambang (state dibagikan ke estimator).
4. Sticky overlap cards keunggulan (murni CSS sticky, tanpa animasi opacity — lihat catatan bawah).
5. Fleet filter: Semua / MPV Keluarga / Luxury VIP / Group-Minibus, 8 unit, badge + tombol WA.
6. Carousel destinasi (Bromo, Bali, Jogja, Malang, Ijen) + tab Armada Pilihan.
7. Kalender interaktif: range tanggal, status terpakai (simulasi deterministik `isBooked()`), peringatan bila rentang menabrak tanggal terpakai.
8. Estimator tarif → pesan WhatsApp otomatis (`bookingMessage()`).
9. Testimoni (konten demo) + FAQ accordion.
10. Floating WA CTA + tema dark/gold/emerald/slate.

## Data penting (`src/data.ts`)
- Harga sewa **estimasi per hari**, dikonfirmasi ulang via WhatsApp.
- Layanan: lepas kunci (+0), dengan sopir (+150k/hari), bandara (+100k sekali jalan), trip wisata (+200k/hari).
- Diskon durasi: 3 hari+ 3%, 7 hari+ 8%, 30 hari+ 15% (dari subtotal sewa).
- Kalender "terpakai" = simulasi (`isBooked`), bukan data booking asli.

## Catatan Teknis
- **Jangan pakai `whileInView` framer-motion pada elemen `position: sticky`** di section Highlights: saat kartu saling menimpa, animasi opacity meninggalkan kartu semi-transparan sehingga teks kartu di bawah menembus. Solusi: kartu sticky dibuat polos (opak), animasi masuk cukup CSS/scroll biasa.
- Ikon brand `Instagram` sudah dihapus dari `lucide-react` v1 → dipakai SVG inline di `SiteFooter.tsx`.
- Tool `read` pada gambar sering menampilkan konten screenshot yang salah (cache path); verifikasi via `md5`/`sips` atau baca lewat path yang dimodifikasi.
