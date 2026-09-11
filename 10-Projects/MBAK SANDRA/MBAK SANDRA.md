# MBAK SANDRA - FinTrack (Financial Management for Dapur)

## Overview
FinTrack adalah aplikasi manajemen keuangan komprehensif untuk unit Dapur (kitchen/catering) yang dikelola yayasan. Mencakup pencatatan transaksi, anggaran, inventori, kehadiran pegawai, dan pelaporan keuangan ala SPJ/LPJ pemerintahan. Project client: **Mbak Sandra**.

## Location
`/Users/10969sosho/PROJECT/MBAK SANDRA/frontend-fintrack/`

## Tech Stack
| Layer | Technology |
|-------|-----------|
| Backend | Laravel 12, PHP 8.2+ |
| Database | MySQL (`fintrack`) |
| Realtime | Livewire 4.2, Laravel Echo, Pusher |
| Permission | Spatie Laravel Permission 7.2 |
| Excel | Maatwebsite Excel |
| Frontend | Blade + Tailwind CSS v4 + Alpine.js 3.14 |
| Charts | ApexCharts 5, FullCalendar 6 |
| Plugins | Flatpickr, Swiper 12, jsVectorMap, PrismJS, Floating UI + Popper |
| Build | Vite 7 |

## Modules

### Authentication
- Login with username/password
- Super Admin: select Dapur or Main Kitchen mode

### Finance Management
- **Setup Anggaran**: 3 tabs (Bahan, Operasional, Insentif) with RAB totals
- **Awal Buku**: Initial balances per account
- **Transaksi**: CRUD with date, receipt number, description, debit, credit, account
- **Buku Kas Umum (BKU)**: Monthly report with running balance, CSV export
- **BP Kas/Operasional/Insentif**: Subsidiary ledgers
- **LP Anggaran**: Budget accountability report (SPJ-style)
- **SP Tanggung Jawab + BAP Sisa Dana**: Government-style documents
- **Catatan Pengeluaran**: Expense recap (raw materials, ops, incentives)

### Employee Management
- Employee CRUD with job relations
- Nominative list with attendance/incentive tracking

### Inventory Management
- Items CRUD (name, unit, supplier, initial stock)
- Stock-in (auto-increment)
- Stock-out (to employees, stock validation)
- Stock report (beginning/movement/ending balance) + Excel export
- Auto-notification if stock intake > Rp 5M in 12 days

### Super Admin
- Manage all Dapur (name, address, head, accountant, foundation)
- Kitchen users (1 user per kitchen)
- Period management (budget year, reporting dates)

## Models (22)
`User`, `Dapur`, `Periode`, `Akun`, `Transaksi`, `Jurnal`, `AnggaranBahan`, `DetailAnggaranBahan`, `AnggaranOperasional`, `AnggaranInsentif`, `Barang`, `StokBarang`, `StokAwal`, `BarangMasuk`, `BarangKeluar`, `PenerimaanBarang`, `PengeluaranBarang`, `Anggota`, `Pekerjaan`, `DaftarNominatif`, `KehadiranNominatif`, `Notification`

## Controllers (23)
`LoginController`, `DashboardController`, `AnggaranController`, `TransaksiController`, `BkuController`, `BpKasController`, `BpOperasionalController`, `BpInsentifController`, `LpAnggaranController`, `SpTanggungjawabController`, `BapSisadanaController`, `CatatanPengeluaranController`, `AwalBukuController`, `AnggotaController`, `DaftarNominatifController`, `InputBarangController`, `PenerimaanBarangController`, `PengeluaranBarangController`, `LaporanStockController`, `DapurController`, `KelolaDapurController`, `NotificationController`

## Documentation
- `PENJELASAN_PROJECT.md`
- `README.md`


## Related

- [[PROJECT INDEX]]
- [[Laravel]]
- [[Livewire]]
