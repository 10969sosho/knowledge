# ARCHITECTURE — GYM Member Portal

## Lapisan Arsitektur
Project menggunakan **MVC standar Laravel** tanpa Service Layer (ukuran project masih kecil).

```
Laravel 13 (gym.alureflow.com)
├── Admin Panel (Blade)     ── resources/views/admin/*
├── Member Portal (Blade)   ── resources/views/member/*
├── Controllers             ── app/Http/Controllers/Admin/* | Member/*
├── Models / Eloquent       ── app/Models/*
├── Migrations              ── database/migrations/*
└── Routes                  ── routes/web.php
```

## Layers
| Layer | Lokasi | Peran |
|-------|--------|-------|
| Admin | `app/Http/Controllers/Admin/` | DashboardController, MemberController, PaymentController, NotificationController |
| Member | `app/Http/Controllers/Member/` | MemberAuthController, DashboardController, CardController, PaymentController, NotificationController |
| Auth | `app/Http/Controllers/Auth/` | LoginController (admin email/password) |
| Middleware | `app/Http/Middleware/` | AdminMiddleware, MemberMiddleware |
| Model | `app/Models/` | User, Member, Payment, Notification, NotificationRead |
| Views | `resources/views/` | Blade (admin sidebar + member bottom nav) |
| Migrasi | `database/migrations/` | 7 migration |

## Authentication — Dual Guard
| Guard | Model | Provider | Login |
|-------|-------|----------|-------|
| `web` | `App\Models\User` | `users` | `/login` (email/password) |
| `member` | `App\Models\Member` | `members` | `/member/login` (WhatsApp OTP) |

### Member Login Flow
1. Member masukkan nomor WhatsApp di `/member/login`
2. System generate 6-digit OTP + simpan ke `login_token` + `token_expires_at`
3. Redirect ke `/member/otp` untuk verifikasi
4. OTP valid → login via guard `member`, redirect ke dashboard

### Middleware
| Middleware | Alias | Fungsi |
|------------|-------|--------|
| `AdminMiddleware` | `admin` | Cek `auth:web` + role admin |
| `MemberMiddleware` | `member` | Cek `auth:member` |

## Route Structure
| Prefix | Middleware | Deskripsi |
|--------|------------|-----------|
| `/` | — | Redirect ke member.login |
| `/login` | — | Admin login (web guard) |
| `/member/login` | — | Member WhatsApp OTP login |
| `/member/*` | `member` | Member portal (dashboard, card, payments, notifications) |
| `/admin/*` | `admin` | Admin CRUD (members, payments, notifications) |

## Modul Utama
### Member Portal
- **Dashboard** — Ringkasan membership, recent payments, recent notifications
- **Digital Card** — Kartu member dengan bg.png background, foto member, QR code
- **Payment History** — List invoice member, download invoice file
- **Notification** — List + detail notifikasi, mark as read
- **Account** — Profil member (read-only)

### Admin Panel
- **Dashboard** — Total member, active/expired/inactive counts, recent activity
- **Member Management** — CRUD, search, filter status, photo upload, slide-in drawer form
- **Payment Management** — CRUD, detail customer drawer (invoice history), invoice upload
- **Notification Management** — CRUD, publish/archive/draft, multi-kategori

## Frontend Architecture
- **Member Portal**: Mobile-first dark theme (`#0a0a0a`), max-width `max-w-lg`, bottom navbar 4 tab
- **Admin Panel**: Sidebar layout (`w-64`), slide-in drawer untuk create/edit forms
- **Styling**: Tailwind CSS v4 via CDN + custom `.text-gold`, `.bg-gold`, `.card-dark`
- **Icons**: Font Awesome 6.5 CDN
- **JS**: Vanilla JavaScript (no framework), drawer animations

## Stack Teknis
| Komponen | Teknologi |
|----------|-----------|
| Framework | Laravel 13, PHP 8.3 |
| Database | SQLite |
| Frontend CSS | Tailwind CSS v4 (CDN) |
| Icons | Font Awesome 6.5 |
| Auth | Session-based dual guard |
| Queue | Database |
| Cache | Database |
| Session | Database |

## Pola Penting
- **Member ID Auto-Generate**: Format `GYM` + 4 digit (GYM0001, GYM0002...)
- **WhatsApp Normalization**: Strip non-digit karakter sebelum simpan
- **Drawer Form**: Admin create/edit pakai slide-in drawer dengan `openDrawer()` / `openEditDrawer()` JS
- **Photo/File Upload**: Disimpan di `storage/app/public/`, diakses via `asset('storage/...')`

## Related
- [[GYM]]
- [[CVSS]]
- [[Laravel]]
