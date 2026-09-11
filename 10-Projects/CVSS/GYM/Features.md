# GYM Features

## Authentication
### Member Login (WhatsApp OTP)
- Input nomor WhatsApp
- Validasi format nomor
- Generate 6-digit OTP → simpan `login_token` + `token_expires_at`
- Verifikasi OTP → login guard `member`
- Logout

### Admin Login
- Email + password
- Standard Laravel auth guard `web`

---

## Member Portal (Mobile-First Dark Theme)

### Dashboard
- Greeting personal dengan nama member
- Ringkasan membership (member ID, status badge, package, expired date)
- Shortcut grid: Digital Card, Payments, Notifications
- Recent Payments list dengan status badge (paid/pending/overdue)
- Recent Notifications list dengan icon kategori
- Bell icon dengan unread count badge

### Digital Member Card
- Background kustom `bg.png` sebagai cover
- Foto member (atau placeholder icon jika tidak ada)
- Nama member (uppercase) + Member ID
- Package badge (Basic/Standard/Premium/VIP)
- Tanggal berlaku (expired date)
- QR code icon → link ke halaman QR scan
- Info detail: WhatsApp, Paket Membership, Masa Aktif
- Tips: "Tunjukkan kartu ini saat check-in di gym"
- Tombol "Scan QR Code" full-width gold

### QR Code Page
- Tampilan QR code placeholder (icon + member ID)
- Info member: nama, member ID, package
- Back button ke kartu

### Payment History (History tab)
- List invoice member dengan pagination
- Status badge (paid/pending/overdue)
- Invoice number, transaction date, amount (Rp format)
- Klik → detail payment: invoice number, date, member, package, period, amount, status, download invoice file

### Notifications
- List notifikasi dari admin
- Icon kategori (payment/membership/promotion/event/announcement/operational)
- Mark as read
- Unread count di bell icon navbar

### Account
- Profil member (read-only): nama, member ID, WhatsApp, package, status, masa aktif
- Tombol logout

---

## Admin Panel (Sidebar + Slide-in Drawers)

### Dashboard
- Total Members count
- Active/Expired/Inactive counts
- Membership expiring soon
- Total payments
- Recent activity

### Member Management
- **List**: Table dengan search (nama, WhatsApp, ID), filter status
- **Create**: Slide-in drawer dari kanan (full-height, max-w-lg)
  - Full Name*, WhatsApp*, Photo (optional), Membership Package*, Start Date*, Expired Date*, Status*
  - Auto-generate Member ID (GYM0001...)
- **Edit**: Slide-in drawer dengan data terisi, judul "Edit: [nama]"
  - WhatsApp validation: unique except current member
  - Photo: tampilkan existing photo, upload baru (auto-delete old)
- **Delete**: Konfirmasi hapus + hapus photo dari storage

### Payment Management
- **List**: Table dengan search (invoice/member name)
  - Kolom: Member, Period, Date, Amount, Status, Actions
  - **NO Invoice column** di index (dipindah ke detail customer)
- **Detail Customer**: Klik icon info → drawer menampilkan:
  - Info member (ID, WhatsApp, Package, Status)
  - Riwayat Invoice: invoice_number, date, period, amount, status, download invoice file
- **Create/Edit**: Slide-in drawer
  - Member*, Invoice Number*, Transaction Date*, Period*, Amount*, Status*, Invoice File (optional)
- **Delete**: Konfirmasi hapus + hapus file invoice

### Notification Management
- **List**: Table dengan search, filter status (draft/published/archived)
- **Create/Edit**: Slide-in drawer
  - Title*, Content*, Category* (membership/payment/announcement/promotion/event/operational), Status*
- **Publish/Archive/Draft**: Status workflow
- **Delete**: Konfirmasi hapus

---

## UI/UX Design
### Member Portal
- Dark theme: background `#0a0a0a`, cards `#1a1a1a` / `#111111`
- Accent color: gold `#f5c518` (`.text-gold`, `.bg-gold`)
- Bottom navbar 4 tab (fixed): Beranda | History | Kartu | Akun
- Max-width `max-w-lg` (mobile container)
- Smooth transitions & rounded corners (`rounded-2xl`)

### Admin Panel
- Sidebar layout (`w-64`) dengan gray-800 background
- Slide-in drawer dari kanan untuk create/edit forms
- Animasi CSS transition (300ms ease-in-out)
- Table list dengan hover state, status badges warna-warni
- Responsive: mobile hamburger menu untuk sidebar


## Related

- [[CVSS/GYM/GYM]]
- [[CVSS/CVSS]]
