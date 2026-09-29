# CORE-SAAS (Backend Marketing / Google Review Reply)

Backend Laravel untuk SaaS marketing yang mengelola bisnis (Google Place) + review Google dan auto-reply.

- **Lokasi**: `PROJECTS/finance/PROJECT/PROJECT ANTIGRAVITY/MARKETING/src/core-saas`
- **Stack**: Laravel 13.34 (PHP 8.5), SQLite lokal (default), PHPUnit, Pint
- **Status (2026-09-29)**: Inisialisasi selesai — schema, model, service.

## Struktur

| Bagian | File |
| :--- | :--- |
| Users + subscription | `database/migrations/0001_01_01_000000_create_users_table.php`, `2026_09_29_182245_add_subscription_fields_to_users_table.php` (`subscription_status`, `subscription_plan`, `midtrans_customer_id`) |
| Businesses | `2026_09_29_182243_create_businesses_table.php` (`user_id`, `place_id` unique, `name`, `address`, `rating`, `total_reviews`, `auto_reply_enabled`, `persona_prompt`) |
| Reviews | `2026_09_29_182244_create_reviews_table.php` (`business_id`, `google_review_id` unique komposit, `author_name`, `rating`, `comment`, `reply_text`, `reply_status`, `sentiment_score`, `flagged_critical`) |
| Model | `app/Models/User.php`, `app/Models/Business.php`, `app/Models/Review.php` (pakai atribut `#[Fillable]`, method `casts()`) |
| Service | `app/Services/GoogleReviewReplyService.php` |

## Service: GoogleReviewReplyService

```php
$svc = app(GoogleReviewReplyService::class);
$review->sentiment_score = $svc->analyzeSentiment($review->comment); // -1..1
$review->reply_text      = $svc->generateReply($review);             // string siap pakai
$review->save();
```

- `analyzeSentiment(string): float` — LLM (JSON `{"score": -1..1}`) → fallback lexicon lokal (id+en) bila error/kosong.
- `generateReply(Review): string` — pakai `business.persona_prompt` sebagai system prompt → fallback **template** per rating (≤2 minta maaf + ajak DM, 3 apresiasi feedback, ≥4 terima kasih) bila LLM error/5xx/response tidak layak.
- LLM dikonfigurasi via `.env`: `LLM_API_URL` (endpoint OpenAI-compatible `/v1/chat/completions`), `LLM_API_KEY`, `LLM_MODEL`, `LLM_TIMEOUT`. **Tanpa key = langsung fallback**, tidak ada exception.
- Service murni (tanpa side effect): pemanggil yang menyimpan ke kolom review.

## Verifikasi

```bash
php artisan migrate:fresh
php artisan test --compact   # 7 tests / 11 assertions PASS
vendor/bin/pint app database tests
```

Test unit: `tests/Unit/GoogleReviewReplyServiceTest.php` (5 kasus: LLM ok, LLM down → lexicon, reply LLM ok, reply LLM error → template, tanpa konfigurasi → template).

## Catatan

- `pint --dirty` butuh git — repo belum `init`; pakai `vendor/bin/pint <path>`.
- Kolom `subscription_status` default `trial`; `midtrans_customer_id` nullable + index (untuk Midtrans Customer Token/subscription).
- `reviews.google_review_id` unique komposit `(business_id, google_review_id)` aman dari sinkronisasi ulang.
