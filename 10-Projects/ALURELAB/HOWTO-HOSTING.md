# ALURELAB Hosting

## Laravel Scheduler

The backend releases expired inventory reservations every minute. Configure one cPanel cron entry:

```cron
* * * * * cd /path/to/backend && php artisan schedule:run >> /dev/null 2>&1
```

Run the migration before serving checkout:

```bash
php artisan migrate --force
```

## Provider Setup Required

- Set `BITESHIP_WEBHOOK_SECRET` in the backend environment and use the same value in the Biteship webhook dashboard.
- Set the Xendit invoice callback token to the backend `XENDIT_WEBHOOK_TOKEN` value.
- Confirm both callbacks use the deployed HTTPS API URLs.
