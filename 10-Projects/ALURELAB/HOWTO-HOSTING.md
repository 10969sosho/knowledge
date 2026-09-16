# ALURELAB Hosting

## Laravel Scheduler

The backend releases expired inventory reservations every minute. Configure one cPanel cron entry:

Production cPanel server currently uses:

```cron
* * * * * cd /home/alurelab/app.alurelab.com/backend && php artisan schedule:run >> /dev/null 2>&1
```

Run the migration before serving checkout:

```bash
php artisan migrate --force
```

## Provider Setup Required

- Set `BITESHIP_WEBHOOK_SECRET` in the backend environment and use the same value in the Biteship webhook dashboard.
- Set the Xendit invoice callback token to the backend `XENDIT_WEBHOOK_TOKEN` value.
- Confirm both callbacks use the deployed HTTPS API URLs.

## Deployment Status (2026-09-16)

- Backend migration and optimized caches completed.
- Frontend built successfully and PM2 `alurelab-frontend` reloaded on port `3040`.
- Storefront, NextAuth session, and API smoke tests returned `200`.
- Invalid Xendit and Biteship webhook tokens returned `401`.
- Runtime backup: `/home/alurelab/app.alurelab.com.bak_20260916_1122`.
