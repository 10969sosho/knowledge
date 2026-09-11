# STOCK MANAGEMENT — Variant Level

## Ringkasan
Stok dikelola pada **unit terkecil (varian/warna)**, bukan pada produk utama. Berlaku generik untuk semua kategori (motor, mobil, ATV, part) melalui mekanisme morfisme. Stok otomatis berkurang ketika order berstatus **paid**. Semua perubahan stok dicatat sebagai riwayat mutasi (mutation history).

## Model / Skema
Kolom stok ditambahkan ke `item_colors`:
- `stock` (integer)
- `stock_updated_at` (datetime)

Migration: `2026_08_06_144100_add_stock_to_item_colors_table.php`

Hanya `ItemColor` yang mendukung stok per varian. `Item` dan `PartVariant` juga bisa dijadikan stockable (untuk item yang tidak punya varian warna).

## Model Utama
### ItemColor
`fillable` menambah `stock` & `stock_updated_at`; cast `stock => integer`, `stock_updated_at => datetime`; relasi `stockMutations()` polymorphic.
`app/Models/ItemColor.php`

### StockMutation
Tabel `stock_mutations` (created 2026_08_06_071659). Kolom:
- `stockable_type`, `stockable_id` (polymorphic 100 char — penting agar lolos batas index MySQL)
- `quantity` (berlaku delta, bisa negatif)
- `previous_stock`, `current_stock`
- `type` (manual, order, restock, adjustment)
- `reference_type`, `reference_id` (morphTo, misal menghubungkan ke Order)
- `notes`, `user_id`
Relasi: `stockable()` MorphTo, `reference()` MorphTo, `user()` BelongsTo.

Helper: `isIncoming()` (qty>0), `isOutgoing()` (qty<0), `typeLabel()`.
`app/Models/StockMutation.php`

## Service
### StockService — `app/Services/StockService.php`
Terpusat semua operasi stok:
| Method | Fungsi |
|--------|--------|
| `adjustStock(stockable, quantity, type, notes, ref)` | Ubah stok dengan delta; catat mutasi; lempar `InvalidArgumentException` jika hasil negatif |
| `setStock(stockable, newStock, notes)` | Set absolut → hitung delta → `adjustStock` |
| `getCurrentStock(stockable)` | Baca stok saat ini (Item/ItemColor/PartVariant) |
| `updateStock(stockable, newStock)` | Update kolom + `stock_updated_at = now()` |
| `getMutationHistory(stockable, limit)` | Riwayat mutasi + user, orderBy desc |
| `decreaseStockOnOrder(stockable, qty, orderId)` | `adjustStock` negatif type `order`, ref ke order |

Tidak bisa dibiarkan negatif → semua perubahan dicek di transaction.

### OrderService — `app/Services/OrderService.php`
- `markAsPaid(order)` → update status `paid` + `payment_status=paid`, lalu memanggil `decreaseStockOnOrder`.
- `decreaseStockOnOrder()` loop `order->items`, jika `itemable_type = ItemColor` atau `PartVariant`, panggil `stockService->decreaseStockOnOrder`, error `InvalidArgumentException` ditangkap + `report()` (tidak menghentikan order).

## Admin (Filament)
### ItemResource — `app/Filament/Resources/ItemResource.php`
- Table: kolom `total_stock` = `colors->sum('stock')`, kolom `stock_status` badge.
- Action **"Kelola Stok"** (`manage_stock`): membuka modal `filament.modals.item-stock-management` untuk kelola stok per varian.
- Form: input stok dipindah ke dalam `Repeater('colors')` per varian (TextInput `stock`).

Modal: `resources/views/filament/modals/item-stock-management.blade.php`

## Frontend (Storefront)
- `app/Http/Controllers/Buyer/MotorController.php`: eager-load `colors` di index; ikut pada related items.
- `resources/views/buyer/motors/index.blade.php` & `show.blade.php`: tampilkan stok per varian & total; badge stok dinamis; tombol add-to-cart disable saat varian belum dipilih.
- `resources/views/buyer/category-brand.blade.php`: tampilkan stok varian pada kategori.

## Alur (Flow)
### Penyesuaian Manual oleh Admin
1. Admin edit Item → set stok per varian warna di Repeater.
2. `StockService::adjustStock` dijalankan → update `stock` + `stock_updated_at`.
3. `StockMutation` baru dicatat dengan `type=manual`, `user_id` = admin.
4. Frontend menampilkan total & status stok.

### Auto-decrease saat Order dibayar
1. Customer checkout → order dibuat (stok **belum** dikurangi).
2. Payment (Midtrans) sukses / admin menandai paid → **wajib lewat `OrderService::markAsPaid(order)`**.
3. `decreaseStockOnOrder` loop item.
4. Untuk tiap ItemColor/PartVariant → stok dikurangi sebesar `quantity`, `StockMutation` type `order` dicatat dengan reference order.
5. Stok negatif tidak mungkin (dicegah StockService), jika gagal → `report()` tanpa menggagalkan order.

> **PENTING (v1.3.1):** Semua jalur yang menandai order `paid` harus lewat `OrderService::markAsPaid` agar stok & mutasi selalu tercatat:
> - Admin: `Filament/OrderResource` + `Admin/OrderController`.
> - Customer: `PaymentService::markPaymentSuccess` (webhook), `simulateSuccessPayment`, `checkStatusFromMidtrans`, dan `Buyer/OrderController::payRemaining`.
> Jangan pernah mengubah `orders.status` menjadi `paid` langsung di tempat lain tanpa memanggil `markAsPaid` (sebelumnya bug: stok tak pernah berkurang setelah checkout). Stok TIDAK dikurangi di `CheckoutController::placeOrder`.

## Verifikasi
- Migrations running di prod: `stock_mutations` (batch 7), `add_stock_to_item_colors` (batch 8).
- Prod pages admin & storefront return 200, tidak ada error di log.

## Related
- [[PAK JONI ECOMMERCE]]
- [[DEPLOYMENT_JOMOTO]]
- [[BUGS_JOMOTO]]
- [[ARCHITECTURE_JOMOTO]]