# DEMO — Features

> Ringkasan. Detail lengkap: `docs/FEATURES.md` di repo (section bercorak sama).

## 1. Auth & Role
- Register (auto-cart), login, logout, me — Sanctum Bearer token.
- Role: `buyer` (default) / `admin`. Guard admin API: `AdminMiddleware.php` → 403 non-admin.
- Akun seeder: `admin@coffeeshop.com` / `buyer@coffeeshop.com` (password: `password`).

## 2. Katalog
- Produk: list (filter category_id, search, paginasi 12), detail by slug, `scopeActive`.
- Kategori: list + products_count, detail by slug.
- UI: homepage hero coffee (CSS machine/bag/kettle/pour-over) + kategori populer + produk unggulan + fly-to-cart animation + trust strip; halaman produk dengan filter & paginasi; detail dengan stepper qty + stok live. Tema espresso/caramel/cream, heading `font-display`.

## 3. Keranjang (server-side)
- `/cart` GET | `/cart/add` (increment jika ada) | `/cart/{id}` PUT (qty<1 → hapus) | DELETE | `/cart` DELETE clear.
- Cart otomatis dibuat utk user; state zustand `store/cart.ts` dengan selector `itemCount()`, `total()`.

## 4. Checkout & Alamat 1x
- Dropdown wilayah 4 level Kemendagri (Provinsi → Kab/Kota → Kecamatan → Kelurahan) via `/api/wilayah/*`.
- `users.default_address` (JSON) = alamat tersimpan di profil; checkout auto-fill + cascade fetch + auto ongkir.
- Guard `appliedDefaultRef` (StrictMode-safe, tanda di-set setelah chain selesai).
- Validasi: shipping_address + courier/service/cost wajib; pesan "Mohon lengkapi alamat pengiriman."

## 5. Shipping / Ongkir
- `/api/shipping/rates` (Biteship proxy) + `/api/shipping/track/{awb}/{courier}`.
- Berat = Σ(qty×weight). `origin_area_id` dari config `BITESHIP_ORIGIN_AREA_ID`; destination Biteship area ID di-resolve dari kode pos (cache 24 jam); request memuat `items[]`. Fallback hardcoded (JNE REG 25k, YES 45k, TIKI REG 22k, POS Kilat 20k) + badge "Estimasi".
- **Ongkir dibutuhkan dari client** (server hanya percaya nilai kiriman).

## 6. Order
- Nomor `ORD-{uniqid}` (unique, juga `midtrans_order_id`).
- Status: `pending → paid → processing → shipped → delivered` / `cancelled`.
- payment_status: `pending/success/failed/expired`.
- Flow store: cek cart → simpan alamat → hitung subtotal+shipping → snapshot items + decrement stock → kosongkan cart → generate Midtrans Snap token.

## 7. Pembayaran (Midtrans Snap)
- `/payment/{order}` memuat snap.js sandbox; simulasikan via tombol "Simulasi Pembayaran Berhasil".
- Callback `/api/midtrans/callback` (public): settlement/capture → paid; deny/cancel/expire → failed; refund → cancelled.

## 8. Tracking AWB
- Admin wajib isi nomor resi saat status → `shipped` (422 jika kosong, pesan: "Nomor resi wajib diisi saat status menjadi shipped.").
- Buyer lihat badge AWB + "Lacak dengan Google" (google search by AWB).

## 9. Admin Panel (/admin)
- Dashboard: Total Products/Orders/Revenue, orders_by_status, recent orders.
- Products: table + toggle is_active + SlideOver create/edit (multipart), delete.
- Categories: CRUD SlideOver.
- Orders: filter status, inline status change, SlideOver detail, input AWB (oranye) saat shipped.

## Related
- [[DEMO]]
- [[Next.js]]
- [[Laravel]]