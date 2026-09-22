# PAYROLL Hosting

## Production

- Domain: `payroll.3putraperkasa.com`
- SSH: `alurelab@160.187.143.18:31988`
- Repository: `/home/alurelab/repositories/solution`
- Database backup: `/home/alurelab/repositories/payroll_before_requirements_20260922.sql`
- Source backup: `/home/alurelab/repositories/solution.bak_20260922_requirements.tar.gz`

## Deploy

Transfer application files without `.env`, `vendor`, `storage`, and `.git`, then run:

```bash
php artisan optimize:clear --no-ansi
php artisan migrate --force --no-ansi
php artisan optimize --no-ansi
```

Dummy attendance data is safely upserted with:

```bash
php artisan db:seed --class=AttendanceDummySeeder --force --no-ansi
```

The seeder creates four scans per employee per day for July-September 2026, marks July fixed, and marks July payroll paid without overwriting an already-paid payroll.
