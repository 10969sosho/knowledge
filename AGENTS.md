# SOP & WORKFLOW AGENT (LAPTOP ⇄ HERMES HP ⇄ OBSIDIAN)

File ini adalah panduan kerja wajib untuk semua AI Coding Assistant di laptop (Antigravity, OpenCode, Cursor, dll.) agar ingatan, dokumentasi, dan status hosting selalu tersinkronisasi lintas perangkat (Laptop, HP Poco, dan Server).

---

## 1. AWAL SESI (Saat Memulai Pekerjaan)
Setiap agent yang baru memulai sesi coding di laptop **WAJIB** menjalankan sinkronisasi awal untuk menarik konteks terbaru yang dibuat dari HP/Hermes:

```bash
cd ~/knowledge && git pull origin main
```

### Konteks yang Harus Dibaca Agent:
- `~/knowledge/20-Knowledge/hosting/servers.md` : Info server Alurelab, KBKB, port cPanel yang terpakai, dan rules deploy.
- `~/knowledge/30-Agent-Memory/MEMORY.md` : State memori bersama (catatan teknis lintas platform).
- `~/knowledge/10-Projects/[nama-project]/` : Dokumentasi spesifik proyek yang sedang dikerjakan.

---

## 2. SELAMA SESI (Proses Coding & Eksekusi)
1. **Aturan Backup**: Sebelum mengubah, menimpa, atau menghapus file penting/database di server, WAJIB buat file backup (`.bak` / SQL dump).
2. **Dokumentasi How-to Hosting**: Jika pekerjaan melibatkan setup baru, perubahan port, env, routing, atau cara deploy, agent **WAJIB** membuat atau memperbarui file:
   ```text
   ~/knowledge/10-Projects/[nama-project]/HOWTO-HOSTING.md
   ```
   *(Gunakan template standar di `~/knowledge/10-Projects/_template/HOWTO-HOSTING.md`)*.
3. **Catatan Isu / Bug Unik**: Jika menemukan bug teknis penting (misal Next.js static export cPanel, Laravel seeder compatibility), catat ringkasannya ke `~/knowledge/30-Agent-Memory/MEMORY.md`.

---

## 3. AKHIR SESI (Saat Pekerjaan Selesai)
Sebelum mengakhiri sesi percakapan atau setelah task selesai diverifikasi, agent **WAJIB** melakukan sinkronisasi:

### Langkah A: Push ke Central Repo (GitHub)
```bash
~/knowledge/sync.sh
```

### Langkah B: Trigger Instant Pull ke HP Poco (Hermes & Obsidian)
Agar Hermes di HP langsung memiliki ingatan yang sama tanpa delay:
```bash
ssh -o RemoteCommand=none -o RequestTTY=no hppoco "proot-distro login debian -- /root/knowledge-hub/auto-pull.sh"
```

---

## 4. HASIL SINKRONISASI
- **Obsidian di HP**: Dokumen dan how-to hosting langsung muncul di vault `KnowledgeHub`.
- **Hermes di HP (WA/Telegram)**: Otomatis membaca state memori terbaru dari `/root/.hermes/memories/`.
- **Laptop**: Selalu siap untuk sesi coding berikutnya dengan konteks yang akurat dan ter-backup di Git.
