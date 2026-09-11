# CRM Architecture

Laravel 13 + Blade + Bootstrap/SCSS + SQLite. Controller core: `DashboardController`, `LeadController`, `OpportunityController`, `ActivityController`, dan `CustomerController`.

Lead menjadi aggregate utama timeline. Opportunity menjadi Offer/Pipeline. Customer hanya dibuat dari status Deal. Route v1 memakai auth + verified dan ownership `user_id`.

UI memakai status pills, compact data cards, responsive table, mobile sidebar, toast feedback, dan Bootstrap offcanvas untuk input Activity dari kanan.

## Related

- [[CRM]]
- [[CRM Features]]
- [[Laravel]]
- [[Bootstrap]]
