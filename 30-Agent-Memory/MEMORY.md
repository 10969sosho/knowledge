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
