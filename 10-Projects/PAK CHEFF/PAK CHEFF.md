# PAK CHEFF - Multi-Project Portfolio

## Overview
Portofolio project untuk client **Pak Cheff**, mencakup 6+ project terpisah: website korporat, e-commerce kopi, ferry booking system, marketplace, dan tool bisnis.

## Location
`/Users/10969sosho/PROJECT/PAK CHEFF/`

---

## 1. BSA (Branding Support Asia) - `web/`

**Corporate Website untuk branding agency.**

### Tech Stack
- Laravel 13 + Filament 5.7 admin panel
- MySQL (`BSA`)
- Blade + GSAP animations + Lenis smooth scroll + AOS.js
- Static HTML backup di `asset/`

### Models (9)
`User`, `Section`, `Service`, `Project`, `TrustedLogo`, `HomeService`, `Career`, `Article`, `ContactMessage`

### Pages
Home, About, Services/{slug}, Project, Career/{slug}, Contact, Artikel/{slug}, Under Construction

### Features
- Video background hero
- Typing headline animation ("IT'S ALL ABOUT YOUR BUSINESS")
- Service detail pages
- Project portfolio
- Career listings
- Article/blog section
- Contact form
- GSAP ScrollTrigger + Lenis smooth scroll

---

## 2. Benny Loves Coffee - `_bennylovescoffee.id/`

**E-Commerce platform untuk bisnis kopi. Production-grade, deployed.**

### Tech Stack
- Laravel 12 + Laravel Sanctum + Laravel Socialite + Laravel UI
- MySQL (`u775023099_kopi`)
- Deployed di `https://bennylovescoffee.id`

### Models (17)
`User`, `Product`, `ProductVariant`, `Category`, `Brand`, `Cart`, `Order`, `OrderItem`, `FlashSale`, `FlashSaleItem`, `FeaturedProduct`, `Banner`, `BannerSection2`, `Article`, `Message`/`Chat`, `EmailVerification`

### Key Features

**Customer:**
- Product catalog with categories & brands
- Shopping cart (add/update/remove/clear)
- Checkout
- Payment proof upload
- Order tracking
- Shipping integration (Biteship API - area search & rates)
- Google OAuth login
- Email verification
- Real-time chat with admin

**Admin:**
- Dashboard metrics
- User management CRUD
- Category/Brand CRUD
- Flash sale management (with slots & toggle)
- Banner management (create/delete/toggle/reorder)
- Featured products (CRUD + search + order)
- Product CRUD with photo management
- Order management (status, tracking, cancel, deliver)
- Multi-user chat management
- Client list, Profile management

**Routes:** 171 lines, full RESTful for both customer & admin

---

## 3. Auralis 8 Ship Ticketing - `TIKET kapal/ship-ticketing/`

**International Ferry Booking System (Malaysia-Philippines route).**

### Tech Stack
- Laravel 13 + Filament 5.6 + Spatie Permission 7.4
- barryvdh/laravel-dompdf (PDF/e-ticket)
- QR Code generation
- PHP 8.3+
- Deployed di `https://auralis8.com`

### Models (21)
`User`, `Route`, `Schedule`, `Vessel`, `Booking`, `BookingPassenger`, `Ticket`, `Payment`, `Refund`, `Promo`, `BoardingLog`, `DeportationManifest`, `DeportationPassenger`, `Document`, `PassengerProfile`, `Notification`, `AuditLog`, `AgeCategory`, `ScheduleAgePrice`, `Setting`, `DeportationAnalytics`

### Route
Bongao, Tawi-Tawi (Philippines) ↔ Lahad Datu, Sabah (Malaysia)

### 5 User Roles

| Role | Function |
|------|----------|
| **Passenger** | Register, search schedule, book (max 8 passengers), upload passport, pay (FPX/EWallet/Banking), download e-ticket PDF with QR, request refund |
| **Boarding Officer** | QR scan boarding, manual code validation, view boarding manifest |
| **Deportation Officer** | Create deportation manifests, add passengers, QR scan for deportation boarding |
| **Ticket Counter** | Manual booking for offline passengers, cash payment processing |
| **Admin** | Full CRUD: Vessels/Routes/Schedules/Users/Promos, approve/reject refunds, audit logs, broadcast notifications |

### Key Flows
- Guest booking (without login)
- 30-minute payment expiry window
- Auto-promo application
- QR encrypted tickets
- H-6 refund policy (25% refund)
- Separate regular/deportation boarding

### Documentation
- README (397 lines) - complete flow
- Blueprint (1565 lines)
- Client SOP (249 lines)

---

## 4. UPTOU Marketplace - `UPTOU/`

**Marketplace platform ala Tokopedia. Multi-codebase.**

### Codebases
1. **`UPTOU LARAVEL/backend/`** - Laravel 12 API (Sanctum, OTP buyer, seller management, products, cart, checkout, chat) + BUYER_GUIDE.md (386 lines) + SELLER_GUIDE.md
2. **`uptou-homepage/`** - Golang (Go 1.23, Fiber v2, Ent ORM, PostgreSQL, JWT) landing page
3. **`UPTOU PULL/`** - Golang (Go 1.23, Fiber v2, Ent ORM, PostgreSQL, JWT, Firebase, Docker, Google Cloud Build) full backend + TypeScript frontend

### Features
- Buyer: OTP registration/login, profile, addresses, product browsing, cart, checkout
- Seller: Registration, store management, product CRUD, order management
- Chat: Buyer-seller communication
- API-based architecture

---

## 5. Asset & Others
- `asset/` - Static HTML/CSS/JS for BSA landing page (typing effect, GSAP, Lenis)
- Other client tools/utilities


## Related

- [[PROJECT INDEX]]
- [[Laravel]]
- [[Filament]]
- [[Golang]]
