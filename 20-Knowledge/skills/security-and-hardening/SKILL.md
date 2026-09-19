---
name: security-and-hardening
description: Production-grade security, OWASP prevention, secrets protection, input sanitization, and vulnerability hardening for web apps (Laravel & Next.js) and hosting environments. Use when designing authentication, processing user inputs, handling file uploads, managing API tokens, or auditing code before deployment.
---

# Security & Code Hardening (Production Standards)

Standar keamanan wajib untuk seluruh pengembangan aplikasi, API, database, dan infrastruktur server (Laravel, Next.js, hosting cPanel & VPS).

---

## 1. Prinsip Utama Keamanan (Zero-Trust)

1. **Semua Input Adalah Musuh**: Jangan pernah mempercayai data yang datang dari HTTP request, URL query, form body, webhook eksternal, header, maupun upload file.
2. **Secrets Adalah Sakral**: Kunci API, database password, JWT secret, dan SSH private key DILARANG KERAS di-commit ke Git repo atau di-log ke console/file log.
3. **Defense in Depth**: Keamanan tidak boleh hanya mengandalkan satu lapis (misal validasi di client side). Setiap lapisan (Frontend, API Gateway, Controller, Database) wajib memiliki validasi sendiri.

---

## 2. OWASP Top 10: Pola Pencegahan Praktis

### A. SQL Injection (SQLi)
- ❌ **DILARANG**: Menggabungkan string query langsung: `DB::select("SELECT * FROM users WHERE email = '$email'")`.
- ✅ **GUNAKAN**: Parameter binding atau Eloquent ORM:
  ```php
  // Laravel
  User::where('email', $email)->first();
  DB::select("SELECT * FROM users WHERE email = :email", ['email' => $email]);
  ```

### B. Cross-Site Scripting (XSS)
- Di Blade: Selalu gunakan `{{ $untrustedData }}` (otomatis di-escape). Jangan gunakan `{!! $data !!}` kecuali data sudah disanitasi via HTMLPurifier.
- Di React / Next.js: Jangan gunakan `dangerouslySetInnerHTML`.

### C. Cross-Site Request Forgery (CSRF)
- Di Laravel: Pastikan setiap form HTML memiliki directive `@csrf`. Untuk API stateless, gunakan token bearer (Sanctum) dengan token expiry.
- Di Next.js Server Actions: Validasi origin header dan verifikasi session auth di dalam action body.

### D. Insecure Direct Object References (IDOR)
- ❌ **DILARANG**: `Order::findOrFail($request->order_id)->delete();` (Attacker bisa menghapus order orang lain dengan mengganti ID).
- ✅ **GUNAKAN**: Scoped query berdasarkan user yang terautentikasi:
  ```php
  $request->user()->orders()->findOrFail($request->order_id)->delete();
  // Atau gunakan Laravel Policy
  $this->authorize('delete', $order);
  ```

### E. File Upload Security
- Validasi ekstensi dan MIME type secara ketat (jangan percaya ekstensi nama file asli).
- Simpan file dengan nama hash acak (`Str::random(40)`), bukan nama file asli dari user.
- Simpan di luar web root atau di cloud storage (S3 / R2), jangan izinkan eksekusi script (`.php`, `.phtml`, `.js`) di folder upload.

---

## 3. Manajemen Kredensial & Secrets

- **Pembersihan Darurat**: Jika ada API key atau password yang tidak sengaja ter-commit ke Git, **segera lakukan rotasi token di dashboard penyedia**. Menghapus commit saja tidak cukup karena history cache Git atau bot crawler bisa menyerapnya dalam hitungan detik.
- **File `.env`**: Selalu pastikan `.env` ada di `.gitignore`. Sediakan `.env.example` yang hanya berisi dummy key placeholder.
- **SSH Key Permissions**: File private key di server atau lokal WAJIB memiliki permission `600` (`chmod 600 ~/.ssh/id_*`). Folder `.ssh` wajib `700`.

---

## 4. Security Headers Checklist (cPanel & Next.js)

Pastikan header berikut terpasang di `.htaccess` atau `next.config.js`:
- `X-Frame-Options: SAMEORIGIN` (Mencegah Clickjacking)
- `X-Content-Type-Options: nosniff` (Mencegah MIME-sniffing)
- `Referrer-Policy: strict-origin-when-cross-origin`
- `Content-Security-Policy (CSP)` yang membatasi script origin
- `Strict-Transport-Security (HSTS)` untuk memaksa koneksi HTTPS
