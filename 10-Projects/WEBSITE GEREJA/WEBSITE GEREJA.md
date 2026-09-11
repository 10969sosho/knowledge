# WEBSITE GEREJA - GMJ Grace Ministry Journey (Church Profile)

## Overview
Website company profile modern untuk gereja **GMJ (Grace Ministry Journey)** di **Blitar, Jawa Timur**. Static website dengan dark minimal aesthetic, parallax scrolling, multi-language (ID/EN/ZH), dan PWA.

## Location
`/Users/10969sosho/PROJECT/WEBSITE GEREJA/`

## Tech Stack
| Layer | Technology |
|-------|-----------|
| Frontend | Vanilla HTML5 + CSS3 + JavaScript |
| CSS | Custom (1436 lines), no framework |
| Animations | AOS.js (Animate On Scroll) CDN |
| PWA | Service Worker (Cache API) |
| Maps | Google Maps embedded iframe |
| Fonts | Playfair Display + Inter (Google Fonts) |
| Icons | Font Awesome (via CDN) |

## Structure
```
WEBSITE GEREJA/
├── index.html                    # Single-page (314 lines, all sections)
├── sw.js                         # PWA service worker (cache-first)
├── README.md                     # (191 lines) comprehensive documentation
├── assets/
│   ├── css/style.css             # (1436 lines) custom CSS
│   ├── js/
│   │   ├── script.js             # (497 lines) loading, carousel, navbar, language, form, scroll
│   │   └── translations.js       # (318 lines) i18n: id/en/zh dictionaries
│   └── img/
│       ├── banner.jpeg           # Hero background
│       └── bg2.png               # About section background
└── assets.zip                    # Packaged assets
```

## Sections

| # | Section | Description |
|---|---------|-------------|
| 1 | **Loading Screen** | Animated spinner "GMJ", fades out 1.5s |
| 2 | **Hero** | Parallax full-screen, "GRACE MINISTRY JOURNEY" title |
| 3 | **Animated Divider** | Auto-scrolling marquee: "BETHANY YESTOYA GMJ" (sage green) |
| 4 | **About** | Background image + centered white overlay text |
| 5 | **Vision & Mission** | 2-column: "Grace, Ministry, Journey" vision + mission statement |
| 6 | **Services Carousel** | 5 service cards (Ibadah Raya, 24 Worship, Chosen Generation, Kidz, GMJ Fams) with prev/next/dots autoplay 5s |
| 7 | **Pastor Section** | PDP. Johannes Depp photo + bio card |
| 8 | **Contact** | Form (name, email, message), Google Maps iframe, address, worship time, social links (Instagram, YouTube, WhatsApp) |

## Features

### Multi-Language (i18n)
- Language switcher in navbar: ID / EN / ZH (flag icons)
- `data-translate` attributes on all translatable content
- 3 full language dictionaries in `translations.js`
- Persisted to LocalStorage

### Interactive
- Parallax scrolling
- Smooth scrolling navigation
- Navbar shadow/color change on scroll
- Hamburger menu (mobile)
- AOS animations (fade-up, fade-left, fade-right)
- Carousel autoplay + navigation

### PWA
- Service Worker cache-first strategy
- Caches HTML, CSS, JS, fonts, AOS CDN
- Offline-capable

### Responsive
- Breakpoints at 768px & 480px
- Stacked layouts on mobile
- Touch-optimized

## Color Palette
- **Primary Green (Sage)**: `#96A78D`
- **Secondary Green**: `#B6CEB4`
- **Light Green**: `#D9E9CF`
- **Background Green**: `#328079`
- **Black**: `#000000`, **White**: `#FFFFFF`
- **Typography**: Gotham, system-ui (uppercase styling)

## Status
Production-ready static website. README berbahasa Indonesia lengkap.


## Related

- [[PROJECT INDEX]]
- [[HTML]]
- [[CSS]]
- [[JavaScript]]
