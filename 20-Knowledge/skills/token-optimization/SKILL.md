---
name: token-optimization
description: Optimizes AI context window, minimizes token consumption, and prevents context degradation. Use when planning complex features, managing multi-step agent workflows, editing codebases, or when interacting with LLMs via API to save cost and avoid hallucinations.
---

# Token Optimization & Context Engineering

Panduan dan protokol baku untuk menghemat konsumsi token, mempercepat respon LLM, dan menjaga akurasi agent agar tidak mengalami "context degradation" atau halusinasi.

---

## 1. Filosofi "Elephant & Goldfish" (Workflow 2-Fase)

Ketika mengerjakan task besar/kompleks, jangan gunakan 1 sesi panjang yang menumpuk ribuan token context. Gunakan pola:

```
┌──────────────────────────────────────────────┐
│  FASE 1: THE ELEPHANT (High-Context Planner) │
│  • Pakai model pintar (Sonnet / Gemini Pro)  │
│  • Analisis mendalam, petakan dependensi     │
│  • Hasil: Task list atomik di Markdown plan  │
└──────────────────────┬───────────────────────┘
                       │ Output plan terstruktur
                       ▼
┌──────────────────────────────────────────────┐
│  FASE 2: THE GOLDFISH (Short-Context Runner) │
│  • Eksekusi 1 task atomik per run            │
│  • Pakai model cepat/hemat (Qwen / Flash)    │
│  • Hanya baca file yang disentuh             │
│  • Selesai 1 slice → verifikasi → flush      │
└──────────────────────────────────────────────┘
```

---

## 2. Aturan Baku Hemat Token (Zero-Waste Context)

### A. Targeted Search vs File Dumping
- ❌ **DILARANG** membaca seluruh isi file besar (ribuan baris) jika hanya butuh 1 fungsi.
- ✅ **GUNAKAN** `grep_search` / `ripgrep` untuk menemukan line spesifik, lalu baca hanya range baris terkait (`StartLine` & `EndLine`).
- ❌ **DILARANG** me-load folder `node_modules/`, `vendor/`, `.git/`, atau file build `.next/` / `dist/` ke context.

### B. Patching & Diffing Minimalis
- ❌ **DILARANG** me-rewrite atau menimpa seluruh file jika hanya mengubah 3-5 baris kode.
- ✅ **GUNAKAN** tool `replace_file_content` / targeted sed untuk modifikasi blok spesifik. Setiap token yang ditulis model dihitung biaya dan waktu responsnya.

### C. Komunikasi Direct & No-Filler
- ❌ Hilangkan basa-basi pembuka ("Tentu, ini kode yang Anda minta...", "Pertanyaan bagus!", dll.).
- ✅ Langsung laporkan: **Apa yang diubah**, **Hasil verifikasi**, dan **Langkah berikutnya**.
- Gunakan format tabular atau bullet points ringkas dibanding paragraf panjang.

---

## 3. Context Hierarchy (Prioritas Loading)

Saat menginisialisasi pengerjaan, load data sesuai urutan prioritas:

1. **System Rules / Agreement**: (Permanen, ringkas, < 1k tokens) — SOP server, path, format response.
2. **Feature Spec / Task Plan**: (Per-sesi, 1-2k tokens) — Hanya apa yang akan dikerjakan hari ini.
3. **Target Source Code**: (On-demand) — Hanya file yang akan diedit.
4. **Execution / Error Log**: (Transien) — Cuplikan error penting saja (tail 20 baris), bukan 500 baris build log.

---

## 4. Tool Loop Guardrails & Circuit Breakers

Untuk mencegah agent terjebak dalam looping token tanpa hasil:
- **Max 3x retry** pada tool error yang sama. Jika gagal 3x berturut-turut, agent **WAJIB** berhenti, analisis error log secara kritis, atau minta klarifikasi ke user.
- Jangan menjalankan command yang memproduksi output tanpa batas (`cat access.log`, `npm list -all`, recursive `du -sh`). Selalu batasi dengan `head -n 50` atau `grep`.
