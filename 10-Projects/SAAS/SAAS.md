# SAAS - Multi-Tenant Marketplace Skeleton (Laravel + Livewire)

## Overview
Skeleton marketplace SaaS multi-tenant dibangun dengan Laravel 13 + Livewire Volt + Spatie Permission. Seller dapat mengelola branded storefront, produk, varian/SKU, dan kategori. Public storefront menampilkan hero, search, kategori, dan product grid.

## Location
`/Users/10969sosho/PROJECT/SAAS/`

## Tech Stack
| Layer | Technology |
|-------|-----------|
| Backend | Laravel 13.7, PHP 8.3+ |
| Frontend | Livewire 3.6 + Volt 1.7 (TALL-ish) |
| CSS | Tailwind CSS v3 (Vite + PostCSS) |
| Auth | Laravel Breeze 2.4 (Livewire/Volt SPA) |
| RBAC | Spatie Laravel-Permission 7.4 |
| Database | MySQL (`ecommerce`) |
| Queue/Session/Cache | Database driver |

## Structure
```
SAAS/
├── app/
│   ├── Http/Controllers/
│   │   ├── Auth/VerifyEmailController.php
│   │   └── Seller/
│   │       ├── CategoryController.php     (CRUD + unique slug)
│   │       ├── ProductController.php      (CRUD + gallery + thumbnail + publish toggle)
│   │       └── VariantController.php      (CRUD per product)
│   ├── Models/
│   │   ├── Category.php                   (self-referencing parent/children, SoftDeletes)
│   │   ├── Product.php                    (category, images, variants, SoftDeletes)
│   │   ├── ProductImage.php               (sort_order)
│   │   ├── ProductVariant.php             (color, size, additional_price)
│   │   ├── StoreSetting.php               (JSON casts: social_links, colors)
│   │   └── User.php                       (HasRoles from Spatie)
│   └── Services/
│       └── StoreSettingsService.php       (cached singleton + hex darkening)
├── database/migrations/                   # 9 migrations
├── resources/views/
│   ├── welcome.blade.php                  # Public storefront marketplace
│   ├── dashboard.blade.php                # Seller KPI + checklist
│   └── seller/                            # categories, products, variants CRUD
```

## Key Features

### Role-Based Access
- `seller` - Seller Center dashboard
- `buyer` - Public marketplace shopper
- Via Spatie Laravel-Permission

### Seller Center
- **Dashboard**: KPI (products count, published count, categories, variants) + setup checklist
- **Store Branding**: Custom name, logo, favicon, banner, brand color (CSS variable), OG image, SEO meta, contact email/WhatsApp/address, social links (Instagram/TikTok/Facebook), footer HTML
- **Product Management**: CRUD + slug auto-gen, SKU uniqueness, thumbnail + gallery (max 12, sortable), category assignment, stock, compare-at price, draft/published toggle, soft deletes
- **Category Management**: CRUD + parent-child hierarchy, slug gen, sort order, active/inactive toggle, soft deletes
- **Variant/SKU**: Per-product variants (color, size, stock, additional price, unique SKU)

### Public Storefront (`welcome.blade.php`)
- Hero with search bar
- Promo card
- Category pills
- Product grid (placeholder)
- CTA for sellers
- Dynamic brand color via CSS variables
- `StoreSettingsService` cached singleton

### Auth Pages (Livewire Volt)
Register, Login, Forgot Password, Reset Password, Verify Email, Confirm Password

## Models (6 custom)
`Category`, `Product`, `ProductImage`, `ProductVariant`, `StoreSetting`, `User`

## Database Tables
- `users`, `roles`, `permissions` (Spatie standard)
- `store_settings` - store branding (logo, favicon, banner, colors, social_links, seo_meta)
- `categories` - name, slug, parent_id, sort_order, is_active, softDeletes
- `products` - name, slug, sku, description, price, compare_at_price, stock, status (draft/published), thumbnail, softDeletes
- `product_images` - product_id, path, sort_order
- `product_variants` - product_id, sku, color, size, stock, additional_price


## Related

- [[PROJECT INDEX]]
- [[Laravel]]
- [[Livewire]]
