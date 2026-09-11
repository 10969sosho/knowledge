# BUGS & FIX — JOMOTO

Catatan bug yang ditemukan & diperbaiki (terutama saat implementasi stock management).

## 1. Halaman Admin 500 — Class `Filament\Tables\Actions\Action` not found
- **Symptom**: Admin page error `Class "Filament\Tables\Actions\Action" not found`.
- **Root cause**: Pada Filament v4, namespace header action yang benar adalah `Filament\Actions\Action` (bukan `Filament\Tables\Actions\Action`).
- **Fix**: Gunakan `\Filament\Actions\Action` di `ItemResource.php`.
- **Commit**: `cfb516e4 fix: use correct Filament v4 Action namespace`.

## 2. `composer install` error di server (platform / php)
- **Symptom**: composer install gagal di server karena platform override & versi PHP.
- **Root cause**: `composer.json` memakai `platform.php 8.2.99` dan requirement `"php": "^8.2"`; server pakai PHP 8.4.
- **Fix**: Hapus override `platform.php`; ubah `"php": "^8.2"` → `"^8.3"`; jalankan `composer update --lock`; push; composer install berhasil di server.
- **Commit**: `5fb578cb fix: remove platform.php override and update PHP requirement to ^8.3`.

## 3. MySQL index key length error (migration stock_mutations)
- **Symptom**: migration `stock_mutations` gagal dengan index key too long.
- **Root cause**: kolom morphs menghasilkan VARCHAR(255) panjang → melebihi batas index MySQL (InnoDB).
- **Fix**: gunakan `string('stockable_type', 100)` eksplisit (bukan `morphs`).
- **Commit**: `b96ac4d8 fix: use shorter string length for stockable_type`.

## 4. `deploy.sh` gagal karena `rsync` tidak terpasang di server
- **Symptom**: deployment error karena `rsync: command not found` (server tidak punya rsync).
- **Fix**: rewrite `deploy.sh` — ganti rsync dengan `git fetch + git reset --hard origin/main` lalu copy via `cp -r` per folder app/bootstrap/config/database/public/resources/routes + file artisan/composer/lock.
- **Commit**: `cf8440b9 fix: replace rsync with cp in deploy.sh`.

## 5. Deployment tar/scp pipe write error (terdahulu)
- **Symptom**: `tar` write error saat pipe.
- **Fix**: gunakan local tar + lalu `scp` file (bukan pipe langsung).
- **Commit**: `e70ad240 fix(deploy): use local tar + scp instead of pipe`.

## 6. Stok tidak berkurang setelah checkout (customer/Midtrans)
- **Symptom**: Order sudah `paid` via pembayaran customer, tetapi stok varian (`item_colors.stock` / `part_variants.stock`) tidak berkurang.
- **Root cause**: `OrderService::markAsPaid` (yang memicu `StockService::decreaseStockOnOrder`) hanya dipanggil dari jalur admin (Filament `OrderResource`, `Admin/OrderController`). Jalur pembayaran customer — `PaymentService::markPaymentSuccess`, `simulateSuccessPayment`, `checkStatusFromMidtrans`, dan `Buyer/OrderController::payRemaining` — menandai order `paid` langsung tanpa menurunkan stok. Selain itu `CheckoutController::placeOrder` memotong stok `PartVariant` secara parsial (tanpa `StockMutation`, dan mengabaikan `ItemColor`), tidak konsisten dengan business rule "decrease saat paid".
- **Fix**: semua transisi ke `paid` dipusatkan lewat `OrderService::markAsPaid(order, extra)` (extra untuk field payment). Hapus dekrement parsial di `placeOrder`. Hapus `returnStock` pada order expired (tidak relevan lagi). Perbarui test `CartCheckoutTest` agar stok berkurang hanya saat paid.
- **File**: `app/Services/OrderService.php`, `app/Services/PaymentService.php`, `app/Http/Controllers/Buyer/OrderController.php`, `app/Http/Controllers/Buyer/CheckoutController.php`, `tests/Feature/CartCheckoutTest.php`.

## Related
- [[PAK JONI ECOMMERCE]]
- [[DEPLOYMENT_JOMOTO]]
- [[STOCK_MANAGEMENT]]