# Voice Type

Voice typing global untuk macOS — mengetik pakai suara di aplikasi apa pun, **100% lokal/offline** memakai [whisper.cpp](https://github.com/ggml-org/whisper.cpp). Bukan project client; tools pribadi untuk produktivitas coding.

## Location
`/Users/10969sosho/voice-typing/`

## Ringkasan
- Shortcut global `⌥ + Space` untuk toggle rekam → transkripsi → auto-paste ke aplikasi aktif.
- Bekerja di Chrome, VS Code, Terminal, ChatGPT, WhatsApp, dll.
- Bahasa utama: Indonesia (`id`), mendukung campuran Inggris.
- Istilah programming (Laravel, PHP, MySQL, API, GitHub, Composer, JS/TS, Docker) ditegakkan via initial prompt + tabel koreksi.
- **Mode Live**: audio ditranskripsi per potongan ±3,5 dtk sambil merekam (overlap + dedup antar chunk) → hasil hampir instan saat berhenti. Config `live: true/false`.
- Tanpa GUI rumit — hanya dot di menu bar (abu-abu = idle, merah = rekam dengan hitungan kata live, kuning = memproses).
- Tidak ada cloud API. Audio tidak pernah keluar mesin.

## Arsitektur
```
Global Shortcut (Carbon RegisterEventHotKey)
→ AVAudioRecorder → WAV 16kHz mono PCM16 (1 file kontinu)
→ Live: sliceWav per ±3,5 dtk (overlap 0,8 dtk) → whisper-cli (serial queue) → dedupOverlap → liveText
→ Saat stop: transkripsi sisa kecil → gabung → cleanup
→ NSPasteboard + CGEvent ⌘+V (butuh izin Accessibility)
```

## Teknologi
- Swift 6 (single file `src/main.swift`), di-compile `swiftc` tanpa Xcode
- whisper-cpp via Homebrew (`whisper-cli` 1.9.x)
- Model: `ggml-large-v3-turbo-q5_0` aktif saat ini (turbo quantized 574MB) → `~/.local/share/voicetype/models/`
- Config: `~/.config/voicetype/config.json` (model, language, threads, live)
- Auto-start: LaunchAgent `com.local.voicetype`

## Setup
```bash
cd ~/voice-typing
./setup.sh            # brew install whisper-cpp + build + download model
./run.sh
# beri izin Microphone & Accessibility di System Settings
```

## Scripts
`build.sh`, `setup.sh`, `download_model.sh`, `run.sh`, `install_launchagent.sh`, `uninstall_launchagent.sh`.

## Status
- [x] Pipeline tervalidasi end-to-end (rekam → whisper → cleanup → paste)
- [x] Transkripsi test ID campur EN dengan `small`: hampir sempurna
- [ ] Validasi manual di aplikasi target (perlu izin TCC user)

## Related
- [[AI]]
- [[PROJECT INDEX]]
- [[Laravel]]
