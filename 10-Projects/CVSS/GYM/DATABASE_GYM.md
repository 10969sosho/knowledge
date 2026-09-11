# DATABASE — GYM Member Portal

## DBMS
- **SQLite** (`database/database.sqlite`)
- File-based, cocok untuk skala MVP/small

## Migration List
| Migration | Batch | Deskripsi |
|-----------|-------|-----------|
| `0001_01_01_000000_create_users_table` | 1 | Admin users (Laravel default) |
| `0001_01_01_000001_create_cache_table` | 1 | Cache (database driver) |
| `0001_01_01_000002_create_jobs_table` | 1 | Queue jobs (database driver) |
| `2026_08_06_060128_create_members_table` | 1 | Member data |
| `2026_08_06_060129_create_payments_table` | 1 | Payment/invoice |
| `2026_08_06_060130_create_notifications_table` | 1 | Notifikasi |
| `2026_08_06_060131_create_notification_reads_table` | 1 | Read tracking notifikasi |

## Tabel `members`
| Kolom | Tipe | Constraint | Catatan |
|-------|------|------------|---------|
| `id` | bigint PK | auto_increment | |
| `member_id` | string | unique | Auto: GYM0001, GYM0002... |
| `name` | string(255) | required | |
| `whatsapp` | string | unique, required | Strip non-digit |
| `photo` | string | nullable | Path ke storage |
| `membership_package` | string | required | Basic/Standard/Premium/VIP |
| `start_date` | date | required | |
| `expired_date` | date | required | Harus > start_date |
| `status` | string | required | active/expired/inactive |
| `qr_code` | string | nullable | (placeholder, belum fully implemented) |
| `login_token` | string | nullable | 6-digit OTP |
| `token_expires_at` | timestamp | nullable | Expiry OTP |
| `created_at`/`updated_at` | timestamp | | |

## Tabel `payments`
| Kolom | Tipe | Constraint | Catatan |
|-------|------|------------|---------|
| `id` | bigint PK | auto_increment | |
| `member_id` | bigint FK | references members.id | |
| `invoice_number` | string | unique, required | |
| `transaction_date` | date | required | |
| `membership_period` | string | required | 1/3/6/12 Months |
| `amount` | decimal(12,2) | required, min:0 | |
| `payment_status` | string | required | pending/paid/overdue |
| `invoice_file` | string | nullable | Path PDF/image invoice |
| `created_at`/`updated_at` | timestamp | | |

## Tabel `notifications`
| Kolom | Tipe | Constraint | Catatan |
|-------|------|------------|---------|
| `id` | bigint PK | auto_increment | |
| `title` | string | required | |
| `content` | text | required | |
| `category` | string | required | membership/payment/announcement/promotion/event/operational |
| `publish_at` | timestamp | nullable | Waktu publish |
| `status` | string | required | draft/published/archived |
| `created_at`/`updated_at` | timestamp | | |

## Tabel `notification_reads`
| Kolom | Tipe | Constraint | Catatan |
|-------|------|------------|---------|
| `id` | bigint PK | auto_increment | |
| `notification_id` | bigint FK | references notifications.id | |
| `member_id` | bigint FK | references members.id | |
| `read_at` | timestamp | | |
| Unique | composite | (notification_id, member_id) | Satu read per member per notif |

## Tabel `users` (Admin)
| Kolom | Tipe | Catatan |
|-------|------|---------|
| Standard Laravel users table | | name, email, password, timestamps |

## Relasi
```
Member (1) ──< (N) Payment
Member (1) ──< (N) NotificationRead
Notification (1) ──< (N) NotificationRead
```

## Seeder
- `UserSeeder`: 1 admin (`admin@gym.com` / `password`)
- `MemberSeeder`: 20 dummy members (via Factory)
- `PaymentSeeder`: Payments untuk members (via Factory)
- `NotificationSeeder`: Notifikasi multi-kategori

## Catatan
- SQLite **tidak support ALTER COLUMN** secara native — hati-hati saat mengubah skema
- Backup: copy file `database/database.sqlite`

## Related
- [[GYM]]
- [[ARCHITECTURE_GYM]]
- [[Laravel]]
