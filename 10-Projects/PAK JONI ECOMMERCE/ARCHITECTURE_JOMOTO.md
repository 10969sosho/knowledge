# ARCHITECTURE — JOMOTO CENTER

## Lapisan Arsitektur
Project menggunakan **Service Layer** (bukan Repository Pattern). Logika bisnis dipisah ke `app/Services/`.

```
Laravel 13 (jomotocenter.com)
├── Filament v4 Admin Panel  ── app/Filament/Resources/*
├── Storefront (Blade)       ── app/Http/Controllers/Buyer/*, resources/views/buyer/*
├── Services                 ── app/Services/*  (logika bisnis terpusat)
├── Models / Eloquent        ── app/Models/*
├── Migrations               ── database/migrations/*
└── Routes                   ── routes/web.php
```

## Layers
| Layer | Lokasi | Peran |
|-------|--------|-------|
| Admin | `app/Filament/Resources/` | CRUD via Filament v4 (30+ resource) |
| Storefront | `app/Http/Controllers/Buyer/` | PageController, Motor, Part, Cart, Checkout, Order, Address, Wishlist, Region |
| Service | `app/Services/` | StockService, OrderService, PaymentService, BiteshipService, ImageService |
| Model | `app/Models/` | 40+ Eloquent models |
| Views | `resources/views/` | Blade (admin + storefront) |
| Migrasi | `database/migrations/` | 38 migration |

## Modul Utama
### Produk (Item & Part)
- **Item** = motor / mobil / ATV utama (per `items` table).
  - Memiliki varian warna → `ItemColor` (child). Stok di level ItemColor.
  - Relasi: `colors`, `images`, `specifications`, `360images`, `partCatalog`, `priceLists`, `categories`.
- **Part** = sparepart.
  - Memiliki `PartVariant` (stok).
  - Relasi: `variants`, `images`, `specifications`, `360images`.
- **PartCatalog / PartCategory** — katalog & kategori part.

## Order Flow
```
Cart → Checkout → Order (Pending) → Midtrans Payment
    └── paid → OrderService::markAsPaid → decrease stock (StockService) → StockMutation
```

## Membership / Role
- **Guest**: lihat produk, cart, wishlist.
- **Customer** (User): checkout, order, quotation request.
- **Admin**: Filament panel, kelola master & order, kelola stok.

## Third-party
- **Filament v4** (admin)
- **Livewire** (reactive)
- **Midtrans** (Snap.js payment)
- **Biteship** (shipping)
- **Tailwind + Vite** (frontend build)

## Pola Penting
- **Stock Level**: varian-level (`ItemColor`, `PartVariant`) — dikelola lewat `StockService`.
- **Polymorphic morph**: `stockable`, `itemable`, `reference` untuk generalisasi antar type.
- **Migrations**: banyak jenis, jumlah 38 file — jangan `migrate:fresh` di production.

## Related
- [[PAK JONI ECOMMERCE]]
- [[STOCK_MANAGEMENT]]
- [[DATABASE_JOMOTO]]