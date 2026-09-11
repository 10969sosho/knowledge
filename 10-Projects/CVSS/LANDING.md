# LANDING — Landing Page CV Solusi Surabaya

Landing page conversion-focused untuk traffic **Meta Ads / Google Ads** dengan output **WhatsApp Leads**.

## Status
- **DEPLOYED (live)** · repo `landingcvss` (https://github.com/Gen-ei-Ryodan/landingcvss)
- URL: **https://digital.solusisurabaya.com**
- Path: `/Users/10969sosho/PROJECT/CVSS/CAMPAIGN ADS/LANDING`
- Server deploy: `alurelab` (SSH) → repo `/home/alurelab/repositories/landingcvss` (pull/main) → build statik → `/home/alurelab/digital.solusisurabaya.com`

## Deployment (Static Export, shared hosting cPanel)
- Next.js dikonfigurasi **static export** (`output: "export"` + `images.unoptimized: true`) karena target cPanel shared hosting (bukan Node/PM2).
- Build: `npm run build` → output `out/`, hasil disalin ke folder domain `/home/alurelab/digital.solusisurabaya.com`.
- **Perubahan terakhir yg wajib dipakai**: `opengraph-image.tsx` (dynamic, `ImageResponse`) dihapus & diganti `src/app/opengraph-image.png` statik (salin logo) karena tidak kompatibel dgn static export.
- `sitemap.ts` & `robots.ts` diberi `export const dynamic = "force-static"`.
- Verified live: HTTP 200, title & logo OK.
- Push dari local (GitHub credentials hanya di Mac), lalu server `git pull origin main`.
- Backup cPanel default (`.htaccess`, `.user.ini`, `.well-known`, `php.ini`, `cgi-bin`) di server: `/tmp/landingcvss-backup/`.

## Tech Stack
- Next.js 15 (App Router) + TypeScript
- Tailwind CSS v4 + shadcn/ui (Nova)
- GSAP + ScrollTrigger, Lenis (tarik), SplitType, Framer Motion
- Font: Space Grotesk

## Struktur
```
src/app/          layout, page, icon, robots, sitemap, metadata
src/components/layout   Navbar, Footer
src/components/sections 11 section landing
src/components/providers SmoothScrollProvider (Lenis+GSAP)
src/hooks/use-scroll-reveal.ts
src/lib/site.ts     konfigurasi contact/WA (WAJIB diisi)
src/lib/content.ts  copywriting semua section
public/images/      logo, before/after, foto editorial
```

## Peta Section
Hero → Permasalahan → Akibat → Solusi → Testimoni → Hasil (before/after) → Cara Kerja → Paket Harga → Dokumentasi → FAQ → CTA → Footer

## WhatsApp
- Nomor: **+62 812-1636-2213** → `6281216362213` (di `src/lib/site.ts`)

## Before Go-Live (Checklist)
- Isi nomor WhatsApp asli di `src/lib/site.ts` (sudah pakai `+62 812-1636-2213`)
- Ganti foto asli → gambar/project asli client
- Isi alamat, IG (`@cvsolusisurabaya`), email (`hi@solusisurabaya.com`), gmaps

## Pricing
- Label `/ sekali bayar` dihapus → diganti tulisan **"Start From"** di atas harga (`pricing.tsx`). Untuk paket `Hubungi Kami`, label Start From disembunyikan.

## Related
- [[CVSS]]
- [[CVSS/CVSS#1. CAMPAIGN ADS|Campaign Ads]]
- [[Next.js]]