# Hosting & Server Knowledge

## 1. Hosting Alurelab (Emerald)
- **Host**: `160.187.143.18` / `emerald.hidden-server.net`
- **Port**: `31988`
- **User**: `alurelab`
- **Environment**: cPanel, Enterprise Linux 9, Apache 2.4.68, MariaDB 10.11.18, Multi-PHP
- **Private Key**: `~/.ssh/id_ed25519` (Laptop) / `/root/.ssh/id_ed25519_cpanel` (Hermes HP)
- **Command SSH**:
  ```bash
  ssh -p 31988 alurelab@160.187.143.18
  ```

### Rules & Pattern Deploy di Alurelab:
- **Port Node/Next.js**: 
  - `3001` = Furniture
  - `3002` = Kawasaki
  - Selalu cek `ps aux | grep next-server` sebelum start port baru.
- **Next.js 16 Static Export di cPanel**:
  - Build output di `.next/static/chunks/`.
  - Copy `.next/server/app/*.html` ke `public/<resource>/index.html`.
  - Copy `.next/static/.` ke `public/_next/`.
  - **WAJIB symlink**: `ln -s . public/_next/static` agar asset CSS/JS tidak 404.

---

## 2. Hosting KBKB (Server Baru)
- **Host / IP**: `157.15.77.18`
- **Port**: `31988`
- **User**: `kbkbid`
- **Domain**: `kbkb.id`
- **Private Key**: `~/.ssh/id_ed25519_kbkb`
- **Command SSH**:
  ```bash
  ssh -p 31988 kbkbid@157.15.77.18
  ```

---

## 3. Database Dummy & Seeder Rules (Laravel)
1. **Dialect Compatibility**: Jangan hardcode PRAGMA atau foreign key syntax tanpa guard driver:
   ```php
   if (DB::connection()->getDriverName() === 'sqlite') { ... }
   ```
2. **Column Drops**: Gunakan guard `Schema::hasColumn(...)` sebelum modifikasi kolom.
3. **Seeder Context**: Hindari `fake()` global yang sering unbound. Gunakan generator native atau pastikan Factory ter-binding jelas.
4. **Runtime Verification**: Setiap task yang menyentuh DB migration/seeder **WAJIB** diverifikasi via eksekusi langsung, bukan cuma `php -l`.
