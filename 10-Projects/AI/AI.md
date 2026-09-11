# AI - NVIDIA NIM API Testing

## Overview
Script sederhana untuk testing API NVIDIA NIM (NVIDIA Inference Microservice).

## Location
`/Users/10969sosho/PROJECT/AI/`

## Structure
```
AI/
└── test.py
```

## Technical Details

### Dependencies
- **openai** (Python package) - digunakan sebagai client untuk NVIDIA API

### API Provider
- **NVIDIA NIM** (`https://integrate.api.nvidia.com/v1`)
- Model: `deepseek-ai/deepseek-v4-flash`
- Authentication: API key NVIDIA

### Functionality
`test.py` adalah script sederhana yang:
1. Membuat koneksi ke NVIDIA NIM API
2. Mengirim prompt: `"buat query mysql update stock"`
3. Menerima dan mencetak respons dari model DeepSeek V4 Flash

### Parameters
- `max_tokens`: 300
- `stream`: False

## Status
- Test/experimental script
- Hanya 1 file, bukan project lengkap


## Related

- [[PROJECT INDEX]]
- [[Python]]
