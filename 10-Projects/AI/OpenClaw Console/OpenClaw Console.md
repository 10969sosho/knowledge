# OpenClaw Console

Laravel 13 + Inertia React controller UI untuk mengirim task ke OpenClaw,
memantau progress, dan bertanya tentang riwayat task.

Model 3D di Progress memakai `public/model3D.glb` dengan drag POV, zoom, framing
berbasis torso, dan motion state. Animasi tangan anatomis membutuhkan asset GLB
yang sudah memiliki skeleton/bones.

Console memiliki project context picker dan custom path agar prompt tidak salah
folder. Chat memakai **agent OpenClaw sebagai backend utama** (bisa membaca file lokal
termasuk vault Obsidian ini) dengan **fallback GPT-5 Nano** bila gateway tidak reachable;
balasan diproses **async** di queue `chat` agar POST balas instan. Prompt chat berisi
transkrip riwayat + instruksi akses file lokal; timeout diatur `OPENCLAW_CHAT_TIMEOUT`
(default 120s).
Tampilan chat memiliki empty state, bubble user/assistant yang terpisah jelas,
urutan pesan deterministik, serta panel History multi-session. Tombol New Session
membuat percakapan baru tanpa menghapus sesi sebelumnya; migration memindahkan
pesan lama ke sesi default.
Task detail memiliki timeline antrean agar status queued/running/completed jelas.

## Perubahan Agustus 2026

- **Chat → OpenClaw agent + async**: `ChatController::store` kini **dispatch**
  `ReplyToChatMessage` (queue `chat`) → POST balas instan (~0.1s), pesan ditulis
  `Thinking…`, frontend polling partial reload `messages` tiap 2.5s sampai jawaban siap.
  `ChatAssistantService::reply()` prefer `OpenClawService::agentTurn`, fallback
  `OpenAiChatService`. Worker chat terpisah WAJIB jalan:
  `php artisan queue:work --queue=chat` (start.sh mengelola keduanya).
- **Fix PATH child process**: PHP built-in server memberi child env minimal sehingga
  `#!/usr/bin/env node` (binary `openclaw`) gagal. Ditangani `OpenClawService::processEnv()`
  yang men-set `PATH` eksplisit termasuk `/opt/homebrew/bin`.
- Endpoint chat bisa baca vault Obsidian (`/Users/10969sosho/Obsidian/Ciel/`).
- **Diagnosis lemot (17 Agu)**: bukan gangguan server — halaman localhost:8000 fast
  (0.8s); yang lambat adalah balasan chat sinkron (~19s, sempat 74–150s saat gateway
  cold-start). Akar: latensi agent gateway + session main yang membesar. Solusi yang
  diterapkan: reset main session agent, restart gateway, dan async reply di atas.
- **Hard refresh lambat (17 Agu)**: `php artisan serve` single-threaded — `/api/status`
  yang memanggil CLI `openclaw` (health+logs, ~5–20s per spawn) memblokir semua request
  lain (page/asset bisa antri puluhan detik). Fix: server dijalankan dengan
  `PHP_CLI_SERVER_WORKERS=4` + `--no-reload` (multi-worker), dan `live` di `/api/status`
  di-cache (`Cache::remember`, TTL 8s) sehingga CLI hanya dipanggil ~sekali tiap 8s.

## Related
- [[AI]]
- [[Laravel 13]]
- [[Inertia React]]
- [[OpenClaw]]
