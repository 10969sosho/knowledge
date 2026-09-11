# Recent Updates - YMIITS

## 2026-08-16 - Laravel Structure Normalization

- Legacy hosting export normalized into a conventional Laravel root layout.
- Added dedicated `public/` web root and deployment-safe front controller.
- Removed obfuscated legacy entry points, archives, and large local logs from the release tree.
- Added `deploy.sh` for `alurelab`, repository checkout, upload preservation, and public-root synchronization.
- Release source synchronized to `~/repositories/ymiits`; domain activation is safely blocked until a production `.env` is provisioned.
- Added the standard project documentation set.
- Frontend production build passed.
- PHP route bootstrap and syntax checks passed.
- PHPUnit could not run locally because the machine uses PHP 8.5 while the locked Laravel 9 dependencies require PHP <= 8.4, and the local vendor tree has no PHPUnit binary.

## Related

- [[YMIITS]]
- [[CVSS]]
- [[Laravel]]

## 2026-08-16 - Production Deployment Completed

- Production `.env` created on server; `ymiits.sql` imported into the `alurelab_ymiits` database (27 tables, admin user preserved).
- `deploy.sh` hardened: pre-creates `storage/framework/*` directories (fixes `view:cache` "View path not found") and replaces `rsync` (absent on server) with `cp -a` + stale-file pruning.
- Fixed front controller basePath resolution for the `~/repositories/ymiits` deployment layout.
- Hosting does not follow symlinks pointing outside the docroot; added `GET /storage/{path}` (`StorageFileController`) to serve uploaded media, and synchronized 141 media files (banner, galleries, program images, etc.) to the server.
- Site is live at https://ymiits.com — home, `/login`, build assets, and all `/storage/*` URLs return 200. Only PHP 8.4 deprecation notices remain (harmless on Laravel 9).
- PHPUnit still not runnable locally (PHP 8.5 vs locked Laravel 9 deps); composer install verified on the server instead.
