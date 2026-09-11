# TESTING APK - Business ERP (Laravel + Sanctum API)

## Overview
Sistem Business ERP dengan customer management module. Backend untuk mobile app (Sanctum API) + web admin panel (Blade + Bootstrap). URL deploy: `https://laravel.digitalblitar.com`.

## Location
`/Users/10969sosho/PROJECT/TESTING APK/business-erp/`

## Tech Stack
| Layer | Technology |
|-------|-----------|
| Backend | Laravel 12.0, PHP 8.2+ |
| API Auth | Laravel Sanctum 4.3 (token-based) |
| Web Auth | Custom LoginController (session) |
| Frontend | Blade + Bootstrap 5 Icons + Tailwind CSS v4 |
| JS | Axios 1.11 |
| Build | Vite 7 |
| Database | MySQL (`apk`) |
| Dev Tools | Laravel Sail (Docker), Pint, Pail |

## Structure
```
business-erp/
├── app/
│   ├── Http/Controllers/
│   │   ├── Auth/LoginController.php        (show, authenticate, logout)
│   │   ├── Api/
│   │   │   ├── AuthController.php          (login→token, logout→revoke, GET user)
│   │   │   └── CustomerController.php      (JSON CRUD + search + pagination)
│   │   ├── CustomerController.php          (Web CRUD + search + pagination)
│   │   └── DashboardController.php         (KPI: total & today customers + recent 5)
│   ├── Http/Requests/
│   │   └── CustomerRequest.php             (validation rules)
│   └── Models/
│       ├── Customer.php                    (name, email, phone, address)
│       └── User.php                        (HasApiTokens)
├── database/migrations/                    # 5 migrations
└── resources/views/                        # dashboard, login, customers CRUD + admin layout
```

## Key Features

### Web Panel
- **Dashboard**: Total customers, today's new customers, recent 5 activities table
- **Customer CRUD**: Create/edit/delete with Bootstrap modals, search by name/email/phone, pagination (10/page)
- **Auth**: Custom LoginController (session-based)
- **UI**: Bootstrap 5 Cards, bootstrap-icons, responsive tables, modal confirmations

### REST API (Sanctum)
| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| POST | `/api/login` | Guest | Returns user + plainTextToken |
| POST | `/api/logout` | Sanctum | Revokes current token |
| GET | `/api/user` | Sanctum | Returns authenticated user |
| GET | `/api/customers` | Sanctum | List/search (paginated) |
| POST | `/api/customers` | Sanctum | Create customer |
| GET | `/api/customers/{id}` | Sanctum | Show customer |
| PUT | `/api/customers/{id}` | Sanctum | Update customer |
| DELETE | `/api/customers/{id}` | Sanctum | Delete customer |

### Form Validation (`CustomerRequest`)
- `name`: required
- `email`: required, unique
- `phone`: nullable
- `address`: nullable

## Models (2 custom)
`Customer` (name, email, phone, address), `User` (HasApiTokens)

## Database
- `users`, `personal_access_tokens` (Sanctum)
- `customers` (name, email unique, phone nullable, address nullable)

## Status
MVP - berfungsi sebagai backend testing untuk APK. URL deploy aktif di `laravel.digitalblitar.com`.


## Related

- [[PROJECT INDEX]]
- [[Laravel]]
- [[Sanctum]]
