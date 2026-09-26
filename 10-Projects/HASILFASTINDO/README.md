# HASIL FASTINDO — ERP WMS

Sistem Warehouse Management System (WMS) & pengiriman untuk Toko **HASIL FASTINDO** (fastener: baut, mur, skrup), berbasis **Laravel 12 + PHP 8.5 + SQLite**.

Spesifikasi lengkap: `WMS_REQUIREMENTS.md` di root repo.

## Stack
- Backend: Laravel (Blade / Inertia tergantung tahap), PHP 8.5
- DB: SQLite (`database/database.sqlite`)
- Testing: PHPUnit (`php artisan test --compact`)
- Style: `vendor/bin/pint app database`

## Modul
Master: Branch, Warehouse, Location (BIN CODE), Uom, Category, Item, ItemUomConversion (KRT/DUS/PCS), Supplier, Customer, Vehicle, Driver.
Transaksi: Stock & StockMovement (kardeks), GoodsReceipt (inbound + barcode), Putaway, SalesOrder (cross-cabang), StockTransfer, StockRepack, Picking/PackingList (box barcode), Delivery (scan out + tracking), StockOpname, Monitoring stok pusat.

## Progress
- [x] Langkah 1 — Migration (13 migration, sukses).
- [x] Langkah 2 — Seluruh Eloquent Model + relasi + helper stok/FIFO + `DatabaseSeeder` komprehensif (`php artisan db:seed` exit 0).
- [ ] Langkah 3 — Controllers / routes / UI.

## Akun Seeder (password semua: `password`)
| Email | Role |
|---|---|
| superadmin@hasilfastindo.com | super_admin |
| pusat@hasilfastindo.com | central |
| cabang.sby@hasilfastindo.com | branch_staff (SBY) |
| cabang.jkt@hasilfastindo.com | branch_staff (JKT) |
| cabang.smg@hasilfastindo.com | branch_staff (SMG) |

## Data Seed
3 cabang (SBY/JKT pusat/SMG), 3 gudang, 24 BIN code, 6 UOM, 4 kategori, **100 item**, 300 konversi, 205 batch, 153 stok, 161 mutasi, 4 supplier, 6 customer, 4 armada (Truk & Gran Max), 4 driver/helper, plus transaksi aktif tiap modul (GR, SO, Transfer, Repack, Packing, Delivery, Opname).

## Perintah Kunci
```bash
php artisan migrate
php artisan db:seed      # idempoten, boleh diulang
php artisan test --compact
vendor/bin/pint app database
```
