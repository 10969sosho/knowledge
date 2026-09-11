# Recent Updates

## 2026-08-13 — Revisi (cabang task, delete action, perbaikan leads)

Berdasarkan `REVISION.md`:

- **Email customer** tidak wajib diisi (sudah nullable di backend + frontend tanpa `required`).
- **Cabang task**: kolom `tasks.cabang` (enum `tian`/`cecil`), migration baru, validasi request, filter repository, resource, meta enum, factory. Frontend: filter cabang di board, badge cabang di kartu, field cabang di form create/edit, tampilan di detail.
- **Delete action** di seluruh modul: customer, project, task (kartu kanban), hosting, finance, lead, opportunity — semua dengan konfirmasi `window.confirm`.
- **Detail Leads**: tombol "Open Detail" diubah dari `Link` ke drawer mode `show` (detail lead tampil langsung di drawer, termasuk timeline aktivitas).
- **Edit Leads**: saat edit membuka form edit berisi data (bukan form create); form lead tidak lagi menampilkan field email.
- **Email Leads dihapus**: field email pada form lead & detail, serta tipe aktivitas `email` dihapus (tersisa WhatsApp, Call, Meeting, Note).
- Test backend: 65 PASS (tambah test filter cabang + validasi cabang).

## 2026-08-12 — Integrasi CRM v1

- 5 migration baru: `leads`, `activities`, `opportunities` (InnoDB), `customers.{company,user_id}`, `tasks.lead_id`
- Model, Service, Controller untuk CRM: `CrmService` mengelola business logic penuh (lead lifecycle, auto follow-up, deal→customer conversion)
- API routes: `/api/crm/dashboard`, `/api/crm/leads`, `/api/crm/opportunities`, `/api/crm/activities`
- Frontend Next.js: 7 halaman CRM baru di `/crm` (dashboard, leads list & detail, opportunities pipeline, activities timeline)
- Menu sidebar "CRM" dengan icon Handshake
- TypeScript types: `CrmLead`, `CrmOpportunity`, `CrmActivity`, `CrmDashboard`
- Migration InnoDB fix untuk produksi (default cPanel MyISAM)
- Deployment: build frontend statis ulang, copy ke docroot, `artisan migrate`
- Semua 63 test TASK tetap pass

## 2026-08-12 — Initial deploy ke production

- Git repo dibuat dan di-push ke https://github.com/10969sosho/sistem (branch `main`)
- DB `alurelab_sistem` dibuat di hosting (cPanel `uapi Mysql`), diisi dari dump lokal `task_manager` (1 admin, 17 customer, 25 project, 25 finance)
- Backend Laravel di-deploy ke `~/repositories/sistem/backend` dengan `.env` production (DB `alurelab_sistem`)
- Frontend Next.js diubah ke `output: "export"`, di-build dengan `NEXT_PUBLIC_API_URL=https://qwe.solusisurabaya.com/api`, hasilnya di-publish ke docroot `~/qwe.solusisurabaya.com`
- Route dynamic `/tasks/[id]` dipecah menjadi server wrapper + client component agar bisa static export
- Domain `qwe.solusisurabaya.com` live: frontend di root, API Laravel di `/api/*` via `index.php` front controller di docroot (pola sama dengan photobox.alureflow.com)
- Laravel optimasi: config/route/view/event cache
- Backend test: 63 PASS

## Related

- [[SISTEM]]
- [[CVSS]]
