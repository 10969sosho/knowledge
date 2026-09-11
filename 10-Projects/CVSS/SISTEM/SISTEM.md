# CVSS Sistem (Task Manager)

Task Manager adalah aplikasi internal CV Solusi Surabaya untuk mengelola
customer, project, task harian (kanban), revisi, hosting/domain, dan keuangan
project. Dibangun sebagai monorepo: Laravel API + Next.js frontend.

## Stack

- Backend: Laravel 13, Sanctum, MySQL (MariaDB hosting), repository & service layer
- Frontend: Next.js 16 (App Router), TypeScript, Tailwind, Zustand (static export)
- Deployment: cPanel/LiteSpeed di server `alurelab`

## Production

- Domain: https://qwe.solusisurabaya.com
- Repo server: `~/repositories/sistem`
- GitHub: https://github.com/10969sosho/sistem
- DB: `alurelab_sistem` (user `alurelab_sistem`)
- Frontend: static export (`frontend/out`) di docroot `~/qwe.solusisurabaya.com`
- API: Laravel di-rewrite dari `/api/*` ke `index.php` front controller di docroot
- Source of truth: `https://github.com/10969sosho/sistem`; HP clone: `/root/projects/sistem/`

## Fitur (V1)

- Dashboard (task hari ini/overdue/minggu ini, project berjalan/revisi, hosting & domain expired, tagihan belum lunas)
- Customer CRUD (field email opsional)
- Project CRUD (status pipeline: pending/progress/testing/revisi/maintenance/selesai)
- Task Kanban 3 kolom + drag & drop + detail task + **cabang (Tian/Cecil)** + filter cabang
- Delete action di seluruh modul (customer, project, task, hosting, finance, lead, opportunity)
- Hosting & domain monitoring
- Finance project (total/DP/termin/pelunasan, status otomatis)
- Global search (customer, project, task, domain)
- Auth Sanctum (token Bearer)

## Fitur (V2 — CRM v1)

- Lead pipeline: New → Contacted → Interested → Discussion → Offer Sent → Negotiation → Deal / Lost
- Auto follow-up task saat lead baru
- Activity timeline per lead (WhatsApp, Call, Meeting, Note)
- Opportunity / penawaran dengan pipeline value & revenue tracking di dashboard
- Auto konversi Deal → Customer (berdasarkan nomor WhatsApp)
- Source performance analysis di dashboard CRM
- Menu terpisah di sidebar (`/crm`) dengan 4 tab: Dashboard, Leads, Pipeline, Activities
- Semua data CRM di-scope per user (multi-user ready)
- Tabel CRM: `leads`, `activities`, `opportunities`; `customers.user_id` + `tasks.lead_id`

## Deployment Detail

Lihat `DEPLOYMENT.md` di repo. Ringkasan arsitektur:

| Bagian | Lokasi | Cara disajikan |
| --- | --- | --- |
| Frontend | `~/qwe.solusisurabaya.com/*` | File statis hasil `next export` |
| Backend | `~/repositories/sistem/backend` | `index.php` di docroot mem-bootstrap Laravel; `/api/*` di-rewrite ke sana |

Update server: `git pull` → `composer install` → cache Laravel → `npm run build`
(dengan `NEXT_PUBLIC_API_URL=https://qwe.solusisurabaya.com/api`) → `cp out/* ~/qwe.solusisurabaya.com/`.

DB di-hosting dibuat lewat cPanel `uapi Mysql` dan diisi dari dump lokal
(`task_manager`): 1 admin, 17 customer, 25 project, 25 finance. Migrations 15
semua `Ran`.

## Testing

- Backend: `cd backend && php artisan test` → 65 tests PASS (phpunit, sqlite :memory:)

## Related

- [[CVSS]]
- [[Laravel]]
- [[Next.js]]
- [[CRM]]
- [[Solusi Surabaya Portfolio]]
