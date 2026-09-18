# ALURELAB QA

Browser QA untuk production ALURELAB menggunakan Playwright. Sumber test ada di repo aplikasi `frontend/qa/`.

Temuan 2026-09-18: PM2 stale build sudah diperbaiki dengan restart dan asset `/_next/static/*` kembali 200. Buyer login/logout dan empty-checkout guard lulus, tetapi add-to-bag tidak menyimpan item ke cart. Seller QA terblokir karena semua akun seller terdokumentasi belum email-verified dan API mengembalikan 422.
