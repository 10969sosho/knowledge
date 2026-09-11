# DEPPA Recent Updates

## 2026-08-12

- Mengganti Google OAuth dengan autentikasi berbasis nama.
- Menjadikan nama player unik dan identifier endpoint game.
- Menambahkan token Sanctum dari flow register/login.
- Mengubah download report dan certificate agar menggunakan nama player.
- Menambahkan endpoint JSON publik `GET /api/player/name/{name}` untuk resume player dari main menu.
- Mengizinkan CORS API untuk origin `https://preview.construct.net`.
- Menambahkan penomoran otomatis pada nama player lama yang duplikat sebelum unique index diterapkan.
- Membuat link download report dan certificate dapat dibuka langsung tanpa bearer token.

## Related

- [[DEPPA]]
- [[DEPPA Features]]
- [[Laravel]]
- [[Sanctum]]
