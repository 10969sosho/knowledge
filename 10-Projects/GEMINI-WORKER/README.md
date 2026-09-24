# GEMINI-WORKER

Tool lokal (Node.js) untuk memeriksa status sesi login Google Gemini via browser Brave.

## Lokasi
- Path: `~/.antigravity/tools/gemini-worker/`
- Script utama: `test-session.js`

## Cara Pakai
```bash
cd ~/.antigravity/tools/gemini-worker
node test-session.js          # headless (default)
HEADLESS=0 node test-session.js   # tampilkan jendela browser
```

## Output / Exit Code
| STATUS | Exit | Arti |
|---|---|---|
| `LOGGED_IN` | 0 | Sudah login Gemini (ada chat input / di `gemini.google.com/app`) |
| `NOT_LOGGED_IN` | 1 | Dialihkan ke `accounts.google.com` atau muncul sign-in wall |
| `UNKNOWN` / error | 2 | Tidak bisa disimpulkan / browser gagal launch |

## Cara Deteksi
1. Launch Brave (persistent context) pakai profile asli:
   - Binary: `/Applications/Brave Browser.app/Contents/MacOS/Brave Browser`
   - Profile: `~/Library/Application Support/BraveSoftware/Brave-Browser`
2. Buka `https://gemini.google.com`, tunggu 6 detik.
3. Cek URL final + ada/tidaknya `textarea`/`[contenteditable]` (chat input) + teks sign-in wall.

## Catatan Teknis Unik
- **Profile lock**: kalau Brave sedang terbuka, launch langsung gagal (`Opening in existing browser session`). Script otomatis fallback: copy `Local State` + `Default/{Cookies, Preferences, Local Storage, ...}` ke folder temp lalu launch dari situ. Kunci enkripsi cookie tetap bisa dibuka karena binary tetap Brave (Keychain "Brave Safe Storage").
- Dependencies: `playwright` (tanpa `npx playwright install` — cukup binary Brave lokal).
- Node v26.7.0 / npm 11.19.0.
