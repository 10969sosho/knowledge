# GYM - Digital Member Portal

**Xtreme Fitness Center** — Digital Member Portal untuk manajemen membership gym.

## Overview
Platform membership berbasis web/mobile responsive. Member bisa login via WhatsApp OTP, lihat kartu digital, riwayat pembayaran, dan notifikasi. Admin kelola members, payments, dan notifikasi via panel admin.

## Location
`/Users/10969sosho/PROJECT/CVSS/ON_PROGRES/PAK EFFENDI/GYM/gym-app`

## Tech Stack
- **Backend**: Laravel 13, PHP 8.3
- **Frontend**: Blade templates + Tailwind CSS v4 (CDN) + Font Awesome 6.5
- **Database**: SQLite
- **Auth**: Session-based (2 guards: `web` admin, `member`)
- **Queue/Cache/Session**: Database driver

## User Roles
| Role | Guard | Area Akses | Login |
|------|-------|------------|-------|
| Admin | `web` | Panel admin (`/admin/*`) | `/login` (email/password) |
| Member | `member` | Portal member (`/member/*`) | `/member/login` (WhatsApp OTP) |

## Main Modules
1. **Authentication** — Dual guard (admin email/password, member WhatsApp OTP)
2. **Member Dashboard** — Ringkasan membership, recent payments, notifications
3. **Digital Card** — Kartu member dengan bg.png background, foto, QR code
4. **Payment History** — List invoice + download invoice file
5. **Notifications** — Multi-kategori (membership, payment, promotion, event)
6. **Admin: Member Management** — CRUD, search, filter, photo upload
7. **Admin: Payment Management** — CRUD, detail customer drawer, invoice upload
8. **Admin: Notification Management** — CRUD, publish/archive/draft

## Key Features
- **WhatsApp OTP Login**: Login tanpa password, 6-digit OTP
- **Digital Card**: Background kustom (bg.png), foto member, QR code
- **Mobile-First**: Dark theme (`#0a0a0a`), bottom navbar, max-width `max-w-lg`
- **Slide-in Drawer**: Admin CRUD menggunakan drawer kanan dengan animasi
- **Auto Member ID**: Format GYM0001, GYM0002...

## Deploy
- **URL**: https://gym.alureflow.com
- **Server**: alurelab (emerald.hidden-server.net:31988)
- **Deploy**: `./deploy.sh` dari project root

## Documentation
| Doc | Deskripsi |
|-----|-----------|
| [[ARCHITECTURE_GYM]] | Struktur arsitektur, auth, route, modul |
| [[DATABASE_GYM]] | Skema database, tabel, relasi |
| [[DEPLOYMENT_GYM]] | Panduan deploy, server, environment |
| [[CVSS/GYM/Features|Features]] | Fitur lengkap per modul |
| [[CVSS/GYM/Recent Updates|Recent Updates]] | Log perubahan terbaru |

## Related
- [[CVSS]]
- [[Laravel]]
- [[Authentication]]
