# CENTRAL MEMORY STATE (HERMES ⇄ LAPTOP)

- **Repo Knowledge SSOT**: `https://github.com/10969sosho/knowledge.git`
- **Server Alurelab**: `emerald.hidden-server.net:31988`, user `alurelab`.
- **Server KBKB**: `157.15.77.18:31988`, user `kbkbid`, domain `kbkb.id`.
- **OpenCode Model Policy**:
  - **Default / Basic**: `openrouter/dots-studio/dots-3-note-preview:free` (OpenRouter Dots 3 Note Preview).
  - **Alternative / Mimo**: `opencode/mimo-v2.5-free` (MiMo V2.5 via native OpenCode / OpenZen) atau `openrouter/xiaomi/mimo-v2.5`.
  - **Paid / Fallback Lain**: `bandelbanget/claude-sonnet-4.5`, `bandelbanget/gpt-5.6-luna`, `bandelbanget/deepseek-v4-pro`.
- **cPanel Next.js Ports**: Port 3001 (furniture), 3002 (kawasaki). Jangan tabrak port, selalu cek `ps aux | grep next-server`.
- **Symlink Rule Next16 cPanel**: Copy `.next/static/.` ke `public/_next/` lalu symlink `ln -s . public/_next/static`.
- **Seeder/Migration**: Jangan rely pada `php -l`. Runtime verify seeder dengan driver MySQL/MariaDB compatible syntax.
- **ALURELAB Webhooks**: Xendit callback wajib memakai `XENDIT_WEBHOOK_TOKEN`; Biteship webhook memakai custom header/secret dan harus fail-closed jika belum dikonfigurasi.
- **ALURELAB Audit Batch**: Fallback transaksi, buyer phone IDOR, tenant header tanpa membership, mock payout/AWB, public settings leak, dan Redis/DB inventory divergence sudah diputus. Durable inventory reservation expiry/release sudah selesai. Voucher atomik dan Xendit disbursement/reconciliation belum selesai.
- **ALURELAB Hosting**: Production `app.alurelab.com` deployed/current, PM2 `alurelab-frontend` port 3040 online, Laravel scheduler cron aktif setiap menit, migration reservation applied, and runtime backup created at `/home/alurelab/app.alurelab.com.bak_20260916_1122`.
- **ALURELAB Xendit**: Production `XENDIT_WEBHOOK_TOKEN` updated and config cache rebuilt. Invalid token returns 401; configured token reaches payload validation (400 for empty payload). Token value is intentionally not stored in knowledge.
- **ALURELAB Xendit**: Development public key configured in production environment to match the existing development secret key. Backup created at `/home/alurelab/app.alurelab.com.bak_20260916_1122/backend.env.before_xendit_public_key`.
- **ALURELAB Xendit**: Valid signed test callbacks with unknown `external_id` now return 200 `ignored` instead of 404, allowing Dashboard Test and save without processing a fake order. Production backup: `/home/alurelab/app.alurelab.com.bak_20260916_xendit`.
- **ALURELAB Biteship**: Rates-only validation found production `BITESHIP_API_KEY` is still a dummy key, so real rates require the user to configure a Biteship API key. Webhook is not required for rate lookup. Store origin must be configured; hardcoded origin fallback was removed from the rates endpoint.
