# HOW TO HOSTING & DEPLOYMENT — CMC_TRADER

## 1. Spesifikasi Environment
- **Server**: Belum dideploy
- **Domain / URL**: Belum ada
- **Path di Server**: Belum ada
- **Python Version**: Python 3.12

## 2. Port & Service
- **Port Internal**: Tidak ada untuk CLI
- **Process Manager**: Belum ada
- **Database**: SQLite lokal di `database/trading.db`

## 3. Langkah Deployment Step-by-Step
### A. Build dan install
```bash
cd "/Users/10969sosho/PROJECTS/finance/PROJECT/PROJECT ANTIGRAVITY/CMC_TRADER"
python3.12 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
cp .env.example .env
```

Isi `CMC_API_KEY` sebelum menjalankan screener. Isi credential Binance hanya jika fitur data/order diperlukan.

### B. Verifikasi aman
```bash
pytest tests/ -v
python main.py --mode paper
python main.py --mode screener
```

Jangan menjalankan `python main.py --mode live` sebelum konfigurasi dan paper trading diverifikasi.

## 4. Troubleshooting & Catatan Khusus
- Requirements yang didokumentasikan berhasil pada Python 3.12. Python 3.14 gagal membangun `pandas==2.1.4`.
- `PortfolioTracker` harus menginisialisasi schema melalui `PaperTrader`; perbaikan ini sudah diterapkan.
- `BreakoutStrategy` harus menghitung `roll_low` sebelum membaca candle terakhir; perbaikan ini sudah diterapkan.
- `--mode screener` tanpa `CMC_API_KEY` memang berhenti dengan `ValueError`.
