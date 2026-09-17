# CMC_TRADER

CMC multi-strategy trading engine berbasis Python untuk screener CoinMarketCap, OHLCV Binance, backtesting, pattern lab, paper trading, dan live trading.

## Status

- Struktur dan implementasi sesuai `docs/CMC_TRADER_BUILD.md` sudah dibuat.
- Python 3.12 berhasil memasang seluruh dependency dan menjalankan 9 test.
- Python 3.14 tidak kompatibel dengan pin pandas lama pada requirements.
- `--mode paper` sudah terverifikasi berjalan.
- `--mode screener` membutuhkan `CMC_API_KEY` di `.env`.
- Mode `live` belum dijalankan karena dapat mengirim order nyata.

## Lokasi

- Source: `/Users/10969sosho/PROJECTS/finance/PROJECT/PROJECT ANTIGRAVITY/CMC_TRADER`
- Build spec: `docs/CMC_TRADER_BUILD.md`
