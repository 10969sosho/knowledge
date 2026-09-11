# CENTRAL MEMORY STATE (HERMES ⇄ LAPTOP)

- **Repo Knowledge SSOT**: `https://github.com/10969sosho/knowledge.git`
- **Server Alurelab**: `emerald.hidden-server.net:31988`, user `alurelab`.
- **Server KBKB**: `157.15.77.18:31988`, user `kbkbid`, domain `kbkb.id`.
- **cPanel Next.js Ports**: Port 3001 (furniture), 3002 (kawasaki). Jangan tabrak port, selalu cek `ps aux | grep next-server`.
- **Symlink Rule Next16 cPanel**: Copy `.next/static/.` ke `public/_next/` lalu symlink `ln -s . public/_next/static`.
- **Seeder/Migration**: Jangan rely pada `php -l`. Runtime verify seeder dengan driver MySQL/MariaDB compatible syntax.
