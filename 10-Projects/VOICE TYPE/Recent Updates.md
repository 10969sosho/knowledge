# Voice Type — Recent Updates

## 2026-08-13 — Inisialisasi
- Project voice typing global macOS dibuat di `~/voice-typing`.
- `src/main.swift` single-file Swift: hotkey Carbon `⌥+Space`, AVAudioRecorder (WAV 16kHz), subprocess `whisper-cli` (whisper.cpp + Metal), cleanup teks, paste via clipboard + CGEvent.
- Fix: `NSApp` nil saat start (harus panggil `NSApplication.shared` eksplisit sebelum setup).
- Script: `build.sh`, `setup.sh`, `download_model.sh`, `run.sh`, `install_launchagent.sh`, `uninstall_launchagent.sh`.
- Model default `small` (ggml-small.bin, 480MB) di-download.
- Validasi: whisper-cli flags teruji dengan model tiny + small (TTS Damayanti id_ID); transkripsi test hampir sempurna.
- Koreksi istilah coding: Laravel/PHP/MySQL/API/GitHub/Composer/JavaScript/TypeScript/Docker + varian salah dengar (la ravel, kegit hub, dodgeker, apinya→API-nya, dll).
- **Ganti model ke `large-v3-turbo-q5_0`** (560MB, quantized) — akurasi jauh lebih baik daripada `small`. Config `~/.config/voicetype/config.json` diupdate; latency ±8 dtk untuk klip 12 dtk (encoder cepat, decoder lebih berat), akseptabel untuk akurasi.
- Tambah koreksi baru: `miskl`/`miskel` → MySQL.
- **Spinner animasi saat memproses**: indikator menu bar kini berputar (spinner kuning) selama transkripsi berjalan, bukan sekadar dot statis. Implementasi: `Timer` + rotasi arc (`makeSpinnerFrame`), di-`invalidate` otomatis oleh `setStatus`.
- **Mode Live (chunk streaming + overlap)**: sambil merekam, audio ditranskripsi per potongan ±3,5 dtk di background. Implementasi: `AVAudioRecorder` pause→copy snapshot→resume (tanpa gap), `sliceWav` memotong WAV manual karena whisper-cli mengabaikan `-d`, chunk diberi overlap 0,8 dtk lalu `dedupOverlap` (normalisasi tanda baca) membuang kata ganda di batas chunk. Offset `liveOffsetMs` hanya maju saat chunk sukses → tidak ada teks hilang/duplikat. Saat stop hanya sisa kecil diproses → paste hampir instan, label "Rekam… live N kata". Config baru `"live": true/false` (default true). Uji validasi: hasil merge chunk cocok dengan transkripsi full-clip, bahkan fix `MySQL`/`miskel` lebih baik daripada full. Koreksi baru: `kaymiskel`,`kemiskel`→MySQL.

## Related
- [[VOICE TYPE]]
