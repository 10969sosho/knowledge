# PROGRES & FEATURES — JOMOTO CENTER

Log perkembangan fitur & status proyek. Update nota ini setelah tugas/proyek selesai.

## Status Keseluruhan
- **Status**: On progress, production aktif di jomotocenter.com.
- **Last deployed commit**: `6cfb2219` (stock management variant-level).
- **Branch**: `main`.

## Timeline / Changelog Utama
| Tanggal | Commit | Deskripsi |
|---------|--------|-----------|
| ... | `b02bbba9` | Fix dynamic Midtrans Snap.js URL, mobile landscape hero video |
| ... | `e70ad240` | Deploy: tar + scp local |
| ... | `3b925a8a` | Home: revert icon/tombol ke hijau, teks angka & deskripsi hitam |
| ... | `3ead03bc` | Fix: auto-polling payment status setelah Midtrans |
| ... | `3e553630` | **feat(stock):** implement motor stock management + mutation tracking |
| ... | `b96ac4d8` | Fix: shorten stockable_type untuk MySQL index |
| ... | `5fb578cb` | Fix: tanpa platform.php override, PHP ^8.3 |
| ... | `e6810d00`/`cf8440b9` | Refactor deploy.sh (git pull + cp, tanpa rsync) |
| **2026-08-06** | `6cfb2219` | **feat: move stock ke variant level (color variants for motors)** |

## Daftar Fitur (Feature List)
### Storefront
- Halaman: home, daftar motor, detail motor, part, kategori/brand, cart, wishlist, checkout, order, quotation request, career, news, contact, showroom, maps.
- Pencarian & filter kategori.
- Hero video, banner, promo.

### Admin (Filament v4)
- 30+ resources: Item, Part, Category, Brand, Order, Banner, Event, News, Career, Dealer, HeroVideo, MapsLocation, ShowroomGallery, StoreAddress, WhyChooseUs, PriceList, PartCatalog, CategoryType, dll.
- **Kelola stok per varian (modal)** untuk Item.
- Manajemen order (status lifecycle: pending → processing → shipped → completed; cancellable).

### E-commerce / Order
- Keranjang polymorphic (Item/ItemColor/Part/PartVariant).
- Checkout + Midtrans payment (Snap.js) + auto-poll status.
- Pengiriman via Biteship.
- Indent / wait_stock untuk part.

### Stok
- Stok varian-level + riwayat mutasi + auto-decrease saat paid. (Lihat [[STOCK_MANAGEMENT]])

## Verifikasi Selesai (per sesi terakhir)
- [x] Migration stock & item_colors running di prod.
- [x] File terdeploy (ItemResource, StockService, OrderService, modal) timestamp sesuai commit `6cfb2219`.
- [x] Prod pages 200, tidak ada error di laravel.log.
- [x] Sistem stok varian-level aktif di production.

## TODO / Next
- [ ] Verifikasi end-to-end testing variant-level stok di admin motor/ATV (index/create/edit, modal stok) di browser.
- [ ] (opsional) fix tampilan stok di `category-brand.blade.php` (cek penulisan stok varian).

## Related
- [[PAK JONI ECOMMERCE]]
- [[STOCK_MANAGEMENT]]
- [[ARCHITECTURE_JOMOTO]]