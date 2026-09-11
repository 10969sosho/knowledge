# Recent Updates - GYM

## 2026-08-11 — Fix Admin Payment Index

- Memperbaiki error pada halaman Payment Management akibat markup tabel yang terduplikasi.
- Index payment sekarang hanya menampilkan data pembayaran tanpa kolom Invoice.
- Invoice tetap tersedia pada drawer Detail Customer melalui riwayat invoice member.
- Query index mengabaikan payment yang tidak memiliki customer terkait agar halaman tidak gagal render.
- **Deployed** ke https://gym.alureflow.com via `./deploy.sh` (commit `5542f0d` di main).
- Post-deploy verification: root 302, `/member/login` 200, `/login` 200.

---

## 2026-08-07 — Deploy & Fix Static Files

### Deploy Server
- Deploy ke `gym.alureflow.com` via SSH alurelab
- Web live: member login (200), admin login (200)
- Migration runs (7 migration, batch 1)
- Production optimization (config/route/view/event cache)

### Fix bg.png
- **Root cause**: Apache di shared hosting tidak follow symlink → semua static file 404
- **Fix**: Copy langsung `bg.png` ke `/home/alurelab/gym.alureflow.com/` (bukan symlink)
- **deploy.sh**: Auto-sync file baru dari `public/` ke public dir

---

## 2026-08-07 — UI Improvements & Bug Fixes

### Member Portal
- Hapus Benefit Member section dari dashboard dan kartu
- Navbar bawah: "Jadwal" → "History" (icon fa-history), "Aktivitas" dihapus
- Navbar jadi 4 tab: Beranda | History | Kartu | Akun
- Redesain kartu member digital:
  - Background `bg.png` sebagai cover
  - Foto member ditampilkan di tengah
  - Info lengkap: nama, member ID, paket, masa aktif, WhatsApp

### Admin Panel
- Fix bug edit member: openDrawer sebelumnya selalu me-reset form ke mode create
- Payment index: kolom Invoice dihapus dari tabel
- Invoice sekarang muncul via ikon detail customer → drawer riwayat invoice per member
- Route baru: `GET admin/members/{member}/payments`
- View baru: `admin/payments/member-detail.blade.php`

### Assets
- `bg.png` dipindahkan ke `public/` untuk akses web


## Related

- [[CVSS/GYM/GYM]]
- [[CVSS/CVSS]]
