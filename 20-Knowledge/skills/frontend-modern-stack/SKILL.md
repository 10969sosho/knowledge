---
name: frontend-modern-stack
description: Best practices for modern frontend development using Next.js (App Router 15/16), TypeScript, Tailwind CSS, and shadcn/ui. Covers React Server Components, responsive design, cPanel static export patterns, and UI performance optimization.
---

# Modern Frontend Engineering (Next.js, Tailwind & shadcn/ui)

Standar arsitektur dan konvensi pengembangan frontend modern yang cepat, aksesibel, dan kompatibel dengan deployment cPanel maupun Node server.

---

## 1. Next.js App Router: RSC vs Client Components

Secara default, semua komponen di App Router adalah **React Server Components (RSC)**.

### Kapan Menggunakan RSC (Default):
- Mengambil data langsung dari database atau backend API.
- Mengakses environment variables rahasia (API keys, secrets).
- Mengurangi bundle JavaScript client (komponen berat yang tidak interaktif).

### Kapan Menggunakan Client Component (`'use client'`):
- Membutuhkan React state (`useState`, `useReducer`).
- Menggunakan lifecycle atau side-effects (`useEffect`).
- Menggunakan event listeners (`onClick`, `onChange`, `onSubmit`).
- Membutuhkan browser APIs (`localStorage`, `window`, `navigator`).

> [!TIP]
> **Push Client Boundaries Down**: Jangan jadikan seluruh halaman `'use client'`. Buat halaman tetap RSC, dan bungkus hanya elemen interaktif kecil (misal tombol submit, search bar, dropdown) sebagai Client Component.

---

## 2. cPanel Static Export Pattern (`output: 'export'`)

Untuk project Next.js yang di-host di shared hosting cPanel (Alurelab/KBKB):

### A. Konfigurasi `next.config.ts`:
```typescript
import type { NextConfig } from 'next';

const nextConfig: NextConfig = {
  output: 'export',
  trailingSlash: true, // WAJIB agar menghasilkan folder/index.html (mencegah 404 di Apache)
  images: {
    unoptimized: true, // WAJIB untuk static export tanpa Node server
  },
};

export default nextConfig;
```

### B. Dynamic Routes & `'use client'` Conflict
Di App Router static export, dynamic route `[id]/page.tsx` **WAJIB** mengekspor `generateStaticParams()`. Namun, `generateStaticParams` TIDAK BISA berada di file yang memiliki `'use client'`.

**Solusi Pemisahan (Split Pattern):**
1. `app/products/[id]/page.tsx` (Server Component, NO `'use client'`):
   ```tsx
   import ProductClient from './_Client';

   export async function generateStaticParams() {
     // Return list ID statis
     return [{ id: '1' }, { id: '2' }];
   }

   export default function Page({ params }: { params: { id: string } }) {
     return <ProductClient id={params.id} />;
   }
   ```
2. `app/products/[id]/_Client.tsx` (Client Component dengan interaksi):
   ```tsx
   'use client';
   export default function ProductClient({ id }: { id: string }) {
     // State, hooks, UI interaktif di sini
     return <div>Product ID: {id}</div>;
   }
   ```

### C. Struktur Aset di Docroot cPanel:
Setelah `npm run build`, aset static berada di `.next/static/` atau `out/`:
- Pastikan file HTML masuk ke docroot domain.
- Pastikan folder `_next/static` tersalin sempurna.
- Buat symlink jika path asset memicu 404: `ln -s . public/_next/static`.

---

## 3. Desain Sistem & shadcn/ui

- **Accessible Primitives**: Gunakan shadcn/ui (Radix UI) untuk komponen kompleks (Modal, Dropdown, Accordion, Tooltip) agar navigasi keyboard (Tab, Enter, Escape, Arrow keys) otomatis ramah aksesibilitas (a11y).
- **Mobile-First Responsive**: Desain selalu dimulai dari mobile portrait (`360px - 430px`), lalu naik ke tablet (`md: 768px`) dan desktop (`lg: 1024px`, `xl: 1280px`).
- **Tailwind Tokens**: Jangan hardcode arbitrary value (`w-[273px]`). Gunakan sistem grid fleksibel, `gap`, dan flexbox untuk layout yang responsif di semua ukuran layar.
