# ALURE - Software Manajemen Bisnis Modern (Laravel + Filament)

## Overview
ALURE adalah platform SaaS all-in-one untuk mengelola penjualan, pembelian, gudang, keuangan, dan CRM dalam satu dashboard modern. Dibangun dengan Laravel 13 + Filament 4 dengan landing page premium ala Apple/Linear/Stripe.

## Location
`/Users/10969sosho/PROJECT/ALURE/`

## Tech Stack

### Backend
- **Laravel 13** (PHP Framework)
- **PHP 8.3+**
- **Filament 4** - Admin Panel/Dashboard CMS
- **SQLite** - Database (development)
- Session Driver: database
- Queue Connection: database
- Cache Store: database

### Frontend
- **Vite 8** - Build tool
- **Tailwind CSS 4** - Styling
- **Inter** font via Bunny Fonts (weights: 300, 400, 500, 600, 700, 800)
- **GSAP 3.15** + ScrollTrigger - Animations
- **Lenis 1.3** - Smooth scrolling
- **SplitType 0.3** - Text splitting animation
- **Three.js 0.185** - 3D (reserved for future)

### Development Tools
- Laravel Pail (log viewer)
- Laravel Pint (code formatter)
- PHPUnit 12 (testing)

## Structure
```
ALURE/
├── app/
│   ├── Http/Controllers/Controller.php
│   ├── Models/User.php
│   └── Providers/
│       ├── AppServiceProvider.php
│       └── Filament/AdminPanelProvider.php
├── bootstrap/
├── config/ (app, auth, cache, database, filesystems, logging, mail, queue, services, session)
├── database/
│   ├── database.sqlite
│   ├── factories/
│   ├── migrations/
│   │   ├── create_users_table
│   │   ├── create_cache_table
│   │   └── create_jobs_table
│   └── seeders/
├── public/
├── resources/
│   ├── css/app.css      (Tailwind custom: glass, gradient, mask utilities)
│   ├── js/app.js         (GSAP animations, Lenis scroll, SplitType, interactive components)
│   └── views/
│       ├── landing.blade.php  (Main landing page)
│       ├── welcome.blade.php  (Default Laravel welcome)
│       └── layouts/app.blade.php (HTML5 layout with SEO meta)
├── routes/
│   ├── web.php           (Route / → landing page)
│   └── console.php
├── storage/
├── tests/
├── backup/               (Standalone HTML/CSS/JS backup of landing page)
│   ├── images/
│   ├── index.html
│   ├── script.js
│   └── styles.css
├── vendor/
├── node_modules/
├── composer.json
├── package.json
├── vite.config.js
├── Landing.md            (Design brief & specifications)
└── .env
```

## Landing Page Sections (16 sections)

| # | Section | Deskripsi | Animasi |
|---|---------|-----------|---------|
| 1 | **Hero** | Headline, subheadline, CTA, dashboard mockup, trust badges | Text Reveal, Floating Shapes, Parallax |
| 2 | **Logos / Social Proof** | "Dipercaya oleh" - TechCorp, GlobalSoft, DataPro, Innova, Nexus, PrimaSol | Infinite Marquee |
| 3 | **Problems** | "Masih Pakai Excel?" → Data tercecer, salah stok, salah hitung | Sticky Stacking Cards |
| 4 | **Solution** | "Gunakan ALURE" CTA card | Fade |
| 5 | **Feature Grid** | 6 card: Penjualan, Gudang, Laporan & Analitik, CRM, Keuangan, POS | Stagger animation |
| 6 | **Sticky Product Showcase** | Kiri dashboard sticky, kanan feature scroll (Penjualan → Persediaan → Keuangan) | Sticky + Scroll Scrub |
| 7 | **Workflow** | Horizontal scroll: Input Order → Gudang → Pengiriman → Invoice & Laporan | Horizontal Scroll (scrub) |
| 8 | **Benefits** | 4 benefit: Lebih Cepat, Lebih Aman, Lebih Murah, Lebih Mudah | Fade Up |
| 9 | **Integrations** | WhatsApp, Xendit, Shopify, Email, API, Midtrans | Reverse Marquee |
| 10 | **Statistics** | 1000+ Client, 98% Happy, 500K+ Transaction, 99.9% Uptime | Counter Animation |
| 11 | **Testimonials** | 3 card testimonial dengan bintang 5 | Fade Up |
| 12 | **FAQ** | Accordion FAQ | Accordion toggle |
| 13 | **CTA** | Mulai Gratis, Book Demo, Hubungi Kami | Parallax Blob |
| 14 | **Footer** | Links, copyright, CTA sekunder |
| 15 | **Pricing** | (direncanakan: Starter, Professional, Enterprise) | Scale Card |
| — | **Before vs After** | (direncanakan) | — |
| — | **Timeline** | Hari 1 → Hari 7 → Go Live | — |
| — | **Keamanan & Teknologi** | Laravel, Backup, SSL, Role Permission, API | — |

## Admin Panel (Filament)

- **URL**: `/admin`
- **Panel ID**: `admin`
- **Auth**: Login required
- **Color**: Amber primary
- **Pages**: Dashboard
- **Widgets**: AccountWidget, FilamentInfoWidget
- Resources/Pages/Widgets auto-discovered from `app/Filament/`

## Design System

### Colors
- **Primary**: `#7C3AED` (Purple)
- **Accent**: `#F59E0B` (Amber)
- **Background**: `#FAFAFA` (light) / `#09090B` (dark)
- **Muted**: `#F4F4F5` (light) / `#18181B` (dark)
- **Border**: `#E4E4E7` (light) / `#27272A` (dark)

### Typography
- **Font**: Inter (6 weights via Bunny Fonts)
- **Spacing**: 8px system

### Design Tokens
- `glass`: backdrop-blur + semi-transparent background
- `glass-card`: glass + shadow + border
- `text-gradient`: primary → purple → accent gradient
- `text-gradient-primary`: primary → primary-light gradient

## Architecture

### Theme Support
- Dark/Light toggle
- System preference detection (`prefers-color-scheme`)
- localStorage persistence

### SEO
- Meta description, OG tags
- Theme color meta
- SVG favicon

### Animations (via GSAP + ScrollTrigger)
- **Text Reveal**: SplitType words dengan stagger
- **Floating Shapes**: GSAP yoyo loop
- **Marquee**: GSAP infinite xPercent scroll
- **Sticky Cards**: ScrollTrigger reveal
- **Sticky Showcase**: Pin + cross-fade screens
- **Horizontal Scroll**: Scrub pin horizontal track
- **Counters**: Animated number counting
- **Magnetic Buttons**: Cursor-follow hover effect
- **Parallax Blob**: Mouse-follow blob
- **Page Transition**: Fade + slide up on load

### Performance Targets
- LCP < 2.5s
- CLS < 0.1
- INP < 200ms
- Lighthouse 95+

## Design References (from Landing.md)

### Style Inspiration
Apple, Linear, Stripe, Framer, Vercel, Resend, Raycast

### Design Rules
- Modern, Clean, Fast, Premium
- Banyak whitespace, motion elegan
- Max 4 warna utama
- Max 2 jenis font
- Tidak ada animasi berlebihan
- Setiap section 1 fokus animasi

### Asset Resources
- **3D**: Spline, ShapeFest, Craftwork
- **Icons**: Lucide, Heroicons, Phosphor
- **Mockup**: Shots.so, Mockuphone
- **Photos**: Unsplash, Pexels
- **Animation**: Rive, LottieFiles, GSAP
- **Illustration**: Storyset, Blush, ManyPixels
- **Pattern**: Haikei, BGJar, Hero Patterns

## Status
- **In Progress**: Landing page HTML/Blade sudah lengkap (semua section). JS animations selesai.
- **TODO**: Dashboard interaktif, integrasi payment gateway, content management via Filament
- **Backup**: Ada backup standalone HTML/CSS/JS di folder `backup/`


## Related

- [[PROJECT INDEX]]
- [[Laravel]]
- [[Filament]]
