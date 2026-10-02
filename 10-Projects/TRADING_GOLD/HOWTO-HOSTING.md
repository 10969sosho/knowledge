# HOW TO HOSTING & DEPLOYMENT — TRADING_GOLD

## 1. Spesifikasi Environment
- **Server**: Tidak ada (tool lokal di laptop)
- **Domain / URL**: —
- **Path**: `PROJECTS/finance/PROJECT/PROJECT ANTIGRAVITY/TRADING/TRADING_GOLD/`
- **Python**: `./venv/bin/python3` (Python 3.14, pandas 3.0, numpy 2.5)
- **Deklarasi dependensi**: ikut `requirements.txt` repo induk (pandas, numpy)

## 2. Port & Service
- Tidak ada service berjalan, tidak butuh port/PM2/database.
- Eksekusi batch, keluaran = terminal + file Markdown.

## 3. Langkah Menjalankan

### A. Backtest (wajib lolos tanpa error)
```bash
./venv/bin/python3 TRADING_GOLD/run_backtest.py
```
Runtime ~0,5 detik untuk 68k bar. Menulis `TRADING_GOLD/BACKTEST_RESULTS.md`
(otomatis backup `BACKTEST_RESULTS.md.bak_<ts>` sebelum ditimpa).

### B. Bridge MetaTrader 5 (macOS)
```bash
./venv/bin/python3 TRADING_GOLD/mt5_tools/mt5_bridge.py          # deteksi + tulis template
./venv/bin/python3 TRADING_GOLD/mt5_tools/mt5_bridge.py --check  # exit 1 bila MT5 tak ada
./venv/bin/python3 TRADING_GOLD/mt5_tools/mt5_bridge.py --force  # tulis ulang (backup dulu)
```
Mendeteksi `/Applications/MetaTrader 5.app`, binary di `Contents/MacOS`
(metaeditor/metatrader/terminal), dan data dir
`~/Library/Application Support/MetaQuotes/Terminal/`.
Template headless: `mt5_tools/templates/tester.ini`.

## 4. Troubleshooting & Catatan Khusus
- **MT5 tidak terdeteksi**: hasil `NOT FOUND` itu normal (exit 1 hanya untuk `--check`).
- **macOS tidak punya CLI Strategy Tester native**: jalankan
  `terminal64.exe /config:".../templates/tester.ini"` via Wine/Windows host;
  compile EA dengan `metaeditor64.exe /compile:"<path>" /log`.
- **Timestamp data dianggap UTC** — ubah bila broker pakai waktu server lain.
- **Strategi rugi di baseline**: itu hasil valid (PF 0.82 / 0.94), bukan error engine.
  Cek pembukuan: `unique signals == trades + sum(skip_reasons)` (sudah diverifikasi).
- **Timestamp format CSV**: `YYYY.MM.DD HH:MM`, delimiter `;`, header `Date;Open;High;Low;Close;Volume`.
