---
name: laravel-enterprise-core
description: Enterprise architecture and best practices for Laravel 11 and 12. Covers slim controllers, FormRequest validation, Eloquent query optimization, N+1 prevention, database seeder durability (MySQL/MariaDB vs SQLite), and production cPanel deployment safeguards.
---

# Laravel Enterprise Core & Architecture Standards

Standar arsitektur backend Laravel 11/12 yang scalable, aman, efisien secara database query, dan tahan banting di lingkungan shared hosting maupun container.

---

## 1. Clean Controller & Request Lifecycle

Jangan biarkan Controller menjadi tempat menumpuk query, business logic, dan validasi (Fat Controller anti-pattern).

```
HTTP Request ──▶ FormRequest (Validasi) ──▶ Controller ──▶ Action / Service (Logic) ──▶ API Resource (Response)
```

### A. Validasi via FormRequest
Selalu buat class FormRequest tersendiri:
```php
class StoreOrderRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()->can('create', Order::class);
    }

    public function rules(): array
    {
        return [
            'items' => ['required', 'array', 'min:1'],
            'items.*.product_id' => ['required', 'exists:products,id'],
            'items.*.quantity' => ['required', 'integer', 'min:1'],
        ];
    }
}
```

### B. Controller yang Ramping (Thin Controller):
```php
class OrderController extends Controller
{
    public function store(StoreOrderRequest $request, CreateOrderAction $action)
    {
        $order = $action->execute($request->user(), $request->validated());
        return new OrderResource($order);
    }
}
```

---

## 2. Eloquent Performance & Eliminasi N+1 Problem

Query database yang tidak teroptimasi adalah penyebab utama server lemot dan kehabisan memori.

### A. Eager Loading Wajib
- ❌ **BAD (N+1 Query)**:
  ```php
  $orders = Order::all();
  foreach ($orders as $order) {
      echo $order->customer->name; // Mengeksekusi query database di setiap iterasi loop!
  }
  ```
- ✅ **GOOD (Eager Loading)**:
  ```php
  $orders = Order::with('customer')->get(); // Hanya 2 query!
  ```

### B. Mencegah Memory Exhaustion pada Data Besar
Jangan gunakan `Model::all()` untuk data ribuan baris. Gunakan `lazy()` atau `chunk()`:
```php
Order::where('status', 'pending')
    ->lazy()
    ->each(function (Order $order) {
        // Diproses per-batch streaming di memori, tidak menyebabkan OOM
    });
```

---

## 3. Aturan Seeder & Migration Lintas Database (MySQL vs SQLite)

1. **Foreign Key Toggle Cross-Driver**:
   ```php
   if (DB::connection()->getDriverName() === 'sqlite') {
       DB::statement('PRAGMA foreign_keys = OFF;');
   } else {
       DB::statement('SET FOREIGN_KEY_CHECKS = 0;');
   }
   ```
2. **Guard Kolom Sebelum Drop**:
   ```php
   if (Schema::hasColumn('users', 'legacy_token')) {
       $table->dropColumn('legacy_token');
   }
   ```
3. **Faker Generator Binding**: Hindari helper global `fake()` tanpa import. Gunakan:
   ```php
   $faker = \Faker\Factory::create('id_ID');
   ```
4. **Eksekusi di Production**: Laravel memblokir seeder di `APP_ENV=production`. Selalu sertakan flag `--force`:
   ```bash
   php artisan db:seed --class=DummyDataSeeder --force
   ```

---

## 4. Cache & Deployment Safeguards

- **Config Cache Pollution**: Jika Anda mengedit file `.env` atau `config/*.php`, **WAJIB** hapus cache lama terlebih dahulu sebelum men-generate cache baru:
  ```bash
  php artisan optimize:clear
  php artisan optimize
  ```
- **Symlink vs Copy di cPanel**: Shared hosting cPanel sering kali memblokir symlink dari `storage/app/public` ke `public/storage`. Gunakan direct copy atau sync directory pada cPanel.
