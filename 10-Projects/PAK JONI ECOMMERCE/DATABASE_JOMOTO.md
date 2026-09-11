# DATABASE — JOMOTO CENTER

## DBMS
- MySQL via cPanel shared hosting.
- Nama database sesuai `.env` production (lihat `.env` server).

## Peringatan Skema
- **JANGAN jalankan `migrate:fresh` / `db:wipe` di production** — ada 38 migration & data customer nyata.
- Gunakan migration non-destruktif untuk perubahan skema.

## Migration Terkait Stok
| Migration | Fungsi |
|-----------|--------|
| `2026_08_06_071659_create_stock_mutations_table.php` | Tabel mutasi stok (batch 7) |
| `2026_08_06_144100_add_stock_to_item_colors_table.php` | Kolom `stock`, `stock_updated_at` di `item_colors` (batch 8) |

### Tabel `stock_mutations`
| Kolom | Tipe | Catatan |
|-------|------|---------|
| `id` | bigint PK | |
| `stockable_type` | string(100) | morph, **100 char** (agar index lolos MySQL) |
| `stockable_id` | bigint | morph |
| `quantity` | int | delta (bisa negatif) |
| `previous_stock` | int | |
| `current_stock` | int | |
| `type` | string | manual / order / restock / adjustment |
| `reference_type` | string|null | morph, misal Order |
| `reference_id` | bigint|null | |
| `notes` | text|null | |
| `user_id` | bigint|null | admin pengubah |
| `created_at`/`updated_at` | timestamp | |

### Perubahan `item_colors`
- `stock`
- `stock_updated_at`

## Model Data Utama
- `items` → `item_colors` (1:N, stok di level item_colors), relasi lanjut ke cart/order via polymorphic `itemable`.
- `parts` → `part_variants` (stok).
- `orders` → `order_items` (itemable polymorphic: ItemColor/PartVariant/Item/Part).
- `stock_mutations` polymorphic ke Item / ItemColor / PartVariant.

## Related
- [[PAK JONI ECOMMERCE]]
- [[STOCK_MANAGEMENT]]
- [[ARCHITECTURE_JOMOTO]]