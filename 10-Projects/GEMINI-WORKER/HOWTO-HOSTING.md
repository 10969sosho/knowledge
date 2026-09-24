# HOW TO HOSTING & DEPLOYMENT — GEMINI-WORKER

## 1. Spesifikasi Environment
- **Server**: Tidak ada (tool lokal saja)
- **Domain / URL**: N/A — target cek: https://gemini.google.com
- **Path**: `~/.antigravity/tools/gemini-worker/`
- **Node Version**: Node.js v26.x / npm 11.x

## 2. Port & Service
- **Port Internal**: Tidak ada (script on-demand, bukan service)
- **Process Manager**: Tidak dipakai
- **Database**: Tidak ada

## 3. Langkah Setup / Run Step-by-Step
### A. Install
```bash
cd ~/.antigravity/tools/gemini-worker
npm init -y && npm i playwright
# TIDAK perlu npx playwright install — pakai binary Brave lokal
```

### B. Run
```bash
node test-session.js            # headless
HEADLESS=0 node test-session.js # headed
echo $?                         # 0=login, 1=belum, 2=error
```

## 4. Troubleshooting & Catatan Khusus
- **Profile in use**: Brave sedang jalan → script fallback auto-copy profile ke temp (`brave-sess-*`). Kalau mau pakai profile asli langsung, tutup Brave dulu.
- **Cookie tidak terbaca di temp copy**: pastikan `Local State` ikut ter-copy (berisi `os_crypt.encrypted_key`).
- **Gagal deteksi**: tambah wait di `page.waitForTimeout` — halaman Gemini kadang lambat render.
