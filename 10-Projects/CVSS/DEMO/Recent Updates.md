# DEMO — Recent Updates

## 2026-08-10 — Rebrand & tema coffee (buyer-facing)
- **Rebrand**: HardwareShop → **CoffeeShop** (espresso `#2f1b13`, caramel `#d49a55`, cream `#fbf6ef`).
- **Seeder**: akun `admin@coffeeshop.com` / `buyer@coffeeshop.com`; 10 kategori + 32 produk kopi/brewing gear; `default_address` demo = Surabaya (Wonokromo 60243, kode Kemendagri lengkap).
- **Frontend buyer**: navbar (utility bar + katalog kopi), footer, brand, homepage (hero CSS coffee machine/bag/kettle/pour-over + kategori rail + trust strip + koleksi), katalog produk, detail produk, cart, checkout, profile, orders — semua palet coffee; heading `font-display` (Georgia/serif).
- **Shipping**: `origin_area_id` kini dari config `BITESHIP_ORIGIN_AREA_ID` (Gambir, Jakarta); destination Biteship area ID di-resolve dari kode pos via `/v1/maps/areas` (cache 24 jam); request rates wajib memuat `items[]`; fallback ongkir label "days".
- **Fix**: fly-to-cart vs shipping-map duplicate key (`${courier}-${service}-${idx}`); gray scale palet crema.
- **Admin panel tidak diubah** (tetap tema terpisah).

## 2026-08-08 — Fitur Alamat 1x (default_address) disempurnakan
- **Profil** (`/profile`): dropdown 4-level wilayah (Provinsi → Kab/Kota → Kecamatan → Kelurahan) menggantikan input teks; menyimpan `default_address` lengkap + kode Kemendagri ke backend.
- **Checkout** (`/checkout`): auto-fill alamat dari `user.default_address` + cascade fetch regency/district/village + auto ongkir.
- **Fix StrictMode / race condition**: penanda `appliedDefaultRef` kini di-set setelah chain async selesai (di `finally`), sehingga semua 4 dropdown terisi (bukan hanya provinsi).
- **Backend `ProfileController@update`**: menerima + menyimpan `default_address`.

## Sebelumnya (Agustus 2026, era pengembangan)
- Redesign homepage + navbar tema navy-kuning.
- Admin panel dengan SlideOver + Toast; perbaikan scroll slide-over (flex-col + min-h-0).
- Detail order + input nomor resi (AWB) admin; validasi AWB saat status shipped.
- Perbaikan tampilan gambar produk (helper `resolveImage`) di seluruh halaman.

## Related
- [[DEMO]]
- [[CVSS/DEMO/Features|Features]]
- [[CVSS/DEMO/Architecture|Architecture]]