# KBKB (Kabe Kabe) — Membership System

- **Repo**: https://github.com/Gen-ei-Ryodan/kabekabe (branch `main`)
- **Local**: `~/PROJECTS/finance/PROJECT/PROJECT ANTIGRAVITY/KBKB`
- **Domain**: https://kbkb.id
- **Stack**: Laravel 11/12 + Inertia.js + React (Breeze) + SQLite (dev) / MySQL `kbkbid_membership` (prod)
- **Role**: `admin`, `vendor` (partner), `member`

## Portal Login (sejak 2026-09-23)
| Portal | URL | Guard | Role |
|--------|-----|-------|------|
| Member | `kbkb.id/login` | `web` | `member` |
| Partner | `kbkb.id/partner` | `partner` (baru) | `vendor` |
| Admin | `kbkb.id/admin` | `web` | `admin` |

- Guard `partner` terpisah → 1 window bisa login member + partner bersamaan.
- Logout masing-masing: `POST /logout` (web), `POST /partner/logout` (partner) — pakai `session()->regenerate()`, bukan `invalidate()`.
- Guest redirect per portal via exception renderer di `bootstrap/app.php`.

## Fitur Kunci
- Kode member: `7030YYMMNNN` (reset tiap bulan), kode lama `7030YYNNNN` tetap valid.
- Home member: kartu "Paket Aktif" (`active_package`) saat membership aktif.
- Approve partner: popup search member opsional → `partners.member_user_id`.
- Vendor QR scan → transaksi max 48 jam (`member_scans`).
- Payment gateway DOKU, email OTP lupa password, timezone WITA.

## Dokumentasi di Repo
- `deploy.md` — SOP deploy (perhatikan: path Alurelab di file itu **lama**; yang benar lihat `HOWTO-HOSTING.md`).
- `docs/` — DATABASE, BUSINESS_RULES, CHANGELOG, API_REFERENCE.
- `REVISI_CHECKLIST.md`, `REVISI_DETAIL.md` — spesifikasi revisi.

## Testing
```bash
php artisan test   # 152 tests / 927 assertions (2026-09-23)
npm run build      # wajib sebelum test render halaman (Vite manifest)
```
