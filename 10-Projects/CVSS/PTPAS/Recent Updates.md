# PTPAS Recent Updates

## Guest UI Continuation — Splash, Auth, Product Detail
Melanjutkan arah visual **Trading Floor** ke seluruh area guest:
- **Design tokens global**: blok `--hp-*` dipindah dari `.home-page` ke `:root`, Space Grotesk dimuat di layout (tidak lagi hanya home).
- **PAS Splash**: overlay branded navy-gradient saat initial page load (mark `PAS` + dot amber pulsing + progress bar), fade-out saat `window.load`, mendukung `prefers-reduced-motion`.
- **Login & Register desktop** = **split-screen**: panel kiri navy (brand, headline, bullet points, stats) + panel kanan kartu form; `body[data-spa="false"] .desktop-header` disembunyikan.
- **Auth-card bersama** (register-buyer/verify-email/change-password) dipoles otomatis via `.login-page .auth-card`.
- **Detail produk** di-redesign (class `pd-page`): image card + badge "PAS Official", harga block, tier pricing list, spec grid, stepper qty, tombol navy, benefit chips.
- **Catatan**: route `/register` masih belum ada (pre-existing) — `register.blade.php` sudah di-redesign & siap dipasang; buyer dibuat via `/register-buyer`.

File: `resources/views/guest/layouts/app.blade.php`, `guest/auth/login.blade.php`, `guest/auth/register.blade.php`, `guest/products/show.blade.php`, `public/guest/css/app.css`, `public/guest/css/auth.css`. Testing: `25 passed, 8 failed` (baseline, tidak ada regresi).

**Hero home = banner statis**: `bannerrrrr.png` (root `backend/`, di-gitignore; salinan di `public/guest/img/`) **menggantikan hero carousel broadcast** (`#heroCarousel` dihapus). Media memakai bingkai dengan **max-height** `clamp(180px,46vw,460px)` + `object-fit:cover` supaya tidak kepanjangan, chip brand tetap overlay, lazy load + fallback.

## Guest Home Redesign — "Trading Floor"
Redesign halaman `guest/home` dengan arah visual **Trading Floor** (navy-ledger `#003366` + amber `#f59e0b`, display font Space Grotesk). Signature: *market ticker* marquee kategori di bawah hero (linear, pause on hover, loop seamless via JS). Motion mengikuti prinsip Apple fluid + animation best practices: reveal on scroll (IntersectionObserver), feedback tekan `scale(0.97)`, hover lift hanya di pointer fine, carousel crossfade, semua mendukung `prefers-reduced-motion`. Behavior fix: **kategori home kini grid responsif non-slide** (5 kolom desktop / 4 tablet / 3 mobile, kartu lebih besar + tile "Lihat Semua" ke `/categories`); form newsletter diperbaiki (sebelumnya salah target form). Scope CSS dibatasi `.home-page`, file: `resources/views/guest/home.blade.php`, `public/guest/css/app.css`.

## Order Email Recipient Isolation
Email order sekarang dikirim sebagai pesan terpisah untuk setiap customer, sales, dan **semua user admin/super admin** dari database (plus alamat ekstra `ADMIN_EMAIL`). Alamat dummy (domain `.local` seperti `admin@pas.local`) otomatis di-skip; kegagalan satu alamat tidak menghentikan pengiriman ke penerima lain.

## Latest Pull (Commit 8e4516f)
**Date**: 2026-08-07

### Commits Included
1. `8e4516f` - feat: cart badge and item labels show unique product line count
2. `ca3fa1d` - feat: support 6-digit product quantity and live-update cart summary/badge without refresh
3. `0447f76` - feat: display per-product item notes on order details and email; hide unused process/order-level fields
4. `31c6b6a` - feat: unify featured/new products with product status to avoid duplicate home sections
5. `b90cfe3` - fix: use product as route param in new-products edit form
6. `08025ca` - fix: restore RemoteStockService that was removed but still referenced by order controllers
7. `0d6a3ce` - feat: make home hero banner a carousel of all broadcasts
8. `fb7a1ff` - fix: show all products in new products admin
9. `5901b3f` - feat: manage home products banners and cart badge

### Files Changed (19 files)
**New Files:**
- `app/Services/RemoteStockService.php` - Service untuk koneksi ke remote SQL Server

**Updated Controllers:**
- `app/Http/Controllers/Admin/FeaturedProductController.php`
- `app/Http/Controllers/Admin/NewProductController.php`
- `app/Http/Controllers/Api/Guest/GuestOrderApiController.php`
- `app/Http/Controllers/Guest/CartController.php`

**Updated Views:**
- `resources/views/admin/featured-products/edit.blade.php`
- `resources/views/admin/featured-products/index.blade.php`
- `resources/views/admin/new-products/edit.blade.php`
- `resources/views/admin/new-products/index.blade.php`
- `resources/views/admin/sales-orders/show.blade.php`
- `resources/views/emails/sales-order-created.blade.php`
- `resources/views/guest/cart/index.blade.php`
- `resources/views/guest/home.blade.php`
- `resources/views/guest/orders/show.blade.php`
- `resources/views/guest/partials/product-card-item.blade.php`
- `resources/views/guest/products/show.blade.php`

**Updated JS:**
- `public/guest/js/app.js`
- `public/guest/js/products.js`

**Updated Routes:**
- `routes/guest.php`

### Key Changes
1. **Cart Badge**: Sekarang menampilkan unique product line count, bukan total quantity
2. **6-Digit Quantity**: Max quantity ditingkatkan ke 999.999
3. **Live Update**: Cart summary & badge update tanpa refresh halaman
4. **Per-Item Notes**: Catatan per produk ditampilkan di order detail & email
5. **Home Carousel**: Hero banner sekarang carousel dari semua broadcast
6. **Product Status Unification**: Featured/New products menggunakan `status_product` field
7. **Remote Stock Service**: Service di-restore setelah sempat dihapus

### Database Migrations
- `2026_07_21_000001_add_notes_to_cart_items_table.php` - Tambah `notes` di cart_items
- `2026_08_05_100948_add_notes_to_sales_order_items_table.php` - Tambah `notes` di sales_order_items

### Documentation Updates
Semua project docs sudah di-sinkronkan:
- ARCHITECTURE.md - Tambah RemoteStockService, update folder structure
- API_REFERENCE.md - Tambah route baru
- CHANGELOG.md - Catat fitur baru
- PROJECT_CONTEXT.md - Update modul & deskripsi
- BUSINESS_RULES.md - Update cart rules
- DATABASE.md - Tambah notes fields, product_statuses table


## Related

- [[CVSS/PTPAS/PTPAS]]
- [[CVSS/CVSS]]
