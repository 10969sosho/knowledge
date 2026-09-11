# PTPAS Features

## Home Page
- **Hero Banner Carousel**: Menampilkan semua broadcast sebagai carousel (auto-slide 3 detik)
- **Produk Terlaris**: Section produk dengan `status_product` mengandung "TERLARIS"
- **Produk Terbaru**: Section produk dengan `status_product` mengandung "TERBARU"
- **Product Status Sections**: Section produk berdasarkan ProductStatus lain (selain terlaris/terbaru)
- **Kategori**: Grid kategori produk dengan icon

## Cart System
- **Live Update**: Summary & badge diupdate tanpa refresh halaman
- **6-Digit Quantity**: Max quantity 999.999 per item
- **Per-Item Notes**: Catatan per produk yang tersimpan & ditampilkan di order detail + email
- **Cart Badge**: Menampilkan unique product line count (bukan total quantity)
- **Draft Order**: Sales bisa simpan cart sebagai draft
- **Customer Selection**: Sales pilih customer untuk keranjang
- **Address Selection**: Pilih alamat pengiriman saat checkout

## Product Management
- **Product Status**: Field `status_product` untuk menandai TERLARIS/TERBARU
- **Sort Order**: Field `no_urut_status` untuk urutan tampil di home
- **Featured Products Admin**: CRUD produk terlaris
- **New Products Admin**: CRUD produk terbaru
- **Pricing Tiers**: 3 level harga berdasarkan quantity

## Sales Order
- **Status Flow**: new → on_progress → on_delivery → finished (forward-only)
- **Item Notes**: Catatan per item ditampilkan di detail order & email
- **Remote Stock Display**: Stok real-time dari SQL Server ditampilkan di detail order admin
- **Order Number Format**: W + YYMMDD + 4 digit urutan (reset per hari)

## Remote Stock Service
- **Connection**: SQL Server 2005 via PDO (dblib/sqlsrv)
- **Server**: ptpasonline.dyndns.org:1699
- **Database**: EzSystem
- **View**: vwtotalqtystock (stockid, totalqty)
- **Methods**:
  - `getStockBySku(string $sku)`: Cek stok 1 produk
  - `getStockBatch(array $skus)`: Cek stok multiple produk
  - `testConnection()`: Test koneksi
- **Timeout**: 10 detik
- **Fallback**: Return null/empty jika koneksi gagal

## Authentication
- **Dual Guard**: `web` untuk admin/sales, `customer` untuk buyer
- **Email Verification**: Kode 6 digit untuk buyer baru
- **Change Password**: Verifikasi email wajib
- **Sales-Customer Relationship**: Customer memiliki `sales_id` yang merujuk ke Sales yang mendaftarkannya

## Customer Management
- **Registration**: Hanya oleh Sales/Admin (tidak ada self-register)
- **Account Status**: pending → active (approval required)
- **Address Management**: Multiple addresses per customer, active address selection
- **My Customers (Sales)**: Sales bisa kelola customer mereka sendiri

## API (Guest)
- **Sync**: Polling endpoint untuk cek perubahan data
- **Home**: Data untuk halaman utama (categories, brands, broadcasts, featured products)
- **Products**: List & detail produk dengan pagination
- **Create Order**: Guest bisa buat order via API


## Related

- [[CVSS/PTPAS/PTPAS]]
- [[CVSS/CVSS]]
- [[Laravel]]
