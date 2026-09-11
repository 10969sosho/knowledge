# PTPAS Architecture

## Pola Arsitektur
**Laravel MVC** - Model-View-Controller standar Laravel.

## Route Structure
| File | Prefix | Middleware | Deskripsi |
|------|--------|------------|-----------|
| `web.php` | `/admin/*` | `admin` | Panel admin |
| `guest.php` | `/*` | — | Guest area (include dari web.php) |
| `api.php` | `/api/guest/*` | — | REST API untuk guest |

## Service Layer
| Service | Lokasi | Fungsi |
|---------|--------|--------|
| **CartService** | `app/Services/CartService.php` | Resolve cart, add/remove/update items, merge cart, checkout |
| **OrderEmailService** | `app/Services/OrderEmailService.php` | Kirim email order ke semua user admin/super admin + customer + sales; alamat dummy `.local` di-skip |
| **ActivityLogger** | `app/Services/ActivityLogger.php` | Catat aktivitas admin ke `activity_logs` |
| **RemoteStockService** | `app/Services/RemoteStockService.php` | Koneksi ke SQL Server 2005 untuk cek stok real-time |

## Controller Structure
### Admin Controllers
- AboutController, AccountController, AuthController
- BroadcastController, CustomerController, CustomerAddressController
- DashboardController, FavoriteBrandController
- **FeaturedProductController** - Kelola produk terlaris
- **NewProductController** - Kelola produk terbaru
- ProductController, ProductBrandController, ProductCategoryController
- ProductImageController, ProductStatusController
- SalesLogController, SalesOrderController

### Guest Controllers
- AuthController, CartController, CustomerAddressController
- HomeController, MyCustomerController, OrderController
- ProfileController, RegionController
- **RemoteStockController** - Test koneksi remote stock

### API Controllers
- GuestHomeApiController, GuestOrderApiController, GuestProductApiController

## Authentication
### Dual Guard System
| Guard | Model | Provider | Login Page |
|-------|-------|----------|------------|
| `web` | `App\Models\User` | `users` | `/admin/login` atau `/login` |
| `customer` | `App\Models\Customer` | `customers` | `/login` |

### Middleware
| Middleware | Alias | Fungsi |
|------------|-------|--------|
| `EnsureAdmin` | `admin` | Hanya admin/super admin |
| `EnsureGuestLogin` | `guest.auth` | Customer atau Sales |
| `EnsureSales` | `sales` | Hanya role sales |

### Login Flow
1. User masuk ke `/login`
2. Cek guard `customer` (email/HP) → login sebagai Buyer
3. Jika gagal, cek guard `web` (email) → cek role:
   - `sales` → login sebagai Sales
   - `admin` → ditolak (harus `/admin/login`)
4. Admin login via `/admin/login` → guard `web`

## Database Design
### Key Tables
- `users` - Admin & Sales accounts
- `customers` - Buyer accounts (authenticatable)
- `customer_addresses` - Alamat pengiriman buyer
- `products` - Data produk dengan `status_product` & `no_urut_status`
- `product_statuses` - Status produk (TERLARIS, TERBARU, dll)
- `carts` & `cart_items` - Keranjang dengan `notes` field
- `sales_orders` & `sales_order_items` - Order dengan `notes` field
- `broadcasts` - Banner/pengumuman
- `activity_logs` - Log aktivitas admin

### Important Fields
- `products.status_product` - String (TERLARIS/TERBARU)
- `products.no_urut_status` - Integer untuk sorting
- `cart_items.notes` - Text, catatan per item
- `sales_order_items.notes` - Text, catatan per item di order
- `sales_orders.notes` - Text, catatan order

## Frontend Architecture
- **Admin Panel**: Blade + Bootstrap (server-side rendering)
- **Guest Web**: Blade + Bootstrap + vanilla JS
- **External Frontend**: REST API `/api/guest/*`

## Remote Stock Integration
- **Protocol**: PDO (dblib/sqlsrv) ke SQL Server 2005
- **Server**: ptpasonline.dyndns.org:1699
- **Database**: EzSystem
- **View**: vwtotalqtystock
- **Timeout**: 10 detik
- **Fallback**: Graceful degradation (return null jika gagal)


## Related

- [[CVSS/PTPAS/PTPAS]]
- [[CVSS/CVSS]]
- [[Laravel]]
