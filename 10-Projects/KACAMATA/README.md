# KACAMATA — Toko Kacamata Management & Membership

Aplikasi manajemen toko kacamata & membership: POS/transaksi, master frame & lensa, resep, promo, laporan, plus portal member mobile-friendly.

Spesifikasi lengkap: `SPEC.md` di root repo.

## Stack
- Backend: **Laravel 13** (PHP 8.5), Blade + Tailwind CSS, ikon Tabler/Lucide
- DB: **SQLite** (`database/database.sqlite`), siap MySQL
- Testing: PHPUnit (`php artisan test --compact`)
- Style: `vendor/bin/pint app database`
- Path repo: `PROJECTS/finance/PROJECT/PROJECT ANTIGRAVITY/KACAMATA`

## Struktur Database (11 tabel)
`stores`, `users` (role admin/staff/customer), `customers` (member_id KCM-XXXXXX),
`product_categories` (frame/lens/accessory), `frames`, `lenses`, `prescriptions` (OD/OS),
`promotions`, `transactions`, `transaction_items`, `payments`.

## Models (`app/Models`)
`Store`, `User`, `Customer`, `ProductCategory`, `Frame`, `Lens`, `Prescription`,
`Promotion`, `Transaction`, `TransactionItem`, `Payment`.

Helper penting:
- `User::isAdmin() / isStaff() / isCustomer()`
- `Customer::latestPrescription() / totalSpend() / totalOrders()` — spend & order **mengabaikan** status `cancelled`/`refunded`
- `Frame::isLowStock()`, `Lens::isLowStock()` — `stock <= min_stock`
- `Promotion::active()` (scope: `is_active` + rentang `start_date`/`end_date` nullable)
- `Transaction::amountPaid() / balanceDue()` — DP-aware

## Progress
- [x] Langkah 1 — Migrations (13 file, sukses).
- [x] Langkah 2 — Seluruh Eloquent Model + relasi/casts/helper + `DatabaseSeeder` komprehensif (`php artisan migrate:fresh --seed` **exit 0**).
- [ ] Langkah 3 — Auth & multi-role (admin/staff/customer + OTP WA).
- [ ] Langkah 4 — Controllers, routes, UI POS & dashboard.

## Akun Seeder (password semua: `password`)
| Email / Phone | Role | Store |
|---|---|---|
| admin@optik.com / 081234567890 | admin | — |
| staff@optik.com / 081234567891 | staff | Kacamata Optik Pusat |
| budi@gmail.com / 081298765432 | customer | — |

## Data Seed
- **Stores**: Kacamata Optik Pusat (Jakarta), Kacamata Optik Cabang Selatan (Bandung)
- **Customers**: KCM-000012 Budi Santoso, KCM-000013 Siti Rahma, KCM-000014 Hendra Wijaya, KCM-000015 Maya Anggraini
- **Kategori**: Frame Kacamata, Lensa Single Vision, Lensa Progresif, Lensa Blue Light, Aksesoris
- **Frames (5)**: Ray-Ban Aviator Classic, Ray-Ban Wayfarer, Oakley Holbrook, Gentle Monster South Side (low stock 3/5), Gucci Square (low stock 2/5)
- **Lenses (5)**: Essilor Crizal Easy Pro, Essilor Eyezen (low stock 4/10), Hoya Hilux Stellify, Zeiss DriveSafe Progressive, Rodenstock ColorMatic Sun
- **Resep (2)**: Budi (Dr. Robert Sp.M), Siti (Optometris Dian)
- **Promo (3)**: Diskon Merdeka 15%, Potongan Frame Rp 150.000, Promo Khusus Member VIP
- **Transaksi (3)**: `TRX-20260920-00123` completed/paid/transfer Rp 3.400.000 · `TRX-20260925-00145` processing/down_payment QRIS DP Rp 5.000.000 dari Rp 8.450.000 · `TRX-20260926-00150` ready/paid/cash Rp 2.900.000

## Perintah Kunci
```bash
php artisan migrate:fresh --seed   # exit 0
php artisan test --compact
vendor/bin/pint app database
```

## Backup Pattern
- DB: `database/database.sqlite.bak_<tanggal>_<label>`
- File: `<file>.bak_<tanggal>_<label>`
