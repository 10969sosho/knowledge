# DEMO — Architecture

## Arsitektur Umum
```
buyer browser (Next.js :3000)  admin browser (Next.js :3000)
        │                             │
        └─────────── axios /api ───────┘
                    │
          Laravel API (:8000)
          ├── Sanctum auth (Hake Bearer)
          ├── Auth/Product/Category/Cart/Order/Profile/Shipping/Wilayah controller
          ├── Admin/* controller (role admin)
          └── Integration: Midtrans Snap, Biteship, wilayah.id
```

## Backend (Laravel 11)
- **Controller**: `app/Http/Controllers/Api/` (buyer) + `Api/Admin/` (admin).
- **Models**: User, Category, Product, Cart, CartItem, Order, OrderItem — casts `default_address`→array, `images`→array, `shipping_address`→array; `image_url` accessor (`asset('storage/...')`).
- **Auth**: Sanctum Bearer; `AdminMiddleware` (role === 'admin').
- **Routes**: `routes/api.php` — public (products, categories, wilayah, auth, midtrans callback), auth (cart, orders, profile, shipping), admin.
- **Storage**: image file di `public` disk (`products/`, `categories/`) — butuh `php artisan storage:link`.
- **Integrasi eksternal** (config/services.php): `midtrans.*`, `biteship.*`.

## Frontend (Next.js 16)
- App Router; client components di sebagian besar halaman.
- **State (Zustand)**: `store/auth.ts` (user/token persist localStorage), `store/cart.ts` (server cart), `store/cart-anim.ts` (fly-to-cart).
- **API**: `lib/api.ts` axios baseURL `NEXT_PUBLIC_API_URL`, inject Bearer, 401 → redirect /login.
- **Shared UI**: `components/ui/toast.tsx` (ToastProvider), `components/ui/slide-over.tsx`, `components/spinner.tsx`, `components/cart-animation.tsx`, `components/brand.tsx`.
- **Pages**: homepage, products/list+detail, cart, checkout, login, register, profile, orders (list & detail), payment, admin/* (dashboard/products/categories/orders).

## Database (ringkas)
- `users` (+ role, phone, address, city, province, postal_code, default_address JSON)
- `categories` · `products` (+/ kategori FK, is_active, image, images JSON) · `carts` · `cart_items`
- `orders` (+ status enum, shipping_*, payment_status, midtrans_snap_token) · `order_items` (snapshot)

> Detail skema lengkap ada di `docs/FEATURES.md` bagian 10.

## Deployment Notes
- Dev: `php artisan serve` (8000) + `npm run dev -- -p 3000`.
- `next build` memakan cache `.next` yang dipakai `next dev` → setelah build, restart dev server.
- `.env.local` frontend: `NEXT_PUBLIC_API_URL`, `NEXT_PUBLIC_MIDTRANS_CLIENT_KEY`.

## Related
- [[DEMO]]
- [[Next.js]]
- [[Laravel]]
- [[Authentication]]