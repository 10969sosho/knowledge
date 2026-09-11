# MAS FERDI - Sector Ngedit / Guitar Sakti (E-Learning Platform)

## Overview
Secret Of Shredding / Sector Ngedit / Guitar Sakti adalah platform e-learning membership untuk kursus video editing dan teknik gitar (shredding). Project client: **Mas Ferdi**.

## Location
`/Users/10969sosho/PROJECT/MAS FERDIDIDIDID/`

## Structure
```
MAS FERDIDIDIDID/
├── Landing_page/
│   └── index.html                    # VSL landing page (1073 lines)
└── WEBSITE MAS FERDI/
    ├── index.html                     # Main homepage
    ├── member-area.html               # Member dashboard
    ├── my-access.html                 # Course access page
    ├── styles.css                     # (890 lines)
    ├── member-styles.css
    ├── script.js                      # (363 lines) - scroll animations, carousel, parallax
    ├── member-script.js
    ├── project-requirements.md        # Full requirements (379 lines)
    ├── README.md                      # Design system docs
    └── sector-ngedit-laravel/         # Laravel 12 backend
        ├── composer.json              # Laravel 12, spatie/permission, socialite, intervention/image, dompdf
        ├── .env                       # DB_DATABASE=gitarsakti, SMTP, Google OAuth
        ├── routes/web.php             # (168 lines)
        ├── app/Http/
        │   ├── Controllers/           # 13+ controllers
        │   │   ├── HomeController, AuthController, MemberController
        │   │   ├── AdminController, OrderController, LessonController
        │   │   └── Admin/ (Auth, LessonContent, ContentBlock, ContentGroup)
        │   └── Middleware/            # AdminMiddleware, MemberMiddleware, CheckVerified, YouTubeCSP
        ├── app/Models/                # 12 models
        └── database/migrations/       # 18 migrations
```

## Tech Stack
| Layer | Technology |
|-------|-----------|
| Backend | Laravel 12, PHP 8.2+ |
| Database | MySQL (`gitarsakti`) |
| Auth | Laravel Socialite (Google OAuth), Email verification |
| Permission | Spatie Laravel Permission |
| PDF | barryvdh/laravel-dompdf |
| Image | Intervention Image |
| Frontend | Blade, Bootstrap 5, Tailwind CSS, Vite |
| Landing Page | HTML5, CSS3, Vanilla JS, Font Awesome 6, Inter font |

## Key Features

### Landing Page
- Video Sales Letter (YouTube embed)
- Countdown timer (evergreen)
- Facebook Pixel tracking
- Lynk.id purchase link
- Parallax effects, Intersection Observer animations

### Membership Platform
| Role | Features |
|------|----------|
| **Guest** | Landing page, view programs, login/register (Google OAuth) |
| **Member** | Dashboard, All Lessons (card grid), Checkout, Upload payment proof, My Lessons, My Orders (status badges), Profile |
| **Admin** | Separate login portal, Lesson CRUD + content management, Order management (verify payment), User management, Announcement, Site settings |

### Order Flow
1. User creates order (Pending)
2. User uploads payment proof (Processing)
3. Admin verifies (Completed) → User gets access to My Lessons

## Models (12)
`User`, `Lesson`, `Order`, `UserLesson`, `Category`, `Announcement`, `Testimonial`, `Certificate`, `Setting`, `LessonContent`, `LessonContentBlock`, `ContentGroup`

## Routes
- **Public**: `/`, `/login`, `/register`, `/auth/google`, `/verification`, `/lessons`, `/lessons/{lesson}`
- **Member**: `/member/dashboard`, `/member/lessons`, `/member/my-lessons`, `/member/orders`, `/member/profile`, `/checkout/{lesson}`
- **Admin**: `/admin/login`, `/admin/dashboard`, `/admin/lessons/*`, `/admin/orders`, `/admin/users`, `/admin/content`


## Related

- [[PROJECT INDEX]]
- [[Laravel]]
- [[MySQL]]
