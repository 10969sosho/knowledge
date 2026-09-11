# CVSS - Company Portfolio & All Projects

## Overview
CVSS adalah agency/company yang membangun berbagai aplikasi web, mobile, dan landing page untuk klien. Folder ini berisi **40+ project** dengan tech stack utama Laravel, Laravel Filament, Next.js, dan static HTML/CSS/JS.

## Location
`/Users/10969sosho/PROJECT/CVSS/`

### Notes Project per-Proyek
- **DEMO** → [[DEMO]] (HardwareShop e-commerce: Next.js + Laravel; fitur alamat 1x, Midtrans, admin panel)
- **WEBSITE AGENCY** → [[WEBSITE AGENCY/WEBSITE AGENCY]] (Otherlands cinematic production house homepage: static HTML/CSS/JavaScript + canvas kaleidoscope)
- **WEBSITE KECANTIKAN** → [[WEBSITE KECANTIKAN/WEBSITE KECANTIKAN]] (Rizki Beauty Clinic premium multi-page static HTML/CSS/JavaScript demo)

## Top-Level Structure
```
CVSS/
├── CAMPAIGN ADS/      (3 static HTML campaign landing pages)
├── ECOMMERCE_BARU/    (1 Laravel + Filament e-commerce besar)
├── EXPLORE/           (3 eksperimental projects: ERP, Threads, Chatbot)
├── ON PROGRES/        (1 project: Pak Joni Ecommerce)
├── ON_PROGRES/        (7 active client projects)
├── PORTOFOLIO/        (20+ portfolio/showcase projects)
├── PRIBADI CVSS/      (7 internal CVSS tools)
├── SUDAH_TAYANG/      (8 completed/deployed projects)
└── WEBSITE RINGAN/    (static HTML/CSS/JS demos)
```

### Website Ringan

`WEBSITE RINGAN/` berisi website static yang ringan dan tidak memerlukan runtime backend:

- `WEBSITE AGENCY/` — Otherlands cinematic production house
- `WEBSITE KECANTIKAN/` — Sebu Clinic multi-page static demo
- `WEBSITE KOSMETIK/` — ÉLORA cosmetic brand static demo

---

## 1. CAMPAIGN ADS

| Project | Type | Files |
|---------|------|-------|
| **ECOMMERCE** | E-commerce campaign | index.html, detail.html, style.css, script.js, 25+ images |
| **PORTO FASHION** | Fashion portfolio | 6 pages (index, about, collection, contact, lookbook, new-arrival), animation.css, responsive.css, style.css, animation.js, main.js, slider.js |
| **PORTO HOTEL** | Hotel portfolio | 7 pages (contact, dining, experience, gallery, rooms, story), animation.css, pages.css, responsive.css, booking.js, components.js |
| **PORTO MAKAN** | Restaurant portfolio | 7 pages (contact, experience, gallery, menu, reservation, story), animation.css, responsive.css, menu.js |

### 1.1 LANDING (Next.js landing — conversion-focused)

- Repo: `landingcvss` (https://github.com/Gen-ei-Ryodan/landingcvss)
- Status: active, campaign-ready
- **Tujuan:** landing page conversion tinggi utk traffic Meta Ads / Google Ads → output WhatsApp Leads.
- **Tech stack:** Next.js 15 (App Router) + TypeScript, Tailwind CSS v4, shadcn/ui, GSAP + ScrollTrigger, Lenis (smooth scroll), SplitType (text reveal), Framer Motion (testimoni).
- **Struktur:** `src/components/{layout,sections,ui,providers}`, `src/hooks/use-scroll-reveal.ts`, `src/lib/{content,site,gsap,utils}.ts`.
- **Struktur:** Hero, Permasalahan, Akibat, Solusi, Testimoni, Hasil (before/after), Cara Kerja, Paket Harga, Dokumentasi, FAQ, Form Konsultasi, CTA Penutup + Footer + sticky CTA.
- **Design direction:** editorial agency modern, electric cobalt, Font Space Grotesk, glassmorphism, noise, dot-grid, animated marquee.
- **Assets:** `public/images/` (logo favicon `1.png`→`logo.png`, `before.webp`/`after.webp`, foto editorial hero/gallery).
- **Config penting:** `src/lib/site.ts` (nomor WhatsApp, email `hi@solusisurabaya.com`, IG `@cvsolusisurabaya`, alamat & gmaps). Konfigurasi ini wajib diisi sebelum go-live.
- **Conversion flow:** CTA umum mengarah ke form dan mengirim event Meta `Search`; hanya submit form dan CTA penutup yang membuka WhatsApp langsung.
- **Deployment:** SSH `alurelab` → `~/repositories/landingcvss`; domain `digital.solusisurabaya.com`; panduan ada di `DEPLOYMENT.md`.

---

## 2. ECOMMERCE_BARU
**Laravel + Filament Marketplace E-commerce** (project besar)

### Tech Stack
- Laravel + Filament Admin Panel
- Livewire
- Tailwind CSS
- Midtrans Payment Gateway
- Vite, PostCSS
- Playwright (Browser testing)

### Key Features
- Multi-role: Admin (Filament), Customer (storefront)
- Product management (status enum: DRAFT, ACTIVE, INACTIVE)
- Order management (status: PENDING, PROCESSING, SHIPPED, DELIVERED, CANCELLED)
- Payment integration (status: PENDING, PAID, FAILED)
- Shopping cart system
- Return management
- Category management
- Banner & Settings management
- Storefront Blade views

### Models
User, Product, Order, Cart, Category, Banner, Setting, + 12 more

### Documentation
- README.md, REQUIREMENT.md, STYLE.md, AGENTS.md

---

## 3. EXPLORE (Experimental Projects)

### 3.1 ERP
Full-stack monorepo:
- **Backend**: Laravel
- **Frontend**: Next.js (TypeScript, pnpm)
- **Docs**: 50+ markdown files (00-VISION.md through 50-DEVELOPER-GUIDE.md)
- Vision/planning documentation for an ERP system

### 3.2 THREADS
**Node.js/Express WhatsApp Automation**
- Sends WhatsApp messages via WAHA API
- Playwright for automation
- Lead management (leads.json, sent.json, session.json)
- Configurable keywords (config/keywords.json)
- Express server with public dashboard

### 3.3 WEBSITE_CHATBOT
Static HTML/CSS/JS chatbot UI

### 3.4 landing_chatbotv1
Static landing page with chatbot (TT Hoves Pro Trial font)

---

## 4. ON PROGRES (with space)
1 project:

| Project | Client | Type | Stack |
|---------|--------|------|-------|
| **PAK JONI / ECOMMERCE** | Pak Joni | E-commerce | Laravel + Filament |

---

## 5. ON_PROGRES (Active Client Projects)
7 projects currently in development:

### 5.1 ABSEN VGEN
**Attendance & Payroll System** (Laravel + Filament)
- 14 Models: Employee, Attendance, Payroll, Salary, Shift, etc.
- Modules: Attendance, Employee, Payroll, Salary, Workflow
- 12 Services: AttendanceCalculation, PayrollGenerate, SlipGaji, etc.
- 21 migrations, 12 factories
- 14 Feature tests, 9 Unit tests
- API routes (api.php)
- 8 docs: API_REFERENCE, ARCHITECTURE, BUSINESS_RULES, CHANGELOG, CODING_STANDARDS, DATABASE, PROJECT_CONTEXT, STYLING
- Payroll config, shift management, salary components
- DOMPDF for PDF generation (slip gaji)
- Spatie packages

### 5.2 BU VANIA
Two Laravel projects:
- **2. PROGRAM FORMULA** - Formulation program (only storage/logs remaining)
- **3. ABSEN MESIN (ADMS)** - Attendance Machine System
  - 6 docs: ADMS_STANDAR, API_DOCUMENTATION, DEPLOYMENT, DOKUMENTASI_LENGKAP, README, TROUBLESHOOTING
  - Full Laravel application with deploy/ scripts

### 5.3 PAK EFFENDI / GYM
**Digital Member Portal - Xtreme Fitness Center** (Laravel 13 + Tailwind CSS + SQLite)
- WhatsApp OTP login, digital member card (bg.png), payment history, notifications
- Admin panel (CRUD Members, Payments, Notifications)
- Mobile-first dark theme + bottom navbar
- Deploy: `gym.alureflow.com` | SSH: `alurelab` → `repositories/gym`
- **Docs**: [[GYM]], [[ARCHITECTURE_GYM]], [[DATABASE_GYM]], [[DEPLOYMENT_GYM]], [[CVSS/GYM/Features|Features]], [[CVSS/GYM/Recent Updates|Recent Updates]]

### 5.4 PAK JONI / ECOMMERCE
**E-commerce** (Laravel + Filament + Livewire)
- AGENTS.md, README.md, REVISION.md
- API routes, Midtrans integration
- Helpers, Services layer
- Deploy script (deploy.sh)
- Dusk browser testing
- 7 docs: API_REFERENCE, ARCHITECTURE, BUSINESS_RULES, CHANGELOG, CODING_STANDARDS, DATABASE, PROJECT_CONTEXT

### 5.5 PAK TEDDY
Static HTML reports + Demo Laravel project:
- **HTML Pages**: approval-report, dashboard, email-blast, email-checking, laporan-kerja, monitoring-tugas, perencanaan-mingguan
- **DEMO**: Laravel project with Breeze auth starter, Spatie Permissions, DOMPDF, barryvdh packages

### 5.6 PAK TJENDRAWAN
- **V1**: Only storage/logs remaining

### 5.7 PENANGKALPETIR (Jaya Petir)
**Lightning Rod Company Website** (Laravel + Filament)
- 22 Models: AboutSection, Article, ArticleCategory, City, CityLanding, Contact, Faq, HeroSection, Message, Product, ProductCategory, Project, ProjectCategory, Province, SeoMeta, Service, Setting, Testimonial, User, Visitor, WhyChooseUs
- 27 migrations
- 8 seeders (Admin, ArticleCity, City, Database, DummyData, GeneratedFromSqlite, InitialData, Province)
- Internal linking & SEO services
- Media Library (Spatie)
- Permission management
- Visitor tracking
- Separate SQLite database: jayapetir.sqlite

---

## 6. PORTOFOLIO
20+ showcase/dummy projects:

| # | Project | Type | Detail |
|---|---------|------|--------|
| 1 | **ARTIKEL** | Static blog | about, article-detail, articles, book-detail, contact, home, shop |
| 2 | **CVSS dummy** | Agency dummy templates | 16 templates: Car Rental, Digital Agency, E-Commerce, Event Organizer, Fitness Gym, Guesthouse, Hospital, Hotel Booking, Interior Design, Online Course, Photography, Real Estate, Restaurant, SaaS Startup, Travel Tour, Wedding Organizer |
| 3 | **GIRLFRIEND** | Laravel | Simple Laravel web app |
| 4 | **LANDING/umkm** | Static | UMKM landing page |
| 5 | **PhotoBox** | Flutter + Laravel | Photo booth app with Android APK + Web backend |
| 6 | **PHOTOBOX_APK** | Flutter/Dart | Android photo booth app with UVC camera plugin |
| 7 | **PHOTOBOX_WEB** | Laravel + Filament | Photo booth web admin + API |
| 8 | **PROGRAM BARBERSHOP** | Static | Barbershop landing page |
| 9 | **PROGRAM DISTRIBUTOR** | Static | Distributor landing page |
| 10 | **PT DARA BOGA NUSANTARA** | Static | F&B company landing page with image cropper |
| 11 | **RENTAL** | Static | Car rental landing page with video |
| 12 | **TOUR** | Static | Tour landing page |
| 13 | **WEBSITE CONTOH** | Static | Example gallery showcase |
| 14 | **WEBSITE L KIDS** | Static | Kids fashion e-commerce |
| 15 | **WEWBSITE CVSS** | Static | CVSS agency portfolio website (5 pages: about, contact, portfolio, services) with animation guide |
| 16 | **XAVIER** | Static | Image gallery |
| 17 | **parfume** | Static | Perfume e-commerce (6 pages) |

### PhotoBox Details
- **APK**: Flutter/Dart Android app
- **WEB**: Laravel + Filament admin with photo templates (1-4 photos)
- **AGENTS.md**, **REQUIREMENT.md**, **PROJECT_OVERVIEW.md**
- **Docs**: [[PhotoBox]], [[DEPLOYMENT_PHOTOBOX]], [[BUGS_PHOTOBOX]]
- **29 templates** (1x 1-photo, 9x 2-photo, 9x 3-photo, 10x 4-photo)
- **Deploy**: SSH `alurelab` → `repositories/photobox` | Domain: `photobox.alureflow.com`
- **PENTING**: Slot positions unik per template (auto-detect dari area transparan border PNG)
- Photo templates in `templates/` folder

---

## 7. PRIBADI CVSS (Internal Tools)
7 internal projects:

### 7.1 ALUREFLOW
**Next.js** landing page with:
- AuroraBackground animation component
- CustomCursor
- SmoothScroll (Lenis)
- NoiseOverlay
- Navbar
- Section components
- UI library components

### 7.2 ALURELAB
**Next.js** project with:
- Static export to `out/` folder
- Similar component structure

### 7.3 COMPRO
Company profile (static + REFERENCE folder)

### 7.4 CRM
**Laravel CRM System** (internal sales workspace, v1 focused)
- Core flow: Leads -> Follow-up -> Offers -> Deal/Lost -> Customers
- Six areas: Dashboard, Leads, Pipeline, Activities, Offers, Customers
- Pipeline value, revenue, source performance, and follow-up tasks
- Activity timeline per lead and automatic conversion to Customer after Deal
- Blade + Bootstrap/SCSS responsive UI with offcanvas activity input
- Project docs: `PROJECT_CONTEXT.md`, `ARCHITECTURE.md`, `BUSINESS_RULES.md`, `DATABASE.md`, `API_REFERENCE.md`, `CHANGELOG.md`
- Obsidian notes: [[CRM]], [[CRM Features]], [[CVSS/CRM/Architecture|Architecture]], [[CVSS/CRM/Recent Updates|Recent Updates]]

### 7.5 TASK
**Full-stack Task Management App**
- **Backend**: Laravel (API with Sanctum auth, CORS)
- **Frontend**: Next.js (AGENTS.md, CLAUDE.md, zustand state, lucide-react icons)
- FEATURES.md, README.md, task.md

### 7.6 TES
Empty folder (test/sandbox)

### 7.7 WEBSITE LANDING
Static landing page

### 7.8 WEBSITE PENCATATAN / project-tracker
**Laravel Project Tracker**
- Spatie Permissions
- Laravel Sanctum
- DOMPDF (barryvdh)
- Maatwebsite Excel
- PHPSpreadsheet
- Pusher (real-time)
- COLLABORATIVE_DOCS_SETUP.md

---

## 8. SUDAH_TAYANG (Completed/Deployed)
8 completed projects organized by client:

### 8.1 BU VANIA
| # | Project | Type | Detail |
|---|---------|------|--------|
| 1 | **1. PROGRAM GAJI** | Laravel Payroll | Full payroll program, Spatie Permissions, 13 configs, docs |
| 2 | **2. PROGRAM FORMULA** | Laravel Formulation | Formulation program with Dusk testing, API, deploy script |

### 8.2 PAK EFENDI
| # | Project | Type | Detail |
|---|---------|------|--------|
| 1 | **KENEAS COUNTDOWN** | Laravel App | Firebase, JWT auth, activity log, DataTables, Scout/Algolia, Docker, Twilio, MAATwebsite Excel |
| 2 | **[[PTPAS/PTPAS\|PAS]]** | Product Sales System | Backend (Laravel 12) + Frontend (Blade + Bootstrap), dual guard auth (web/customer), CartService, RemoteStockService (SQL Server 2005), featured/new products via status_product, 6-digit cart qty, per-item notes, hero banner carousel, 7 docs |
| 3 | **PROSPEDITY** | Laravel Multi-language | en/fr/id localization, AGENTS.md, payment config |
| 4 | **RAIJIN** | Laravel App | Standard Laravel app, serve.sh, raw_test.php |

### 8.3 PAK RUDI / Liefmart
**E-commerce Monorepo**
- Laravel backend apps: `hgn`, `livemart`
- Next.js frontend: `livemart-frontend`
- Shared composer package
- Standarisasi analytics Python script
- DEPLOYMENT.md

### 8.4 PAK TJENDRAWAN / V1
**Laravel + Filament** application (deployed build only)

### 8.5 hkm
Static company profile (Archive.zip, pictures of Belfoods, Sreeya, Sunpride)

### 8.6 YMIITS
**Yayasan Manarul Ilmi ITS website and CMS** (Laravel 9 + Blade + MySQL)
- Standardized Laravel root layout with dedicated `public/` web root
- Deploy: SSH `alurelab` -> `repositories/ymiits`; domain `ymiits.com`
- Documentation: [[CVSS/YMIITS/YMIITS|YMIITS]], [[CVSS/YMIITS/Recent Updates|Recent Updates]]

---

## Tech Stack Summary

| Technology | Project Count | Key Projects |
|------------|---------------|--------------|
| **Laravel** | ~20 | ECOMMERCE_BARU, ABSEN VGEN, PENANGKALPETIR, CRM, ADMS, TASK backend, PROGRAM GAJI, PROGRAM FORMULA, KENEAS, PAS, PROSPEDITY, RAIJIN, Liefmart, GYM, DEMO, GIRLFRIEND, PhotoBox_WEB, project-tracker |
| **Laravel + Filament** | ~6 | ECOMMERCE_BARU, ABSEN VGEN, PAK JONI/ECOMMERCE, PENANGKALPETIR, PhotoBox_WEB, PAK TJENDRAWAN/V1 |
| **Next.js** | 4 | ERP frontend, TASK frontend, ALUREFLOW, ALURELAB |
| **Flutter/Dart** | 1 | PhotoBox APK |
| **Node.js/Express** | 1 | THREADS (WhatsApp bot) |
| **Static HTML/CSS/JS** | 20+ | All CAMPAIGN ADS, most PORTOFOLIO, hkm, chatbot, landing pages |

### Common Dependencies Across Laravel Projects
- **Filament** (admin panel)
- **Livewire** (reactive components)
- **Spatie** (permissions, media-library, activitylog)
- **DOMPDF / barryvdh** (PDF generation)
- **Midtrans** (payment gateway)
- **Maatwebsite/Laravel-Excel** (Excel import/export)
- **Tailwind CSS** (styling)
- **Vite** (asset bundling)
- **Standard 7-doc system**: API_REFERENCE, ARCHITECTURE, BUSINESS_RULES, CHANGELOG, CODING_STANDARDS, DATABASE, PROJECT_CONTEXT

### Clients
- Bu Vania (payroll, formula, attendance machine)
- Pak Joni (e-commerce)
- Pak Effendi (gym, countdown, attendance, prospedity, raijin)
- Pak Teddy (reports, demo)
- Pak Tjendrawan (lightning rod, general)
- Pak Rudi (Liefmart marketplace)


## Related

- [[PROJECT INDEX]]
- [[ADMS/ADMS]]
- [[PAK JONI ECOMMERCE/PAK JONI ECOMMERCE]]
- [[CVSS/CRM/CRM]]
- [[CVSS/DEMO/DEMO]]
- [[CVSS/GYM/GYM]]
- [[CVSS/PhotoBox/PhotoBox]]
- [[CVSS/PTPAS/PTPAS]]
- [[CVSS/SISTEM/SISTEM]]
