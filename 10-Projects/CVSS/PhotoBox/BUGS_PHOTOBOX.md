# BUGS & FIX — PHOTOBOX

Catatan bug yang ditemukan & diperbaiki.

## 1. Template photo_config slots tidak terisi (2026-07-30)
- **Symptom**: Template "Classic" di DB punya `photo_config = {"x":30,"y":30,"width":540,"height":720}` — tidak ada key `slots`.
- **Root cause**: Form admin `TemplateResource.php` cuma nyimpen satu posisi `x/y/w/h` (via `px/py/pw/ph`), bukan daftar slot per foto. `ImageProcessingService::composeStrip()` baca `$photoConfig['slots'] ?? []` → kosong → foto tidak tergambar.
- **Fix**: Tambah template baru dengan `photo_config['slots']` array yang benar. Setiap template = satu jumlah foto dengan slot positions standard.
- **Commit**: `06c9bf0 feat: add templates, QR download, frame guide, 1-photo layout, TAYA background, fix API validation`

## 2. Z-Index composition order (2026-08-07)
- **Symptom**: Border PNG sebagai base canvas, foto di-insert di atasnya.
- **Root cause**: User request — border sudah transparan, harusnya jadi overlay di atas foto, bukan base di belakang.
- **Fix**: Ubah urutan di `composeStrip()`: (1) create empty canvas, (2) insert foto ke slot positions sebagai base, (3) insert border PNG terakhir sebagai overlay.
- **File**: `app/Services/ImageProcessingService.php`

## 3. Slot positions over-engineered (2026-08-07)
- **Symptom**: Awalnya di-scan per-template dan dapat positions unik, lalu di-reset ke 4 konfigurasi standar.
- **Fix**: Hanya perlu **4 konfigurasi** — 1/2/3/4 photo, semua template dengan count sama pakai positions identik.
- **Status**: Resolved. Semua 29 template sekarang pakai 4 konfigurasi standar.

## 4. Frame dan foto tidak sejajar (2026-08-07)
- **Symptom**: Hasil session `340` terlihat tidak pas; foto menabrak frame dan border terpotong.
- **Root cause**: Border template `2.2.png` berukuran 738×2215 ditempel ke canvas 600×1800 tanpa resize. Slot layout 2 sebelumnya juga terlalu besar (480×610).
- **Fix**: Resize border ke 600×1800 sebelum overlay dan ukur ulang empat konfigurasi slot dari area transparan border acuan. Layout 2 sekarang memakai slot 355×514 dan 355×526.
- **Verification**: Session `340` dijadikan kasus uji produksi; output diregenerasi setelah deploy.

## 5. Preview web tidak mirror dan brightness tidak tersedia (2026-08-07)
- **Symptom**: Kamera website menampilkan orientasi asli dan tidak punya kontrol kecerahan saat capture.
- **Fix**: Mirror preview dengan `scaleX(-1)`, mirror JPEG melalui transform canvas, dan tambahkan slider brightness 50–150% yang hanya tampil setelah kamera aktif.
- **File**: `resources/views/photobox/capture.blade.php`.

## 6. APK error `FormatException: Unexpected character (at character 1) <DOCTYPE html>` (2026-08-16)
- **Symptom**: APK Flutter gagal parse response API, muncul `FormatException: Unexpected character (at character 1) <DOCTYPE html>`. Ini berarti server mengembalikan halaman **HTML** (bukan JSON) saat APK memanggil `/api/*`.
- **Investigasi**:
  - Test langsung `GET https://photobox.alureflow.com/api/templates` → **HTTP 200 + JSON valid** (saat ini sudah normal).
  - Test `POST /api/sessions`, `POST /api/sessions/{id}/photos`, `POST /api/sessions/{id}/finish` → JSON valid.
  - Error route `/api/nonexistent` → JSON `{"message": "The route ... could not be found."}` (bukan HTML).
  - `storage/logs/laravel.log` menunjukkan error berulang **`Class "QrCode" not found`** di `resources/views/photobox/result.blade.php:151` (memakai `QrCode::size(180)->generate()`).
  - Error `failed_jobs` index: `Specified key was too long; max key length is 1000 bytes` (migration, historical).
- **Root cause**: Error APK terjadi pada periode ketika server mengembalikan **halaman error 500 (HTML)** — paling konsisten dengan `Class "QrCode" not found` yang sempat aktif sebelum deploy terbaru. APK `jsonDecode()` tanpa validasi bahwa response benar-benar JSON, sehingga response HTML langsung memicu `FormatException`.
- **Status saat ini**: Server sudah di-deploy ulang (HEAD `e19f357`). `QrCode` facade tersedia (`class_exists('QrCode') == true`), `/result/{session}` → HTTP 200, API semua endpoint JSON valid. **Resolved.**
- **Peringatan (APK tidak diubah sesuai instruksi user)**: APK tetap rapuh terhadap response non-JSON. Di masa depan disarankan (bila diizinkan) menambah guard `jsonDecode`/cek `content-type` agar tidak crash.
- **File terkait**: `app/Http/Controllers/Api/*`, `resources/views/photobox/result.blade.php`.

## Related
- [[PhotoBox]]
- [[DEPLOYMENT_PHOTOBOX]]
