# PTPAS - Product Sales System



## Overview
**PTPAS** (Pak Effendi Product Sales System) adalah sistem penjualan produk untuk **CV Sumber Sejahtera**. Sistem ini memungkinkan buyer (customer) browsing produk, keranjang, checkout, dan melihat riwayat order, serta sales membuatkan order untuk buyer.

## Location
HP clone: `/root/projects/pakeffendi-ptpas/`

## Tech Stack
- **Backend**: Laravel 12, PHP ^8.2
- **Frontend**: Blade templates + Bootstrap + Vite
- **Database**: MySQL
- **Auth**: Session-based (2 guards: `web`, `customer`)
- **Mail**: Laravel Mail (SMTP)
- **External Integration**: Remote SQL Server 2005 (stock checking)

## User Roles
| Role | Guard | Area Akses | Login Route |
|------|-------|------------|-------------|
| Admin | `web` | Panel admin (`/admin/*`) | `/admin/login` |
| Super Admin | `web` | Panel admin (`/admin/*`) | `/admin/login` |
| Sales | `web` | Guest area (cart, profile, orders) | `/login` |
| Buyer | `customer` | Guest area (cart, profile, orders) | `/login` |
| Guest | — | Browse produk saja | — |

## Main Modules
1. **Authentication** - Multi-guard login (Buyer via `customer` guard, Sales/Admin via `web` guard)
2. **Product Management** - CRUD produk, brand, kategori, status, varian
3. **Featured/New Products** - Kelola produk terlaris & terbaru via `status_product` field
4. **Cart & Checkout** - Keranjang berbasis session/customer, merge cart, tier pricing, per-item notes
5. **Sales Order** - Order dari buyer, update status (new → on_progress → on_delivery → finished)
6. **Customer/Buyer** - Registrasi buyer oleh Sales/Admin, approval, manajemen alamat
7. **Broadcast** - Banner/pengumuman di halaman utama (carousel hero)
8. **Remote Stock** - Cek stok real-time dari remote SQL Server
9. **Activity Log** - Log aktivitas admin

## Key Features
- **Home Page**: Hero banner carousel dari semua broadcast, section produk berdasarkan ProductStatus
- **Cart**: Live update summary & badge tanpa refresh, per-item notes, 6-digit quantity (max 999.999)
- **Sales Order**: Per-product item notes ditampilkan di detail order & email notifikasi
- **Remote Stock**: Koneksi ke remote SQL Server untuk cek stok real-time di halaman admin
- **Product Status**: Featured/New products menggunakan field `status_product` (TERLARIS/TERBARU)

## Documentation
- **Project Docs**: `docs/` folder di backend (7 files: PROJECT_CONTEXT, ARCHITECTURE, BUSINESS_RULES, CODING_STANDARDS, DATABASE, API_REFERENCE, CHANGELOG)
- **AGENTS.md**: Standard operating procedure untuk AI

## Related
- [[CVSS]]
- [[Laravel]]
- [[Authentication]]
