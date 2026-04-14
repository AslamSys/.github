# 🤖 Aslam — Distributed AI System

<div align="center">

**Sistema distribuído de IA com assistente de voz inteligente e módulos especializados executando em 4 hardwares ARM64 dedicados.**

> *Mordomo: Assistente de voz com pipeline STT→LLM(Cloud)→TTS + IoT + 3 módulos especializados*
> *(Segurança, Investimentos, NAS)*

[![Org](https://img.shields.io/badge/GitHub-AslamSys-181717?logo=github)](https://github.com/AslamSys)
[![Repos](https://img.shields.io/badge/Repos-50-blue)](https://github.com/orgs/AslamSys/repositories)
[![License](https://img.shields.io/badge/License-MIT-green)](#-licença)
[![Status](https://img.shields.io/badge/Fase-Documentação-yellow)](#-roadmap-de-implementação)

</div>

---

## 📑 Índice

- [Resumo Executivo](#-resumo-executivo)
- [Navegação Rápida](#-navegação-rápida)
- [Arquitetura Geral do Sistema](#-arquitetura-geral-do-sistema)
- [Arquitetura de Hardware](#-arquitetura-de-hardware)
- [Estrutura do Repositório](#-estrutura-do-repositório)
- [Ecossistema 1 — Mordomo Central (Orange Pi 5 Ultra 16GB)](#-ecossistema-1--mordomo-central-orange-pi-5-ultra-16gb)
- [IoT — Integrado ao Mordomo](#-iot--integrado-ao-mordomo-orange-pi-5-ultra-16gb)
- [Ecossistema 2 — Comunicação & RPA (Integrado via OpenClaw)](#-ecossistema-2--comunicação--rpa-integrado-via-openclaw)
- [Ecossistema 3 — Segurança (Jetson Orin Nano 8GB)](#-ecossistema-3--segurança-jetson-orin-nano-8gb)
- [Ecossistema 4 — Investimentos (RPi 5 16GB)](#-ecossistema-4--investimentos-raspberry-pi-5-16gb)
- [Finanças — Integrado ao Mordomo Central](#-finanças--integrado-ao-mordomo-central)
- [Entretenimento — Integrado ao NAS](#-entretenimento--integrado-ao-nas)
- [Ecossistema 5 — NAS (hardware dedicado)](#-ecossistema-5--nas-hardware-dedicado)
- [Comunicação entre Módulos (NATS)](#-comunicação-entre-módulos-nats)
- [Análise Detalhada de Custos](#-análise-detalhada-de-custos)
- [Benchmark Competitivo — Mordomo vs Mercado](#-benchmark-competitivo--mordomo-vs-mercado)
- [Benchmark de Latência](#-benchmark-de-latência)
- [Diferenciais Únicos do Aslam](#-diferenciais-únicos-do-aslam)
- [Por que LLMs Distribuídas?](#-por-que-llms-distribuídas)
- [Casos de Uso Integrados](#-casos-de-uso-integrados)
- [Métricas do Sistema Completo](#-métricas-do-sistema-completo)
- [Roadmap de Implementação](#-roadmap-de-implementação)
- [Próximos Passos (Prioridades)](#-próximos-passos-prioridades)
- [Lições Aprendidas](#-lições-aprendidas)
- [Quick Start](#-quick-start)
- [Documentação Completa](#-documentação-completa)
- [Referências & Links](#-referências--links)
- [Licença](#-licença)

---

## 📊 Resumo Executivo

| Métrica | Valor |
|---------|-------|
| **Hardwares** | 4 dispositivos ARM64 independentes |
| **LLM Mordomo** | Cloud-primary (Gemini, GPT-4o-mini, Claude, Groq) — Jetson Orin futuro para local |
| **Repos** | 50 repositórios individuais |
| **LLMs Ativas** | 3 locais (Segurança Vision, Investimentos, NAS) + Cloud ilimitada (Mordomo) |
| **Comunicação** | NATS pub/sub (<1ms latência) |
| **RAM Total** | ~45GB (16+8+16+NAS) |
| **CPU Total** | ~20 cores ARM64 |
| **NPU/GPU** | 6 TOPS NPU (Orange Pi) + 1024 CUDA cores (Jetson) |
| **Latência Voz→Ação** | < 500ms (target < 400ms) |
| **Latência IoT** | < 150ms (ESP32 via MQTT local) |
| **Throughput NATS** | 10.000+ msg/s |
| **Economia obtida** | $230 (integração OpenClaw) + $35 (IoT integrado ao Mordomo, RPi 3B+ eliminado) |

### Status de Implementação

| Módulo | Status | Repos | Hardware |
|--------|--------|-------|----------|
| **Mordomo Central + IoT** | 📋 Documentado | 25 (STT+TTS+Core+OpenClaw+Vault+People+Financas+IoT) | Orange Pi 5 Ultra 16GB |
| **Segurança** | 📋 Documentado | 7 | Jetson Orin Nano 8GB |
| **Investimentos** | 📋 Documentado | 7 | RPi 5 16GB |
| **NAS** | 📋 Documentado | 9 (inclui Jellyfin) | Hardware NAS |

> _IoT, Comunicação (OpenClaw) e Finanças foram integrados ao hardware Mordomo (Orange Pi 5 Ultra 16GB)_

---

## 🔗 Navegação Rápida

### Documentação por Hardware

| Hardware | Link | Repos |
|----------|------|-------|
| 🏠 Mordomo + IoT (Orange Pi 5 Ultra 16GB) | [README](https://github.com/AslamSys/_system/blob/main/hardware/mordomo%20-%20(orange-pi-5-16gb)/README.md) | 25 repos |
| 🔒 Segurança (Jetson Orin Nano 8GB) | [README](https://github.com/AslamSys/_system/blob/main/hardware/seguranca%20-%20(jetson-orin-nano)/README.md) | 7 repos |
| 📈 Investimentos (RPi 5 16GB) | [README](https://github.com/AslamSys/_system/blob/main/hardware/investimentos%20-%20(raspberry-pi-5-16gb)/README.md) | 7 repos |
| 💾 NAS (hardware dedicado) | [README](https://github.com/AslamSys/_system/blob/main/hardware/nas%20-%20(raspberry-pi-5-8gb)/README.md) | 9 repos |

### Repositórios da Organização

- 📚 [_system (Orchestration)](https://github.com/AslamSys/_system) — Docker-compose + Documentação central
- 🗂️ [Todos os repositórios](https://github.com/orgs/AslamSys/repositories) — 50 repos

### Documentos complementares

- [VISAO_MACRO_COMPLETA.md](https://github.com/renancaf/mordomo-system-estudos-ia/blob/main/VISAO_MACRO_COMPLETA.md) — Análise técnica detalhada por ecossistema
- [MARKET_BENCHMARK.md](https://github.com/renancaf/mordomo-system-estudos-ia/blob/main/MARKET_BENCHMARK.md) — 60+ projetos pesquisados + benchmark competitivo
- [ANALISE_LIVEKIT_vs_MORDOMO.md](https://github.com/renancaf/mordomo-system-estudos-ia/blob/main/ANALISE_LIVEKIT_vs_MORDOMO.md) — Comparação técnica com LiveKit Agents

---

## 🎯 Arquitetura Geral do Sistema

**1 Sistema Central (Mordomo + IoT) + 3 Módulos Especializados = 4 Hardwares ARM64**

```
                    ┌─────────────────────────────────────┐
                    │   NATS Message Broker (Central)     │
                    │   Orange Pi 5 Ultra 16GB            │
                    └───────────┬─────────────────────────┘
                                │
        ┌───────────────────────┼────────────────────────────┐
        │                       │                            │
┌───────▼────────┐   ┌─────────▼────────┐   ┌──────────▼───────────┐
│ MORDOMO BRAIN  │   │ INFRAESTRUTURA   │   │   MONITORAMENTO      │
│ Orange Pi 5    │   │ Orange Pi 5      │   │  Orange Pi 5 Ultra   │
│  Ultra 16GB    │   │  Ultra 16GB      │   │   16GB               │
├────────────────┤   ├──────────────────┤   ├──────────────────────┤
│ 25 repos:      │   │ 5 containers:    │   │ 4 containers:        │
│ - STT (6)      │   │ - NATS           │   │ - Prometheus         │
│ - TTS (3)      │   │ - Consul         │   │ - Loki               │
│ - CORE (7)     │   │ - Qdrant         │   │ - Grafana            │
│ - OPENCLAW (1) │   │ - PostgreSQL     │   │ - Promtail           │
│ - People/Vault │   │ - Mordomo App    │   │                      │
│ - Financas (2) │   │                  │   │                      │
│ - IoT (4)      │   │                  │   │                      │
│ LLM: Cloud     │   │                  │   │                      │
│  (Gemini/GPT/  │   │                  │   │                      │
│   Claude)      │   │                  │   │                      │
└────────┬───────┘   └──────────────────┘   └──────────────────────┘
         │
         │ NATS pub/sub
         │
    ┌────┴────────────────────────────────────┐
    │                                         │
┌──────────────┐ ┌────────────┐ ┌──────────────┐
│ SEGURANÇA    │ │INVESTIMENTOS│ │     NAS      │
│ Jetson       │ │ RPi 5 16GB │ │   hardware   │
│ Orin Nano    │ │            │ │  dedicado    │
│ 7 repos      │ │ 7 repos    │ │ 9 repos      │
│ LLM: Qwen    │ │ LLM: Qwen  │ │ LLM: Qwen    │
│    3B Vis.   │ │    3B      │ │    1.5B      │
└──────────────┘ └────────────┘ └──────────────┘
```

---

## 🏗️ Arquitetura de Hardware

| # | Hardware | Módulo | LLM | Preço | Função Principal |
|---|----------|--------|-----|-------|------------------|
| 1 | Orange Pi 5 Ultra 16GB | **Mordomo Central + IoT** | Cloud-primary (Gemini/GPT-4o-mini/Claude) | $130 | Assistente de voz + OpenClaw RPA + Finanças + IoT (25 repos) |
| 2 | Jetson Orin Nano 8GB | Segurança | Qwen 3B Vision (local) | $249 | Câmeras, YOLOv8, reconhecimento facial |
| 3 | Raspberry Pi 5 16GB | Investimentos | Qwen 3B (local) | $120 | Trading, apostas, ML predição |
| 4 | Hardware NAS dedicado | NAS | Qwen 1.5B (local) | — | Storage, backup, Jellyfin |

> _IoT, Pagamentos e Entretenimento foram absorvidos pelo Mordomo Central e NAS respectivamente_

### Custo-Benefício de Cada Plataforma

| Hardware | Preço | Quando Usar |
|----------|-------|-------------|
| **Orange Pi 5 Ultra 16GB** | $130 | NPU necessária (Mordomo Central + IoT) — RAM para 25 repos + infra |
| **Jetson Orin Nano 8GB** | $249 | Visão AI intensiva (Segurança) — 1024 CUDA cores |
| **Raspberry Pi 5 16GB** | $120 | Módulos de ML pesado (Investimentos) |

---

## 📁 Estrutura do Repositório

```
hardware/
├── mordomo - (orange-pi-5-ultra-16gb)/    # CENTRAL — 25 repos (inclui IoT)
├── seguranca - (jetson-orin-nano)/        # MÓDULO 1 — 7 repos + Vision AI
├── investimentos - (raspberry-pi-5-16gb)/ # MÓDULO 2 — 7 repos + LLM
└── nas - (hardware-dedicado)/             # MÓDULO 3 — 9 repos + LLM + Jellyfin
```

### Organização dos Repositórios (GitHub)

Cada container vive em seu próprio repositório dentro da [organização AslamSys](https://github.com/orgs/AslamSys/repositories):

```
AslamSys/
├── _system                         # Orchestration central (docker-compose + docs)
├── mordomo-*                       # 21 repos (Orange Pi 5 Ultra 16GB)
│   ├── mordomo-audio-capture-vad
│   ├── mordomo-wake-word-detector
│   ├── mordomo-whisper-asr
│   ├── mordomo-speaker-verification
│   ├── mordomo-speaker-id-diarization
│   ├── mordomo-source-separation
│   ├── mordomo-tts-engine
│   ├── mordomo-audio-bridge
│   ├── mordomo-visual-feedback
│   ├── mordomo-orchestrator
│   ├── mordomo-brain
│   ├── mordomo-system-watchdog
│   ├── mordomo-skills-runner
│   ├── mordomo-core-gateway
│   ├── mordomo-action-dispatcher
│   ├── mordomo-dashboard-ui
│   ├── mordomo-openclaw-agent
│   ├── mordomo-people
│   ├── mordomo-vault
│   ├── mordomo-financas-pix
│   └── mordomo-financas-contas
├── mordomo-iot-*                   # 4 repos (Orange Pi 5 Ultra 16GB — integrado ao Mordomo)
├── seguranca-*                     # 7 repos (Jetson Orin Nano 8GB)
├── investimentos-*                 # 7 repos (RPi 5 16GB)
└── nas-*                           # 9 repos (NAS hardware)
```

---

## 🧠 Ecossistema 1 — Mordomo Central (Orange Pi 5 Ultra 16GB)

Sistema central de assistente de voz com processamento completo de áudio, reconhecimento, LLM cloud-primary, síntese de voz, **OpenClaw Agent** (comunicação multi-canal + RPA browser), gestão de identidade, vault de credenciais, módulos financeiros e **IoT integrado**.

**25 repos Mordomo** = 6 STT + 3 Output + 7 Core + 1 OpenClaw + 2 Identity + 2 Financas + 4 IoT

### 🎤 STT — Speech-to-Text (6 containers)

| # | Container | Função | Modelo/Tech | Latência | Recursos |
|---|-----------|--------|-------------|----------|----------|
| 1 | `audio-capture-vad` | Captura áudio com Voice Activity Detection | VAD threshold 0.5, PCM 16kHz mono | — | 50MB RAM, 5-10% CPU |
| 2 | `wake-word-detector` | Detecção de "ASLAM" | Porcupine/Pocketsphinx | <100ms | 80MB RAM, 3-8% CPU |
| 3 | `speaker-verification` | Autenticação por voz (usuário autorizado?) | ECAPA-TDNN | — | 150MB RAM, 5-10% CPU |
| 4 | `whisper-asr` | Transcrição fala→texto | Whisper base (74M params) | 200-400ms | 400MB RAM, 20-40% CPU |
| 5 | `speaker-id-diarization` | Identificação de *quem* está falando | Pyannote + embeddings | — | 300MB RAM, 10-15% CPU |
| 6 | `source-separation` | Separação de vozes sobrepostas (condicional) | Spleeter/Demucs | — | 400MB RAM, 15-25% CPU |

### 🔊 TTS — Text-to-Speech (2 containers)

| # | Container | Função | Modelo/Tech | Latência | Recursos |
|---|-----------|--------|-------------|----------|----------|
| 7 | `tts-engine` | Síntese de voz | Piper (local) ou Azure TTS (cloud) | 80-150ms | 80MB RAM, 10-20% CPU |
| 8 | `audio-bridge` | WebRTC ↔ NATS streaming | Rust, zero-copy bidirecional | — | 15MB RAM, <1% CPU |

### 🧠 CORE — Orquestração + Brain (7 containers)

| # | Container | Função | Recursos |
|---|-----------|--------|----------|
| 9 | `mordomo-orchestrator` | Unificação de session + intent routing + event system + semantic cache (FAISS) | 350MB RAM, 40% CPU |
| 10 | `system-watchdog` | Proteção térmica + DEFCON levels (5→1) + auto-shutdown >85°C | 20MB RAM, 5% CPU |
| 11 | `mordomo-brain` | LLM Cloud-primary (Gemini/GPT-4o-mini/Claude) + RAG Qdrant | ~200MB RAM, <5% CPU idle |
| 12 | `skills-runner` | Python Sandbox para skills dinâmicas (seguro, com limites CPU/RAM) | 300MB RAM, 20% CPU |
| 13 | `core-gateway` | API Gateway (HTTP/WebSocket + rate limiting + auth) | 150MB RAM, 10% CPU |
| 14 | `mordomo-people` | Identity store — perfis de moradores, permissões, biometria | 256MB RAM |
| 15 | `mordomo-vault` | Cofre de credenciais — auth por voz (biométrica) + service tokens | 60MB RAM |

### 🐙 OPENCLAW AGENT — Comunicação + RPA (1 container, 4 módulos internos)

| # | Container | Função | Recursos |
|---|-----------|--------|----------|
| 14 | `openclaw-agent` | Agente unificado de comunicação + automação | 1.2GB RAM base (2.0GB com browser), 30-50% CPU |

**Módulos internos do OpenClaw:**
- **Gateway** — Multi-channel dispatcher (WhatsApp/Baileys, Telegram/grammY, Discord, Email, SMS)
- **Browser RPA** — Chromium headless via CDP (spawna on-demand, +800MB quando ativo)
- **Skills Hub** — MordomoHub registry (auto-discovery via Consul, hot-reload)
- **Brain Bridge** — NATS bridge → Mordomo Orchestrator (request-reply + retry)

**OpenClaw Brain (LLM próprio):** Gemini Flash 2.0 / GPT-4o-mini — decide autonomamente se resolve local ou escalona via NATS.

**Canais suportados:** ✅ WhatsApp (Baileys) · ✅ Telegram (grammY) · ✅ Discord (discord.js) · ⏳ Email (IMAP/SMTP) · ⏳ SMS (Twilio)

### 🔧 Infraestrutura (5 containers)

| # | Container | Função | Recursos |
|---|-----------|--------|----------|
| 18 | `nats` | Message broker (pub/sub + request/reply, <1ms latência) | 100-200MB RAM, 10-20% CPU |
| 19 | `consul` | Service discovery + health checks | 150MB RAM, 15% CPU |
| 20 | `qdrant` | Vector database para RAG (embeddings de conversas + busca semântica) | 300MB RAM, 20% CPU |
| 21 | `postgres` | Banco relacional (histórico conversas, usuários, permissões) | 200MB RAM, 20% CPU |
| 22 | `mordomo-dashboard-ui` | Dashboard UI (React + WebSocket real-time) | 100MB RAM, 10% CPU |

### 📊 Monitoramento (4 containers)

| # | Container | Função | Recursos |
|---|-----------|--------|----------|
| 20 | `prometheus` | Métricas time-series (scrape a cada 15s) | 400MB RAM, 35% CPU |
| 21 | `loki` | Logs centralizados (todos containers) | 300MB RAM, 25% CPU |
| 22 | `grafana` | Dashboards de visualização | 250MB RAM, 30% CPU |
| 23 | `promtail` | Log collector via Docker API | 80MB RAM, 10% CPU |

### 📦 Totais de Recursos (Orange Pi 5 Ultra 16GB)

| Recurso | Alocação | Capacidade | Uso |
|---------|----------|------------|-----|
| **RAM** | ~8.9GB | 16GB | ~56% |
| **CPU** | <10% idle (sem inferência local) | 800% (8 cores) | baixo |
| **Storage** | containers + dados | SSD NVMe 256GB | — |

**LLM Strategy:** Cloud-primary — Gemini 2.0 Flash (simples), GPT-4o-mini (complexo), Claude 3.5 Haiku (alto risco), Groq/llama-3.3-70b (fallback gratuito). **Sem Ollama no Orange Pi.** LLM local é futuro via Jetson Orin dedicado.

---

## 📱 IoT — Integrado ao Mordomo (Orange Pi 5 Ultra 16GB)

> **IoT não tem hardware separado.** Os 4 containers rodam no mesmo Orange Pi 5 Ultra 16GB do Mordomo.
> O RPi 3B+ foi eliminado — RAM do IoT é mínima (~420MB) e a Orange Pi comporta tranquilamente.

### Containers (4 total)

| # | Container | Função | Recursos |
|---|-----------|--------|----------|
| 1 | `mordomo-iot-orchestrator` | Traduz NATS → MQTT, recebe comandos do Mordomo | 180MB RAM, 25% CPU |
| 2 | `mordomo-iot-mqtt-broker` | Eclipse Mosquitto (broker MQTT local 10.0.0.x) | 100MB RAM, 15% CPU |
| 3 | `mordomo-iot-state-cache` | Redis — estados em tempo real (<5ms, 50-100 devices ESP32) | 80MB RAM, 10% CPU |
| 4 | `mordomo-iot-tv-connector` | Controle de TV via HDMI-CEC / REST API | 60MB RAM, 8% CPU |

### Totais de Recursos

| Recurso | Valor |
|---------|-------|
| **RAM** | 420MB / 1GB (42% uso) |
| **CPU** | 62% / 400% (16% uso) |
| **Latência** | <150ms (NATS + MQTT + ESP32) |

### Arquitetura IoT DIY

- **Access Point Wi-Fi:** hostapd + dnsmasq (10.0.0.x/24)
- **Devices:** ESP32 a $3 cada (vs Zigbee $15) — **5x economia**
- **Economia total:** $240 vs Zigbee comercial
- **Alcance:** 50-100m com antena 5dBi

---

## 💬 Ecossistema 3 — Comunicação & RPA (Integrado via OpenClaw)

> **Status:** ✅ Integrado ao hardware Mordomo (Orange Pi 5 16GB) via OpenClaw
> **Economia:** ~$230 hardware + $35/ano energia

### Função Original
Gerenciar WhatsApp, Telegram, Email, SMS, Discord, Push Notifications + Automação web, OCR, scraping.

### Implementação Atual
**1 container OpenClaw Agent substitui 7 containers standalone**, com 4 módulos internos (veja [Ecossistema Mordomo → OpenClaw Agent](#-openclaw-agent--comunicação--rpa-1-container-4-módulos-internos)).

**Decisão inteligente:** OpenClaw Agent tem LLM próprio (Gemini Flash) que decide autonomamente se resolve local ou escalona pro Mordomo Brain.

**Browser RPA integrado:** Chromium headless via CDP (+800MB on-demand) — Web automation, OCR (Tesseract), scraping, form filling, Canvas A2UI dashboard.

**Vantagens da integração:**
- Compartilha LLM Brain do Mordomo (zero overhead adicional)
- Skills System: Automações reutilizáveis cross-ecossistemas
- NATS integration nativa (publica resultados scraped para outros módulos)

---

## 🛡️ Ecossistema 4 — Segurança (Jetson Orin Nano 8GB)

Monitorar 4 câmeras com YOLO, reconhecimento facial, análise de comportamento.

### Containers (7 total)

| # | Container | Função | RAM | VRAM |
|---|-----------|--------|-----|------|
| 1 | `seguranca-brain` | LLM Qwen 3B Vision | 4GB | 2GB |
| 2 | `camera-stream-manager` | RTSP + NVENC | 1GB | 256MB |
| 3 | `yolo-detector` | YOLOv8n TensorRT | 512MB | 1.5GB |
| 4 | `face-recognition` | FaceNet | 768MB | 512MB |
| 5 | `event-analyzer` | Análise de comportamento | 384MB | — |
| 6 | `alert-manager` | Alertas via NATS | 256MB | — |
| 7 | `storage-manager` | Gravação 24/7 | 512MB | 256MB |

### Totais de Recursos

| Recurso | Valor |
|---------|-------|
| **RAM** | 7.43GB / 8GB (93% uso) |
| **VRAM** | 4.52GB / 8GB shared (57% uso) |
| **CPU** | 680% / 600% (113% — picos tolerados) |
| **GPU** | 1024 CUDA cores (NVENC/NVDEC offload) |
| **LLM** | Qwen 3B Vision Q4_K_M (1.8GB VRAM) |

---

## 💳 Finanças — Integrado ao Mordomo Central

> **Pagamentos e gestão financeira estão integrados diretamente ao Orange Pi 5 Ultra** — não há hardware separado.

| Container | Função | Auth |
|-----------|--------|------|
| `mordomo-financas-pix` | Gateway PIX (Asaas API) | Voice auth confidence ≥ 0.95 |
| `mordomo-financas-contas` | Gestão de contas e extratos | Voice auth confidence ≥ 0.95 |

---

## 📈 Ecossistema 4 — Investimentos (Raspberry Pi 5 16GB)

Trading automatizado (ações, cripto, forex), ML predição, apostas esportivas.

### Containers (7 total)

| # | Container | Função | RAM |
|---|-----------|--------|-----|
| 1 | `investimentos-brain` | LLM Qwen 3B (local, RPi 5) | 3GB |
| 2 | `investimentos-trading-bot` | Binance/Bybit | 2GB |
| 3 | `investimentos-technical-analysis` | TA-Lib | 3GB |
| 4 | `investimentos-news-sentiment` | FinBERT | 2.5GB |
| 5 | `investimentos-betting-bot` | Bet365 | 1GB |
| 6 | `investimentos-ml-predictor` | LSTM + LightGBM | 3GB |
| 7 | `investimentos-portfolio-manager` | Gestão de portfólio | 1.5GB |

### Totais de Recursos

| Recurso | Valor |
|---------|-------|
| **RAM** | 16GB / 16GB (100% uso) |
| **CPU** | 450% / 400% (113% — ajustado) |
| **LLM** | Qwen 3B Q4_K_M (1.8GB VRAM) |

---

## 🎬 Entretenimento — Integrado ao NAS

> **O Jellyfin (media server) está no hardware NAS** junto com os demais serviços de armazenamento.
> Os containers de download (qBittorrent), Radarr, Sonarr, Bazarr e streaming aggregator foram descontinuados.

---

## 💾 Ecossistema 5 — NAS (hardware dedicado)

Backup automático de fotos do iPhone, armazenamento centralizado, deduplicação.

### Containers (9 total)

| # | Container | Função | RAM |
|---|-----------|--------|-----|
| 1 | `nas-brain` | LLM Qwen 1.5B | 2.5GB |
| 2 | `nas-file-sync` | Syncthing | 512MB |
| 3 | `nas-photo-backup` | PhotoPrism + iCloud | 1.5GB |
| 4 | `nas-object-storage` | MinIO S3 | 1GB |
| 5 | `nas-deduplication` | Btrfs + rmlint | 768MB |
| 6 | `nas-smb-server` | Samba | 384MB |
| 7 | `nas-backup-manager` | Restic | 512MB |
| 8 | `nas-media-indexer` | AI tagging | 1GB |
| 9 | `nas-media-server` | Jellyfin (media server) | 1.5GB |

### Totais de Recursos

| Recurso | Valor |
|---------|-------|
| **RAM** | 8.2GB / 8GB (103% — swap 1GB) |
| **CPU** | 500% / 400% (125% picos) |
| **Storage** | 2x HDD 4TB RAID 1 + SSD NVMe 1TB (tiering) |
| **LLM** | Qwen 1.5B Q4_K_M (0.9GB VRAM) |

---

## 🔌 Comunicação entre Módulos (NATS)

### Padrão de Tópicos

**Formato:** `{modulo}.{recurso}.{acao}`

```yaml
# ── Mordomo ──
mordomo.speech.transcribed
mordomo.brain.response_generated
mordomo.conversation.message_received
mordomo.tts.generate_request
mordomo.action.completed

# ── OpenClaw Agent (integrado ao Mordomo) ──
mordomo.openclaw.gateway.send
mordomo.openclaw.gateway.message_received
mordomo.openclaw.browser.scrape
mordomo.openclaw.browser.screenshot
mordomo.openclaw.skills.execute
mordomo.orchestrator.request
openclaw.response.{request_id}
openclaw.notification
openclaw.alert.{priority}

# ── IoT ──
iot.device.control
iot.device.state_changed
iot.device.discovered
iot.scene.activate

# ── Pagamentos ──
pagamentos.pix.send
pagamentos.pix.received
pagamentos.boleto.generate
pagamentos.card.charge

# ── Investimentos ──
investimentos.order.create
investimentos.order.filled
investimentos.portfolio.balance

# ── Segurança ──
seguranca.alert.person
seguranca.alert.intrusion
seguranca.camera.snapshot

# ── Entretenimento ──
entretenimento.play.movie
entretenimento.play.music
entretenimento.download.complete

# ── NAS ──
nas.file.uploaded
nas.photo.backed_up
nas.backup.completed
```

### Exemplo de Integração: Alerta de Segurança

```
1. Câmera detecta invasão (Segurança - Jetson)
   ↓
   NATS publish → seguranca.alert.intrusion
   {
     "level": "critical",
     "description": "Pessoa desconhecida no quintal",
     "snapshot_url": "http://jetson.local/snapshots/alert_123.jpg",
     "camera_id": "cam_quintal"
   }

2. Mordomo recebe alerta via NATS subscription
   ↓
   Brain processa: "Intruso detectado no quintal"
   ↓
   Dispatcher despacha 3 ações paralelas:

   a) NATS → iot.device.control (acionar sirene)
   b) NATS → mordomo.openclaw.gateway.send (enviar foto pro dono)
   c) NATS → seguranca.recording.start (gravar vídeo HD)

3. Executam em paralelo (~150ms total):
   - IoT: Sirene acende
   - OpenClaw: WhatsApp enviado com snapshot
   - Segurança: Continua gravando vídeo HD

4. Aslam confirma: "Alerta enviado. Sirene ativada."
```

**Vantagem:** 3 ações paralelas vs sequencial → **6x mais rápido**

---

## 💰 Análise Detalhada de Custos

### Hardware ($1.077)

| Hardware | Qtd | Preço Unit. | Total |
|----------|-----|-------------|-------|
| Orange Pi 5 Ultra 16GB | 1 | $130 | $130 |
| Raspberry Pi 5 16GB | 1 | $120 | $120 |
| Jetson Orin Nano 8GB | 1 | $249 | $249 |
| Hardware NAS | 1 | — | — |
| Periféricos (fontes, cases, cabos) | — | — | ~$150 |

### Armazenamento ($462)

| Item | Preço |
|------|-------|
| MicroSD cards (3x) | ~$48 |
| HDD 4TB (2x RAID 1) | $180 |
| SSD NVMe 1TB (NAS tiering) | $70 |
| SSD NVMe 256GB (Mordomo) | $35 |

### Rede ($40)

| Item | Preço |
|------|-------|
| Switch Gigabit 8 portas | $25 |
| Cabos Cat6 (7x) | $15 |

### Energia (custo anual)

| Métrica | Valor |
|---------|-------|
| Consumo médio | 50W |
| Consumo pico | 75W |
| 24/7 por ano | 438 kWh/ano |
| Custo Brasil (~R$0.80/kWh) | **R$350/ano (~$70/ano)** |

### Resumo de Investimento

| Categoria | Valor |
|-----------|-------|
| Hardware + Periféricos | $1.077 |
| Armazenamento | $462 |
| Rede | $40 |
| **TOTAL INICIAL** | **$1.579** |
| **Operacional (anual)** | **~$70/ano** |

### Economias Obtidas

| Economia | Valor | Como |
|----------|-------|------|
| Integração OpenClaw | $230 | Comunicação + RPA em 1 container (eliminados 2 hardwares) |
| Integração IoT ao Mordomo | $35 | RPi 3B+ eliminado — containers IoT rodam na Orange Pi |
| Energia (24%) | $35/ano | ARM64 eficiente vs x86 |
| **Total economia** | **$505+** | — |

---

## 🏆 Benchmark Competitivo — Mordomo vs Mercado

### Projetos Pesquisados (60+)

| Categoria | Projetos |
|-----------|----------|
| ✅ Avaliados (23) | Home Assistant, OpenHAB, Rhasspy, OpenVoiceOS, Leon, Gladys, Willow, Domoticz, ioBroker, WebThings, Node-RED, ESPHome, Zigbee2MQTT, Vosk/Piper/Porcupine, Tasmota, Mycroft Core, Kalliope, Mimic 3, Z-Wave JS |
| ❌ Descartados (11) | Project Alice, Stephanie, Jarvis, DeepSpeech, Coqui STT, Snowboy, FHEM, Melissa, W.I.L.L, GLaDOS, Jasper, S.A.R.A.H., SEPIA |
| ⏳ A avaliar (26) | Frigate, CasaOS, Pipecat, LiveKit Agents, OpenMQTTGateway, Olivia, Jovo, Dicio, Clone Voice, Bailing, Irene, Ultravox, Cartesia Sonic, Deepgram, AssemblyAI, ElevenLabs, Picovoice, Apache Pulsar, Redis Streams, Whisper.cpp, Faster-Whisper, OpenAI Realtime API, Matter Protocol, Silero VAD, Resemblyzer |

### Insights-Chave do Benchmark

| Projeto | Contribuição para o Mordomo |
|---------|----------------------------|
| **LiveKit Agents** (8.4k ⭐) | Silero VAD, barge-in, semantic turn detection, test framework |
| **Pipecat** (Daily.co) | Frame-based pipeline, interruption strategy, local turn analyzer |
| **Vapi.ai / Retell AI** | End-of-turn NLP, sentiment tracking, latência <300ms benchmark |
| **Faster-Whisper** | CTranslate2 backend → 4x mais rápido que Whisper original |
| **Cartesia Sonic** | TTS <100ms (first audio chunk 80-120ms) |
| **Silero VAD** | ONNX runtime <10ms, threshold 0.2s, industry standard |
| **Frigate NVR** | MQTT nativo, YOLO detection, já planejado para Segurança |

> Detalhes completos: [MARKET_BENCHMARK.md](https://github.com/renancaf/mordomo-system-estudos-ia/blob/main/MARKET_BENCHMARK.md)

---

## ⚡ Benchmark de Latência

| Componente | Aslam (Target) | LiveKit Agents | Pipecat | Vapi.ai | Retell AI |
|------------|----------------|----------------|---------|---------|-----------|
| **VAD** | <10ms | <10ms (Silero) | <10ms (Silero) | <10ms | <10ms |
| **Wake Word** | <100ms | N/A | N/A | N/A | N/A |
| **STT** | <300ms | <200ms (Deepgram) | <250ms (Whisper.cpp) | <150ms | <200ms |
| **LLM** | <500ms | <300ms (GPT-4o) | <400ms (Ollama) | <200ms | <300ms |
| **TTS** | <200ms | <100ms (Cartesia) | <150ms (ElevenLabs) | <100ms | <100ms |
| **Buffer Clearing** | <50ms | <20ms | <30ms | <20ms | <20ms |
| **Total (Voz→Ação)** | **<500ms** | **~400ms** | **~500ms** | **~300ms** | **~500ms** |
| **IoT Action** | **<150ms** | N/A | N/A | N/A | N/A |

**Conclusão:**
- ✅ **IoT <150ms** → Melhor que todos (ESP32 DIY + Access Point local)
- ⚠️ **Voice pipeline 500ms** → Bom, mas Vapi consegue 300ms (room for improvement)
- 🎯 **Target real:** Reduzir para <400ms (Silero VAD + Cartesia TTS + Faster-Whisper)

---

## 🏅 Diferenciais Únicos do Aslam

### 1. 🌐 Arquitetura Distribuída
7 hardwares especializados com processamento paralelo — **ninguém no mercado faz isso**

### 2. 🔌 IoT Mais Rápido do Mercado
ESP32 DIY <150ms vs Zigbee comercial 300-500ms → **2-3x mais rápido**

### 3. 🧠 Multi-LLM por Módulo
6 LLMs independentes + 1 LLM OpenClaw = processamento paralelo assíncrono, nunca bloqueia o assistente central

### 4. 🔒 Privacy-First com Cloud Fallback
- LLM local garante privacidade
- Cloud quando necessário para qualidade
- Seamless handoff (usuário não percebe troca)

### 5. 💰 Custo Fixo vs Pay-per-Use
$1.579 one-time vs Vapi/Retell $0.10-0.50/min — **amortiza em meses**

### 6. 📦 Modular NATS
Adicionar módulos sem reescrever código — plug & play via pub/sub

### 7. 🎙️ Multi-Speaker Real
Speaker Verification (autenticação) + Speaker ID (identificação) + Contextos separados por pessoa + Níveis de permissão (GUEST → USER → POWER_USER → ADMIN)

### 8. 📊 Observabilidade Completa
Prometheus + Loki + Grafana → métricas de **tudo** (latência, CPU, RAM, eventos, logs centralizados, dashboards visuais)

### 9. 🤖 OpenClaw Agent Integrado
Comunicação multi-canal + RPA browser com LLM próprio em 1 container (economia $230)

---

## 🧠 Por que LLMs Distribuídas?

### ❌ Problema: Arquitetura Monolítica Bloqueia

```
Usuário: "Envia WhatsApp pro João"
Aslam Brain: Processa + envia (500ms de espera...)
Usuário: "Qual a temperatura?" ❌ BLOQUEADO — aguardando resposta anterior
```

### ✅ Solução: Módulos Assíncronos

```
Usuário: "Envia WhatsApp pro João"
Aslam: Delega → OpenClaw Agent (via NATS)
Aslam: "Ok, enviando!" (retorna controle imediatamente)
Usuário: "Qual a temperatura?" ✅ Responde sem bloqueio — OpenClaw trabalha em paralelo
```

---

## 💡 Casos de Uso Integrados

### 1. 💰 Gestão Financeira Automática

```
PIX recebido R$ 5.000 (Pagamentos)
  → Aslam: "Cliente X pagou"
  → Investimentos: "Sugestão: 70% em PETR4 (sinal compra)"
  → Usuário aprova por voz
  → Investimentos executa trade automaticamente
  → OpenClaw: Confirma via Telegram
```

### 2. 🏠 Casa Inteligente Proativa

```
21:00 Sexta-feira (padrão detectado via ML)
  → Entretenimento: "Novo episódio Stranger Things!"
  → IoT: Apaga luzes sala + ajusta temperatura 22°C
  → OpenClaw: Notifica família "Cinema 21:30"
```

### 3. 🔒 Segurança Total

```
Câmera: Pessoa desconhecida (Segurança Vision)
  → Aslam: Alerta crítico (DEFCON 2)
  → IoT: Sirene + todas luzes acendem
  → OpenClaw: WhatsApp com snapshot para dono
  → Segurança: Grava vídeo HD + busca rosto no Qdrant
```

---

## 📊 Métricas do Sistema Completo

| Métrica | Valor |
|---------|-------|
| **Hardwares** | 4 dispositivos independentes |
| **RAM Total** | ~45GB (16+8+16+5 NAS) |
| **CPU Total** | ~28 cores ARM64 |
| **Armazenamento** | 12TB+ (MicroSDs + HDs + SSDs) |
| **NPU/GPU** | 6 TOPS (NPU) + 1024 CUDA cores |
| **Consumo Energia** | ~40-60W médio |
| **Latência Comandos** | < 500ms (voz → ação) |
| **Latência IoT** | < 150ms (ESP32 via Access Point) |
| **Throughput NATS** | 10.000+ msg/s |
| **Disponibilidade** | 99.9% (redundância NATS) |

---

## 🎯 Roadmap de Implementação

### ✅ Fase 1: Planejamento e Documentação (CONCLUÍDO)
- [x] Pesquisa de mercado (preços RPi vs Orange Pi vs Jetson)
- [x] Análise de recursos por módulo (RAM, CPU, NPU)
- [x] Documentação completa de 7 hardwares
- [x] Justificativas técnicas (custo-benefício)
- [x] Estrutura de diretórios criada
- [x] Integração OpenClaw Agent (Comunicação + RPA consolidados no Mordomo)
- [x] Benchmark competitivo (60+ projetos, 276 linhas análise)
- [x] **Total:** 7 READMEs detalhados + análise de viabilidade

### ⏳ Fase 2: Infraestrutura Central (Próximo)
- [ ] Deploy Mordomo (Orange Pi 5 Ultra 16GB)
  - [ ] NATS (message broker)
  - [ ] Consul (service discovery)
  - [ ] Qdrant (vector DB para RAG)
  - [ ] PostgreSQL (dados relacionais)
  - [ ] Prometheus + Loki + Grafana
  - [ ] mordomo-brain (LLM Cloud-primary: Gemini/GPT/Claude)
  - [ ] mordomo-vault (credenciais)
  - [ ] mordomo-people (identity store)
  - [ ] OpenClaw Agent (Comunicação + RPA)

### 📅 Fases 3-7: Módulos Incrementais
- [ ] **Fase 3:** IoT (RPi 3B+) — Automação básica
- [ ] **Fase 4:** Segurança (Jetson) — Câmeras + Vision AI
- [ ] **Fase 5:** Investimentos (RPi 5 16GB) — Trading bots
- [ ] **Fase 6:** NAS — Storage + Jellyfin

### 🎯 Fase 8: Otimização e Produção
- [ ] Testes de carga (stress testing)
- [ ] Backup e disaster recovery
- [ ] Documentação de usuário final
- [ ] Métricas de performance (latência, throughput)
- [ ] Docker Compose consolidado
- [ ] Scripts de deployment automatizado
- [ ] Testes em hardware real

---

## 🚀 Próximos Passos (Prioridades)

### 🔴 P0 — Latência Crítica (implementar agora)

| # | Ação | Impacto |
|---|------|---------|
| 1 | Implementar **Silero VAD** (0.2s threshold) | VAD <10ms |
| 2 | **Buffer clearing** em interrupções (flush ESP32/audio client) | Barge-in <50ms |
| 3 | **Semantic turn detection** (regex/NLP leve para fim de frase) | Menos falsos positivos |
| 4 | Testar **Cartesia Sonic TTS** (<100ms first audio chunk) | TTS 200ms → 100ms |

**Estimativa:** Reduzir latência de <500ms → **<400ms**

### 🟡 P1 — Performance (próximas sprints)

| # | Ação | Impacto |
|---|------|---------|
| 5 | Avaliar **Faster-Whisper** (CTranslate2, 4x faster) | STT 300ms → 150ms |
| 6 | Implementar **streaming STT** (partial transcripts → LLM) | Latência percebida |
| 7 | **Warm handoff** Cloud ↔ Local LLM (seamless fallback) | UX seamless |
| 8 | **Test framework** com LLM judges (automated validation) | Qualidade CI/CD |

### 🟢 P2 — Futuro (nice-to-have)

| # | Ação | Impacto |
|---|------|---------|
| 9 | **OpenAI Realtime API** (audio-to-audio, modo híbrido) | Sub-300ms para conversas complexas |
| 10 | **Sentiment analysis** (emotion tracking) | UX contextual |
| 11 | **Matter Protocol** (avaliar se simplifica IoT DIY) | Interoperabilidade |
| 12 | **Multi-agent handoff** (transição seamless entre módulos) | Multi-agent |

### 📋 Auditorias Pendentes (5 módulos)

| Módulo | Prioridade |
|--------|-----------|
| Segurança (Jetson Orin Nano) | Alta — hardware mais complexo |
| Investimentos (RPi 5 16GB) | Média — RAM 100% precisa validação |
| NAS (hardware dedicado) | Média — RAM + Jellyfin |

> **Processo:** Mesma profundidade que Mordomo e IoT (verificar recursos, containers, integrações NATS)

---

## 🎓 Lições Aprendidas

### 1. Modularidade vs Monólito
- Arquitetura monolítica bloqueia: 1 LLM = 1 fila sequencial
- Arquitetura modular: 6 LLMs independentes = processamento paralelo
- OpenClaw consolida Comunicação + RPA em 1 container (economia $230)

### 2. Cloud-First vs Local-First
- Documentação inicial mostrava "Local-First" (Qwen 3B local)
- Realidade: **Cloud-First** (Claude/GPT) → Fallback Local (Qwen 1.5B)
- Economia: 1GB RAM (3B = 1.5GB → 1.5B = 500MB)

### 3. ESP32 DIY vs Zigbee Comercial
- Zigbee: $15/device, vendor lock-in, latência 300-500ms
- ESP32: $3/device, controle total, latência <150ms
- **Resultado:** 5x economia + 2x velocidade

### 4. NATS vs RabbitMQ/Kafka
- NATS: 12MB RAM, <1ms latência, milhões msg/s
- Perfeito para ARM (Raspberry Pi / Orange Pi)
- Event-driven architecture simplifica integrações cross-módulo

### 5. Benchmark Contínuo
- Mercado evolui rápido (LiveKit Agents, Cartesia Sonic, OpenAI Realtime API)
- Importante monitorar estado da arte continuamente
- Implementar apenas o que traz valor real (foco: latência <400ms)

---

## 🚀 Quick Start

```bash
# 1. Clone o repositório central
git clone https://github.com/AslamSys/_system
cd _system

# 2. Configurar environment
cp .env.example .env
# Edite .env com suas configurações

# 3. Iniciar todos containers do Aslam (Orange Pi 5)
docker compose -f hardware/aslam/docker-compose.yml up -d

# 4. Verificar status
docker compose ps

# 5. Acessar dashboards
# Grafana: http://orange-pi:3000 (admin/admin)
# Dashboard UI: http://orange-pi:80
```

---

## 📚 Documentação Completa

### Documentação por Hardware

Cada hardware possui README detalhado com:
- Especificações técnicas e preços reais
- Justificativa de escolha (custo-benefício)
- LLM configurada (quantização, VRAM, latência)
- Containers do ecossistema (recursos, integrações)
- Fluxos de comunicação via NATS
- Casos de uso práticos

| Hardware | README | Repos | Status |
|----------|--------|-------|--------|
| Orange Pi 5 Ultra 16GB (Mordomo + IoT) | [Ver](https://github.com/AslamSys/_system/blob/main/hardware/mordomo%20-%20(orange-pi-5-16gb)/README.md) | 25 | 📋 Documentado |
| Jetson Orin Nano (Segurança) | [Ver](https://github.com/AslamSys/_system/blob/main/hardware/seguranca%20-%20(jetson-orin-nano)/README.md) | 7 + LLM Vision | 📋 Documentado |
| RPi 5 16GB (Investimentos) | [Ver](https://github.com/AslamSys/_system/blob/main/hardware/investimentos%20-%20(raspberry-pi-5-16gb)/README.md) | 7 + LLM | 📋 Documentado |
| NAS hardware | [Ver](https://github.com/AslamSys/_system/blob/main/hardware/nas%20-%20(raspberry-pi-5-8gb)/README.md) | 9 + LLM | 📋 Documentado |

### Documentação Geral

| Documento | Descrição |
|-----------|-----------|
| [hardware/README.md](https://github.com/AslamSys/_system/blob/main/hardware/README.md) | Visão geral de hardware + análise custo-benefício |
| [VISAO_MACRO_COMPLETA.md](https://github.com/renancaf/mordomo-system-estudos-ia/blob/main/VISAO_MACRO_COMPLETA.md) | Análise técnica detalhada de todos os ecossistemas |
| [MARKET_BENCHMARK.md](https://github.com/renancaf/mordomo-system-estudos-ia/blob/main/MARKET_BENCHMARK.md) | 60+ projetos pesquisados + benchmark competitivo |
| [ANALISE_LIVEKIT_vs_MORDOMO.md](https://github.com/renancaf/mordomo-system-estudos-ia/blob/main/ANALISE_LIVEKIT_vs_MORDOMO.md) | Comparação técnica LiveKit Agents vs Mordomo |
| [ecossistemas/README.md](https://github.com/AslamSys/_system/blob/main/hardware/mordomo%20-%20(orange-pi-5-16gb)/ecossistemas/README.md) | 3 ecossistemas do Mordomo (app, infra, monitoring) |
| [ecossistemas/SUMARIO.md](https://github.com/AslamSys/_system/blob/main/hardware/mordomo%20-%20(orange-pi-5-16gb)/ecossistemas/SUMARIO.md) | Guia de leitura completo |

---

## 📎 Referências & Links

### Projetos Avaliados (destaques)

| Projeto | Link | Relevância |
|---------|------|------------|
| LiveKit Agents | [github.com/livekit/agents](https://github.com/livekit/agents) | 8.4k ⭐ — Real-time voice agents |
| Pipecat | [github.com/daily-co/pipecat](https://github.com/daily-co/pipecat) | Voice AI pipeline framework |
| Cartesia Sonic | [cartesia.ai/sonic](https://cartesia.ai/sonic) | Ultra-low latency TTS <100ms |
| Silero VAD | [github.com/snakers4/silero-vad](https://github.com/snakers4/silero-vad) | Industry-standard VAD |
| Faster-Whisper | [github.com/SYSTRAN/faster-whisper](https://github.com/SYSTRAN/faster-whisper) | 4x faster STT |
| OpenAI Realtime API | [platform.openai.com](https://platform.openai.com/docs/guides/realtime) | Audio-to-audio WebSocket |
| Frigate NVR | [frigate.video](https://frigate.video/) | AI-powered NVR |
| Matter Protocol | [csa-iot.org](https://csa-iot.org/all-solutions/matter/) | Smart home standard |
| Vapi.ai | [vapi.ai](https://vapi.ai/pricing) | Commercial voice AI benchmark |
| Retell AI | [retellai.com](https://retellai.com/) | Commercial benchmark |

### Organização GitHub

- **Org:** [github.com/AslamSys](https://github.com/AslamSys)
- **System repo:** [github.com/AslamSys/_system](https://github.com/AslamSys/_system)
- **Todos os repos:** [github.com/orgs/AslamSys/repositories](https://github.com/orgs/AslamSys/repositories) (55 repositórios)

---

## 📄 Licença

MIT License

---

<div align="center">

**Projeto:** Aslam (Mordomo) · **Autor:** Renan · **Versão:** 2.0.0 · **Última atualização:** 13/02/2026

*Sistema distribuído de IA — 7 hardwares · 71+ containers · 6 LLMs · <500ms latência · $1.579 investimento total*

</div>
