# YMIITS - Yayasan Manarul Ilmi ITS

## Overview

Website publik dan CMS admin Yayasan Manarul Ilmi ITS.

## Location

HP clone: `/root/projects/ymiits/`

## Tech Stack

- Laravel 9.52, PHP, Blade, Breeze authentication
- MySQL
- Vite, Tailwind CSS, Alpine.js
- Apache/cPanel deployment through SSH alias `alurelab`

## Deployment

- Repository: `https://github.com/Gen-ei-Ryodan/ymiits.git`
- Server source: `~/repositories/ymiits`
- Domain public root: `~/ymiits.com`
- Script: `deploy.sh`

Production `.env` and uploaded media remain on the server and are never committed.

## Documentation

- Project source docs: `PROJECT_CONTEXT.md`, `ARCHITECTURE.md`, `BUSINESS_RULES.md`, `DATABASE.md`, `API_REFERENCE.md`, `CHANGELOG.md`
- Deployment: `deploy.sh` and project `README.md`

## Related

- [[CVSS]]
- [[Laravel]]
- [[Authentication]]
- [[GYM]]
