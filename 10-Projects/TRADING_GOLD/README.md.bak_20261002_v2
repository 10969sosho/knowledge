# TRADING_GOLD — Backtesting & MT5 Automation (XAUUSD)

Toolkit backtest strategi gold (XAUUSD) + jembatan konfigurasi MetaTrader 5.
**Local-only**, tidak di-deploy ke server.

## Struktur

```
TRADING_GOLD/
├── data/                       # CSV OHLCV multi-TF (delimiter ';')
│   └── XAU_15m_data.csv        # 494k bar, 2004-06-11 → 2026-01-30
├── engine/backtester.py        # engine: sizing 1% risk, spread, komisi, metrik
├── strategies/
│   ├── asian_range_sweep.py    # sweep Asia 00:00-06:30 UTC, entry London 07:00-11:30
│   └── trend_pullback.py       # EMA50/200 H1 + RSI pullback, SL 1.5x ATR
├── mt5_tools/mt5_bridge.py     # deteksi MT5 macOS + template tester.ini
├── run_backtest.py             # runner → terminal + BACKTEST_RESULTS.md
└── BACKTEST_RESULTS.md         # laporan komparasi (auto-backup sebelum ditimpa)
```

## Menjalankan

```bash
./venv/bin/python3 TRADING_GOLD/run_backtest.py
./venv/bin/python3 TRADING_GOLD/mt5_tools/mt5_bridge.py   # deteksi MT5 + tulis template
```

## Parameter broker (engine/backtester.py → `BrokerConfig`)

| Parameter | Nilai |
|---|---|
| Initial capital | $10.000 |
| Spread | $0.30/oz (dikenakan saat entry) |
| Komisi | $7.00 per lot round-turn ($3.5/side) |
| Risk per trade | 1% equity |
| Lot sizing | 1 lot = 100 oz; 0.01 lot = $1 per $1 move; floor ke 0.01 |
| Fill | open bar berikutnya setelah signal |
| Ambigu intrabar | SL dicek dulu sebelum TP (konservatif) |

## Metrik

Total Trades, Win Rate %, Profit Factor, Max Drawdown %, Net Profit $,
Sharpe Ratio (return harian equity × √252), Avg Win $, Avg Loss $.

## Hasil (3 tahun terakhir: 2023-01-30 → 2026-01-30, 68.246 bar 15m)

| Metric | Asian Range Sweep | Trend Pullback |
|---|---|---|
| Total Trades | 542 | 768 |
| Win Rate % | 26.01% | 32.94% |
| Profit Factor | 0.82 | 0.94 |
| Max Drawdown % | 61.89% | 28.92% |
| Net Profit $ | $-5.508,71 | $-2.572,55 |
| Sharpe Ratio | -1.22 | -0.33 |

Keduanya **rugi** pada konfigurasi dasar ini — output jujur, bukan bug.
Sinyal ≠ trade: sinyal muncul saat posisi masih terbuka di-skip
(1 posisi kapan saja), rinciannya di `BACKTEST_RESULTS.md`.

## Catatan

- Timestamp CSV dianggap **UTC** (window sesi Asia/London pakai UTC).
- Exit berjalan: hold sampai SL/TP; posisi terbuka di akhir data → ditutup (`EOD`).
- `XAU_1m_data.csv` (6,8 juta bar) tidak dipakai runner — 15m cukup untuk 2 strategi ini.
