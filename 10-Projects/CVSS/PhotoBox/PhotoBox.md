# PHOTOBOX

## Overview
Aplikasi photo booth yang terdiri dari web backend (Laravel + Filament admin + API) dan Android APK (Flutter/Dart). Target device: tablet Android dengan USB camera. Output: photo strip 600×1800px (2×6 inch, 300 DPI) + print layout 1200×1800px (4×6 inch) + PDF.

## Location
- **Web source**: `/Users/10969sosho/PROJECT/CVSS/PORTOFOLIO/PhotoBox/PHOTOBOX_WEB/`
- **APK source**: `/Users/10969sosho/PROJECT/CVSS/PORTOFOLIO/PhotoBox/PHOTOBOX_APK/`
- **Foto template source**: `/Users/10969sosho/PROJECT/CVSS/PORTOFOLIO/PhotoBox/foto/`
- **Git remote**: `https://github.com/10969sosho/photobox.git` (branch `main`)

## Tech Stack
| Layer | Teknologi |
|-------|-----------|
| Backend | Laravel 13.x (`^13.8`) |
| PHP | `^8.3` |
| Admin Panel | Filament v3 (`^3.2`) |
| Frontend (APK) | Flutter/Dart |
| Database | MySQL (prod) / SQLite (local) |
| Image Processing | Intervention Image 4.x (`^4.1`) |
| PDF | DomPDF (`barryvdh/laravel-dompdf ^3.1`) |
| Build Tool | Vite 8.x |
| Testing | PHPUnit 12.x |

## Architecture

```
Tablet Android (Flutter APK)
    ↓ USB Camera / Built-in Camera
    ↓ HTTP API
Laravel Application (Server / Mini PC)
    ├── Template API (list, show)
    ├── Session API (create, upload photo, finish)
    ├── Image Processing (Intervention)
    │   ├── composeStrip() — 600×1800px
    │   └── composePrintLayout() — 1200×1800px
    └── PDF Generator (DomPDF) — 4×6 inch landscape
    ↓
Output: strip.jpg, print.jpg, print.pdf
```

### Layers
| Layer | Lokasi | Peran |
|-------|--------|-------|
| Admin | `app/Filament/Resources/` | CRUD template, session, settings via Filament v3 |
| API | `app/Http/Controllers/Api/` | TemplateController, PhotoController (untuk APK) |
| Web Controller | `app/Http/Controllers/PhotoboxController.php` | Flow web (iPad/browser) |
| Service | `app/Services/` | ImageProcessingService, PdfService, PhotoSessionService |
| Model | `app/Models/` | Template, PhotoboxSession, Photo, Setting |
| Views | `resources/views/photobox/` | Blade (index, templates, layout, capture, preview, result) |

## Database Schema

### `templates`
| Column | Type | Notes |
|--------|------|-------|
| `id` | bigint PK | |
| `name` | string(255) | Nama template |
| `slug` | string(255) | unique, auto-generated dari name |
| `thumbnail_path` | string? | path ke thumbnail |
| `border_path` | string? | path ke PNG border/overlay (600×1800) |
| `supported_layouts` | json | Array layout yang didukung, contoh: `[2]` atau `[1,2,3,4]` |
| `photo_config` | json? | `{slots: [{x, y, width, height}, ...]}` |
| `is_active` | boolean | default true |
| `sort_order` | integer | untuk ordering |

### `photobox_sessions`
| Column | Type | Notes |
|--------|------|-------|
| `id` | bigint PK | |
| `template_id` | bigint FK | → templates |
| `layout` | tinyint | 1, 2, 3, atau 4 |
| `photo_count` | tinyint | sama dengan layout |
| `status` | string | started / capturing / preview / completed / cancelled |
| `session_code` | string(12) | unique, random |
| `completed_at` | timestamp? | |

### `photos`
| Column | Type | Notes |
|--------|------|-------|
| `id` | bigint PK | |
| `photobox_session_id` | bigint FK | → photobox_sessions |
| `photo_number` | tinyint | urutan foto (1-based) |
| `original_path` | string | path ke file foto |

### `settings`
| Column | Type | Notes |
|--------|------|-------|
| `id` | bigint PK | |
| `key` | string | unique |
| `value` | text | |

Default settings: `default_countdown=3`, `default_photo_count=2`, `output_quality=90`, `session_retention_days=30`, `photobox_name=Photobox`.

## Template System

### Struktur
Setiap template = satu jumlah foto (1, 2, 3, atau 4). Satu template bisa mendukung multiple layout tapi biasanya satu template = satu layout.

### 4 Konfigurasi Standar (600×1800)

**HANYA 4 konfigurasi**, semua template dengan jumlah foto sama pakai positions yang identik.

**1-photo**:
```php
[['x'=>25,'y'=>218,'width'=>553,'height'=>775]]
```

**2-photo**:
```php
[['x'=>131,'y'=>92,'width'=>355,'height'=>514],
 ['x'=>124,'y'=>768,'width'=>355,'height'=>526]]
```

**3-photo**:
```php
[['x'=>78,'y'=>190,'width'=>444,'height'=>341],
 ['x'=>78,'y'=>605,'width'=>444,'height'=>341],
 ['x'=>78,'y'=>1019,'width'=>444,'height'=>340]]
```

**4-photo**:
```php
[['x'=>64,'y'=>124,'width'=>467,'height'=>287],
 ['x'=>64,'y'=>461,'width'=>467,'height'=>287],
 ['x'=>64,'y'=>799,'width'=>467,'height'=>287],
 ['x'=>64,'y'=>1136,'width'=>467,'height'=>286]]
```

### Z-Index (Composition Order)
1. **Canvas kosong** 600×1800 (putih)
2. **Foto** di-insert ke slot positions → layer belakang
3. **Border PNG** di-insert sebagai overlay → layer depan (transparan)

Border sumber dinormalisasi ke 600×1800 sebelum dijadikan overlay. Ini mencegah border 591×1772 atau 738×2215 terpotong dan memastikan foto tepat di belakang jendela transparan.

### Key Files
- `app/Services/ImageProcessingService.php` — `composeStrip()`, `composePrintLayout()`
- `app/Models/Template.php` — model dengan `photo_config['slots']`, accessor `px/py/pw/ph`
- `app/Filament/Resources/TemplateResource.php` — admin form (name, slug, border_path, supported_layouts, photo position)
- `app/Http/Controllers/Api/TemplateController.php` — API untuk APK (index, show)
- `app/Http/Controllers/Api/PhotoController.php` — API session (createSession, uploadPhoto, finishSession)

## API Endpoints

### Template API (untuk APK)
| Method | URI | Action |
|--------|-----|--------|
| GET | `/api/templates` | List semua template aktif |
| GET | `/api/templates/{template}` | Detail template |

### Session API (untuk APK)
| Method | URI | Action |
|--------|-----|--------|
| POST | `/api/sessions` | Create session (template_id, layout) |
| POST | `/api/sessions/{session}/photos` | Upload photo (photo_number, image file) |
| POST | `/api/sessions/{session}/finish` | Finish session → generate strip, print, PDF |
| GET | `/api/sessions/{session}` | Get session status & photos |

### Web Routes
| Method | URI | Action |
|--------|-----|--------|
| GET | `/` | Landing page |
| GET | `/templates` | Template selection |
| POST | `/select-template` | Select template |
| GET | `/templates/{template}/layouts` | Layout selection |
| POST | `/start-session` | Start session |
| GET | `/capture/{session}` | Capture page |
| POST | `/capture/{session}/save` | Save photo |
| GET | `/preview/{session}` | Preview |
| POST | `/preview/{session}/finish` | Finish |
| GET | `/result/{session}` | Result page |
| GET | `/download/{session}/pdf` | Download PDF |
| GET | `/download/{session}/strip` | Download strip JPG |
| GET | `/download/{session}/mobile` | Download mobile JPG |
| GET | `/session/{session}/image/{type}` | Serve image (strip.jpg, print.jpg, print.pdf) |
| GET | `/serve/photobox/{path}` | Serve template file |

## Deployment

### Environment Target
| Item | Nilai |
|------|-------|
| SSH Host | `alurelab` (alias) |
| Server | `emerald.hidden-server.net` |
| Port | `31988` |
| SSH login | `alurelab` |
| Repository dir | `/home/alurelab/repositories/photobox` |
| Git remote | `https://github.com/10969sosho/photobox.git` |
| Branch | `main` |
| URL | `https://photobox.alureflow.com` |

> **Deploy otomatis**: jalankan `./deploy.sh` dari `PHOTOBOX_WEB/`. Script ini otomatis pull, build, migrate, copy asset, cache, dan verifikasi endpoint. Lihat [[DEPLOYMENT_PHOTOBOX]].

### Catatan Lingkungan
- PHP server: sesuai cPanel shared hosting
- Database: MySQL (production)
- Storage: `storage/app/private/photobox/` untuk templates & sessions

### Alur Deploy
```
LOCAL:
  git add . & git commit -m "..."
  git push origin main

SERVER:
  ssh alurelab
  cd repositories/photobox
  git pull origin main
  composer install --no-dev
  php artisan optimize:clear
  php artisan config:cache
  php artisan route:cache
  php artisan view:cache
```

### Verifikasi Post-Deploy
1. Buka `https://photobox.alureflow.com` → pastikan HTTP 200
2. Cek `/api/templates` → pastikan JSON response
3. Cek `storage/logs/laravel.log` untuk error baru

## Storage Structure

```
storage/app/private/photobox/
├── templates/
│   ├── borders/           # Border PNG files (existing templates)
│   ├── borders_new/       # Border PNG files (new templates added 2026-08-07)
│   └── thumbnails/        # Template thumbnail images
└── sessions/
    └── {SESSION_CODE}/
        ├── original/
        │   ├── photo-1.jpg
        │   ├── photo-2.jpg
        │   ├── photo-3.jpg
        │   └── photo-4.jpg
        └── output/
            ├── strip.jpg    # 600×1800 px
            ├── print.jpg    # 1200×1800 px
            ── print.pdf    # 4×6 inch landscape
```

## Template Count (as of 2026-08-07)

| Count | Total | IDs |
|-------|-------|-----|
| 1-photo | 1 | 1 |
| 2-photo | 9 | 2-5 (existing), 15-19 (new) |
| 3-photo | 9 | 6-9 (existing), 20-24 (new) |
| 4-photo | 10 | 10-14 (existing), 25-29 (new) |
| **Total** | **29** | |

### Template Baru (2026-08-07)
Ditambahkan dari folder `foto/` dengan slot positions standard:
- **2-photo**: Template 26-30 (ID 15-19), `y=100, height=750`
- **3-photo**: Template 21-25 (ID 20-24), `y=75, height=500`
- **4-photo**: Template 16-20 (ID 25-29), `y=124, height=288`

## APK Features

### Camera
- USB Camera (UVC) — auto-select device index 1
- Built-in Camera — back camera preferred
- Mirror effect (horizontal flip)
- Brightness adjustment (0-100%, default +30%)
- Countdown 3-2-1 dengan flash effect
- Grid overlay (rule of thirds + safe area border)

### Flow
1. Connect camera (USB atau built-in)
2. Load templates dari API
3. Select template → select layout (jumlah foto)
4. Capture photos (countdown + mirror + brightness)
5. Upload semua foto ke server
6. Server compose strip + print + PDF
7. Download/share result

### Key APK Files
- `lib/main.dart` — main app (CameraScreen, QrCodeScreen)
- `uvccamera_fixed/` — custom UVC camera plugin (YUY2 fix)

## Web Camera Features
- Preview kamera mirror horizontal.
- Hasil JPEG capture mengikuti orientasi mirror preview.
- Slider brightness 50–150% hanya muncul ketika stream kamera sudah aktif.
- Brightness preview dan file yang disimpan menggunakan nilai yang sama.
- APK tetap menggunakan API server; perubahan komposisi template di web otomatis berlaku pada hasil APK tanpa perubahan APK.

## Testing

### Feature Tests
Location: `tests/Feature/`
- `PhotoboxFlowTest.php` — full flow (index, templates, layout, capture, preview, finish, download)
- `AdminTest.php` — admin panel (login, dashboard, templates, sessions, settings)

### Commands
```bash
php artisan test              # Run PHPUnit
php artisan route:list        # List routes
php artisan migrate:status    # Check migrations
```

## Peringatan
- **Jangan jalankan `migrate:fresh` / `db:wipe` di production** — ada data session nyata
- Template border PNG harus 600×1800px dengan area transparan untuk foto
- Slot positions di `photo_config` harus align dengan area transparan border

## Related
- [[CVSS]]
- [[DEPLOYMENT_PHOTOBOX]]
- [[BUGS_PHOTOBOX]]
