# PACEL MINI - E-Commerce Operations Management (Sambal Pecel Business)

## Overview
Sistem manajemen operasional e-commerce untuk bisnis Sambal Pecel yang berjualan di Shopee/TikTok. Berfungsi sebagai "Single Source of Truth" untuk produk, penjualan, iklan, pengeluaran, dan analisis laba rugi.

## Location
`/Users/10969sosho/PROJECT/PACEL MINI/`

## Structure
```
PACEL MINI/
├── apppecelmini/                    # Laravel 11 application
│   ├── composer.json                # Laravel 11, spatie/simple-excel
│   ├── .env                         # DB_DATABASE=pecelmini
│   ├── routes/web.php               # (83 lines)
│   ├── app/
│   │   ├── Http/Controllers/        # 16 controllers
│   │   └── Models/                  # 19 models
│   ├── database/migrations/         # 28 migrations
│   ├── export_nav.php               # CLI export script
│   ├── export_fin.txt               # Exported financial data
│   └── SYSTEM_DOCUMENTATION.md
├── WEBSITEPECEL/
│   └── index.html                   # Dark-themed landing page (1928 lines)
└── .trae/documents/
    └── Sidebar Navigasi & Modul Awal.md
```

## Tech Stack
| Layer | Technology |
|-------|-----------|
| Backend | Laravel 11, PHP 8.2+ |
| Database | MySQL (`pecelmini`) |
| Excel Import | Spatie Simple Excel 3.7 |
| Frontend | Blade + Tailwind CSS, Vite |
| Landing Page | HTML5 + CSS (inline) + AOS.js + Inter font |

## Modules

### Master Data
- Internal Products (SKU, name, photo, variants)
- Platform Products (Shopee product listing sync)
- Product Mapping (Shopee ↔ internal SKU)
- HPP (Cost of Goods Sold) per variant

### Sales Module
- Import Shopee/TikTok order reports (CSV/Excel)
- Auto-filter duplicates & cancelled orders
- Order detail (buyer name, address, items)
- Status management

### Advertising Module
- Import ad performance data (impressions, clicks, cost)
- Ad Wallet: manual top-up + auto-deduction from ad spend
- Wallet transaction history

### Finance Module
- Marketplace income import (reconciliation)
- Cash accounts: Kas Bank, Uang Owner, Uang Mama
- Cash account entries (in/out with categories)
- Expense tracking (materials, operations, packaging, etc.)
- Owner ledger

### Reports
- Sales report (revenue, quantity, status)
- Internal sales
- Gross Profit (Revenue - HPP)
- Net Profit (Gross Profit - Ad - Ops - Admin Fee)
- Best-selling products

## Models (19)
`Product`, `ProductVariant`, `SkuMapping`, `ShopeeProductCodeMapping`, `ShopeeOrderItem`, `ShopeeAdsCampaignStat`, `ShopeeAdsSearchPlacementStat`, `ShopeeIncomeEntry`, `ShopeeWalletTransaction`, `CashAccount`, `CashAccountEntry`, `Expense`, `OwnerLedger`, `AdsTopup`, `HppHistory`, `ImportBatch`, `Asset`, `NavigationItem`, `User`

## Controllers (16)
`DashboardController`, `MasterController`, `MasterProductController`, `MasterPlatformController`, `MasterMappingController`, `PenjualanController`, `AdsController`, `AdsWalletController`, `FinanceController`, `ExpenseController`, `CashAccountController`, `ShopeeWalletController`, `OwnerLedgerController`, `LaporanController`, `AssetController`

## Landing Page
Dark-themed single page dengan AOS.js animations, menampilkan produk sambal pecel.


## Related

- [[PROJECT INDEX]]
- [[Laravel]]
