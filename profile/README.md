# 🤖 Aslam — Distributed AI System

<div align="center">

**Sistema distribuído de IA com assistente de voz inteligente e módulos especializados executando em 7 hardwares ARM64 dedicados, cada um com LLM própria para processamento assíncrono.**

> *Aslam: Assistente de voz com pipeline STT→LLM→TTS + 6 módulos especializados*
> *(Segurança, IoT, Pagamentos, Investimentos, Entretenimento, NAS)*

[![Org](https://img.shields.io/badge/GitHub-AslamSys-181717?logo=github)](https://github.com/AslamSys)
[![Repos](https://img.shields.io/badge/Containers-55_repos-blue)](https://github.com/orgs/AslamSys/repositories)
[![License](https://img.shields.io/badge/License-MIT-green)](#-licença)
[![Status](https://img.shields.io/badge/Fase-1_Concluída-brightgreen)](#-roadmap-de-implementação)

</div>

---

## 📑 Índice

- [Resumo Executivo](#-resumo-executivo)
- [Navegação Rápida](#-navegação-rápida)
- [Arquitetura Geral do Sistema](#-arquitetura-geral-do-sistema)
- [Arquitetura de Hardware](#-arquitetura-de-hardware)
- [Estrutura do Repositório](#-estrutura-do-repositório)
- [Ecossistema 1 — Mordomo Central (Orange Pi 5 16GB)](#-ecossistema-1--mordomo-central-orange-pi-5-16gb)
- [Ecossistema 2 — IoT (Raspberry Pi 3B+ 1GB)](#-ecossistema-2--iot-raspberry-pi-3b-1gb)
- [Ecossistema 3 — Comunicação & RPA (Integrado via OpenClaw)](#-ecossistema-3--comunicação--rpa-integrado-via-openclaw)
- [Ecossistema 4 — Segurança (Jetson Orin Nano 8GB)](#-ecossistema-4--segurança-jetson-orin-nano-8gb)
- [Ecossistema 5 — Pagamentos (Raspberry Pi 5 4GB)](#-ecossistema-5--pagamentos-raspberry-pi-5-4gb)
- [Ecossistema 6 — Investimentos (Raspberry Pi 5 16GB)](#-ecossistema-6--investimentos-raspberry-pi-5-16gb)
- [Ecossistema 7 — Entretenimento (Raspberry Pi 5 8GB)](#-ecossistema-7--entretenimento-raspberry-pi-5-8gb)
- [Ecossistema 8 — NAS (Raspberry Pi 5 8GB)](#-ecossistema-8--nas-raspberry-pi-5-8gb)
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
| **Hardwares** | 7 dispositivos ARM64 independentes |
| **Investimento Total** | $1.779 (hardware $1.077 + armazenamento $462 + rede $40 + periféricos $200) |
| **Containers Totais** | 71+ (25 Mordomo + 46 módulos especializados) |
| **LLMs Independentes** | 6 (1 central + 5 módulos; IoT sem LLM; Comunicação/RPA integrados) |
| **Consumo Energético** | 47-75W (≈ 438 kWh/ano ≈ R$350/ano) |
| **Comunicação** | NATS pub/sub (<1ms latência) |
| **Armazenamento** | 12TB+ (HDDs + SSDs + MicroSDs) |
| **RAM Total** | 61GB (16+8+1+4+16+8+8) |
| **CPU Total** | 40 cores (diversos ARM64) |
| **NPU/GPU** | 6 TOPS (NPU) + 1024 CUDA cores |
| **Latência Voz→Ação** | < 500ms (target < 400ms) |
| **Latência IoT** | < 150ms (ESP32 via Access Point) |
| **Throughput NATS** | 10.000+ msg/s |
| **Economia obtida** | $230 (integração OpenClaw) + $240 (ESP32 DIY vs Zigbee) |

### Status de Implementação

| Módulo | Status | Containers | Auditado |
|--------|--------|------------|----------|
| **Mordomo Central + OpenClaw** | ✅ Implementado | 25 (16+5+4) | ✅ Completo |
| **IoT** | ✅ Implementado | 4 | ✅ Completo |
| Segurança | 📋 Especificado | 7 | ❌ Pendente auditoria |
| Pagamentos | 📋 Especificado | 6 | ❌ Pendente auditoria |
| Investimentos | 📋 Especificado | 7 | ❌ Pendente auditoria |
| Entretenimento | 📋 Especificado | 6 | ❌ Pendente auditoria |
| NAS | 📋 Especificado | 8 | ❌ Pendente auditoria |

> _Comunicação e RPA foram integrados ao hardware Mordomo usando OpenClaw (economia de $230)_

---

## 🔗 Navegação Rápida

### Documentação por Hardware

| Hardware | Link | Containers |
|----------|------|------------|
| 🏠 Mordomo (Orange Pi 5 16GB) | [README](hardware/mordomo%20-%20(orange-pi-5-16gb)/README.md) | 25 containers |
| 🔒 Segurança (Jetson Orin Nano) | [README](hardware/seguranca%20-%20(jetson-orin-nano)/README.md) | 7 containers |
| 🏢 IoT (Raspberry Pi 3B+) | [README](hardware/iot%20-%20(raspberry-pi-3b)/README.md) | 4 containers |
| 💰 Pagamentos (RPi 5 4GB) | [README](hardware/pagamentos%20-%20(raspberry-pi-5-4gb)/README.md) | 6 containers |
| 📈 Investimentos (RPi 5 16GB) | [README](hardware/investimentos%20-%20(raspberry-pi-5-16gb)/README.md) | 7 containers |
| 🎬 Entretenimento (RPi 5 8GB) | [README](hardware/entretenimento%20-%20(raspberry-pi-5-8gb)/README.md) | 6 containers |
| 💾 NAS (RPi 5 8GB) | [README](hardware/nas%20-%20(raspberry-pi-5-8gb)/README.md) | 8 containers |

### Repositórios da Organização

- 📚 [_system (Orchestration)](https://github.com/AslamSys/_system) — Docker-compose + Documentação central
- 🗂️ [Todos os repositórios](https://github.com/orgs/AslamSys/repositories) — 55 repos (containers individuais)

### Documentos complementares

- [VISAO_MACRO_COMPLETA.md](VISAO_MACRO_COMPLETA.md) — Análise técnica detalhada por ecossistema
- [MARKET_BENCHMARK.md](MARKET_BENCHMARK.md) — 60+ projetos pesquisados + benchmark competitivo
- [ANALISE_LIVEKIT_vs_MORDOMO.md](ANALISE_LIVEKIT_vs_MORDOMO.md) — Comparação técnica com LiveKit Agents

---

## 🎯 Arquitetura Geral do Sistema

**1 Sistema Central (Aslam Voice Assistant) + 6 Módulos Especializados = 7 Hardwares ARM64**

```
                    ┌─────────────────────────────────────┐
                    │   NATS Message Broker (Central)     │
                    │   Orange Pi 5 16GB - Infraestrutura │
                    └───────────┬─────────────────────────┘
                                │
        ┌───────────────────────┼────────────────────────────┐
        │                       │                            │
┌───────▼────────┐   ┌─────────▼────────┐   ┌──────────▼───────────┐
│ ASLAM BRAIN    │   │ INFRAESTRUTURA   │   │   MONITORAMENTO      │
│ Orange Pi 5    │   │ Orange Pi 5 16GB │   │  Orange Pi 5 16GB    │
│  16GB          │   │  (Ecossistema)   │   │   (Ecossistema)      │
├────────────────┤   ├──────────────────┤   ├──────────────────────┤
│ 16 containers: │   │ 5 containers:    │   │ 4 containers:        │
│ - STT (6)      │   │ - NATS           │   │ - Prometheus         │
│ - TTS (2)      │   │ - Consul         │   │ - Loki               │
│ - CORE (4)     │   │ - Qdrant         │   │ - Grafana            │
│ - OPENCLAW (4) │   │ - PostgreSQL     │   │ - Promtail           │
│               │   │ - Aslam App      │   │                      │
│ LLM: Cloud +   │   │                  │   │ TOTAL: 25 containers │
│   Qwen 1.5B    │   │                  │   │ RAM: ~6.0GB (63% livre)│
└────────┬───────┘   └──────────────────┘   └──────────────────────┘
         │
         │ NATS pub/sub
         │
    ┌────┴────────────────────────────────────┐
    │                                         │
┌───▼──────────┐ ┌────────────┐ ┌────────────┐ ┌──────────────┐
│ SEGURANÇA    │ │ PAGAMENTOS │ │INVESTIMENTOS│ │ENTRETENIMENTO│
│ Jetson       │ │ RPi 5 4GB  │ │ RPi 5 16GB │ │ RPi 5 8GB    │
│ Orin Nano    │ │            │ │            │ │              │
│ 7 cont.      │ │ 6 cont.    │ │ 7 cont.    │ │ 6 cont.      │
│ LLM: Qwen    │ │ LLM: Qwen  │ │ LLM: Qwen  │ │ LLM: Qwen    │
│    3B Vis.   │ │    1.5B    │ │    3B      │ │    1.5B      │
└──────────────┘ └────────────┘ └────────────┘ └──────────────┘

┌──────────────┐ ┌────────────┐
│    NAS       │ │    IOT     │
│ RPi 5 8GB    │ │ RPi 3B+    │
│              │ │            │
│ 8 cont.      │ │ 4 cont.    │
│ LLM: Qwen    │ │ SEM LLM    │
│    1.5B      │ │ (MQTT)     │
└──────────────┘ └────────────┘
```

> _OpenClaw Agent (WhatsApp/Telegram/Discord/Email/SMS + RPA Browser Control) integrado ao Mordomo com LLM próprio — economia de $230 em hardware_

---

## 🏗️ Arquitetura de Hardware

| # | Hardware | Módulo | LLM | Preço | Função Principal |
|---|----------|--------|-----|-------|------------------|
| 1 | Orange Pi 5 16GB | **Aslam Central + OpenClaw** | Cloud (fallback Qwen 1.5B) + Gemini Flash | $130 | Assistente de voz + Comunicação + RPA (25 containers: 16 Aslam + 5 Infra + 4 Monitoramento) |
| 2 | Jetson Orin Nano | Segurança | Qwen 3B Vision | $249 | Câmeras, YOLOv8, reconhecimento facial |
| 3 | Raspberry Pi 3B+ | IoT | **SEM LLM** | $83 | ESP32 DIY, Access Point Wi-Fi, MQTT, BLE presence |
| 4 | Raspberry Pi 5 4GB | Pagamentos | Qwen 1.5B | $60 | PIX, Open Banking, antifraud |
| 5 | Raspberry Pi 5 16GB | Investimentos | Qwen 3B | $120 | Trading, apostas, ML predição |
| 6 | Raspberry Pi 5 8GB | Entretenimento | Qwen 1.5B | $80 | Jellyfin, downloads, streaming |
| 7 | Raspberry Pi 5 8GB | NAS | Qwen 1.5B | $355 | Storage, backup, deduplicação |

> _Comunicação e RPA foram integrados ao Aslam Central via OpenClaw Agent (economia de $230)_

### Custo-Benefício de Cada Plataforma

| Hardware | Preço | Quando Usar |
|----------|-------|-------------|
| **Orange Pi 5 16GB** | $130 | NPU necessária (Mordomo + OpenClaw) — RAM extra para containers |
| **Raspberry Pi 5 8GB** | $80 | Maioria dos módulos (melhor suporte comunitário) |
| **Jetson Orin Nano** | $249 | Visão AI intensiva (Segurança) — 1024 CUDA cores |
| **Raspberry Pi 3B+** | $35 | IoT sem LLM (baixíssima latência) |

> Orange Pi vs RPi 5: Diferença de $30, mas RPi tem ecossistema gigante + disponibilidade global

---

## 📁 Estrutura do Repositório

```
mordomo-system-estudos-ia/
├── README.md                              # ← ESTE DOCUMENTO (visão consolidada)
├── VISAO_MACRO_COMPLETA.md                # Análise técnica detalhada
├── MARKET_BENCHMARK.md                    # Benchmark competitivo (60+ projetos)
├── ANALISE_LIVEKIT_vs_MORDOMO.md          # Comparação LiveKit Agents
│
└── hardware/
    ├── README.md                          # Visão geral + análise custo-benefício
    │
    ├── mordomo - (orange-pi-5-16gb)/      # CENTRAL — 25 containers
    │   └── ecossistemas/
    │       ├── mordomo/                   # 16 containers (STT + TTS + Core + OpenClaw)
    │       ├── infraestrutura/            # 5 containers (NATS, Consul, Qdrant, PG, App)
    │       └── monitoramento/             # 4 containers (Prometheus, Loki, Grafana, Promtail)
    │
    ├── seguranca - (jetson-orin-nano)/    # MÓDULO 1 — 7 containers + Vision AI
    │   └── ecossistemas/seguranca/
    │
    ├── iot - (raspberry-pi-3b)/           # MÓDULO 2 — 4 containers (SEM LLM)
    │   └── ecossistemas/iot/
    │
    ├── pagamentos - (raspberry-pi-5-4gb)/ # MÓDULO 3 — 6 containers
    │   └── ecossistemas/pagamentos/
    │
    ├── investimentos - (raspberry-pi-5-16gb)/ # MÓDULO 4 — 7 containers
    │   └── ecossistemas/investimentos/
    │
    ├── entretenimento - (raspberry-pi-5-8gb)/ # MÓDULO 5 — 6 containers
    │   └── ecossistemas/entretenimento/
    │
    └── nas - (raspberry-pi-5-8gb)/        # MÓDULO 6 — 8 containers
        └── ecossistemas/nas/
```

### Organização dos Repositórios (GitHub)

Cada container vive em seu próprio repositório dentro da [organização AslamSys](https://github.com/orgs/AslamSys/repositories):

```
AslamSys/
├── _system                         # Orchestration central (docker-compose + docs)
├── aslam-*                         # 16 containers (Orange Pi 5 16GB)
│   ├── aslam-orchestrator
│   ├── aslam-brain
│   ├── aslam-whisper-asr
│   └── ...
├── seguranca-*                     # 7 containers (Jetson Orin Nano)
├── iot-*                           # 3 containers (Raspberry Pi 3B)
├── pagamentos-*                    # 6 containers (RPi 5 4GB)
├── investimentos-*                 # 7 containers (RPi 5 16GB)
├── entretenimento-*                # 6 containers (RPi 5 8GB)
└── nas-*                           # 8 containers (RPi 5 8GB)
```

---

## 🧠 Ecossistema 1 — Mordomo Central (Orange Pi 5 16GB)

Sistema central de assistente de voz com processamento completo de áudio, reconhecimento, LLM, síntese de voz, **OpenClaw Agent** (comunicação multi-canal + RPA browser com LLM próprio).

**Containers: 25 total** = 16 aplicação + 5 infraestrutura + 4 monitoramento

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

### 🧠 CORE — Orquestração + Brain (5 containers)

| # | Container | Função | Recursos |
|---|-----------|--------|----------|
| 9 | `mordomo-orchestrator` | Unificação de session + LLM service + action dispatcher + event system + semantic cache (FAISS) | 2.5GB RAM, 120% CPU |
| 10 | `system-watchdog` | Proteção térmica + DEFCON levels (5→1) + auto-shutdown >85°C | 100MB RAM, 15% CPU |
| 11 | `mordomo-brain` | RAG + Raciocínio avançado multi-step (Qdrant) | 500MB RAM, 30% CPU |
| 12 | `skills-runner` | Python Sandbox para skills dinâmicas (seguro, com limites CPU/RAM) | 300MB RAM, 20% CPU |
| 13 | `core-gateway` | API Gateway (HTTP/WebSocket + rate limiting + auth) | 150MB RAM, 10% CPU |

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

### 🏗️ Infraestrutura (5 containers)

| # | Container | Função | Recursos |
|---|-----------|--------|----------|
| 15 | `nats` | Message broker (pub/sub + request/reply, <1ms latência) | 100-200MB RAM, 10-20% CPU |
| 16 | `consul` | Service discovery + health checks | 150MB RAM, 15% CPU |
| 17 | `qdrant` | Vector database para RAG (embeddings de conversas + busca semântica) | 500MB RAM, 30% CPU |
| 18 | `postgres` | Banco relacional (histórico conversas, usuários, permissões) | 200MB RAM, 20% CPU |
| 19 | `aslam-app` | Tablet interface (React + WebSocket real-time) | 300MB RAM, 40% CPU |

### 📊 Monitoramento (4 containers)

| # | Container | Função | Recursos |
|---|-----------|--------|----------|
| 20 | `prometheus` | Métricas time-series (scrape a cada 15s) | 400MB RAM, 35% CPU |
| 21 | `loki` | Logs centralizados (todos containers) | 300MB RAM, 25% CPU |
| 22 | `grafana` | Dashboards de visualização | 250MB RAM, 30% CPU |
| 23 | `promtail` | Log collector via Docker API | 80MB RAM, 10% CPU |

### 📦 Totais de Recursos (Orange Pi 5 16GB)

| Recurso | Alocação | Capacidade | Uso |
|---------|----------|------------|-----|
| **RAM** | ~6.0GB | 16GB | 38% (63% livre) |
| **CPU** | ~180-330% | 800% (8 cores) | 23-41% |
| **Storage** | 17GB containers + 10GB dados | SSD NVMe 256GB | — |

**Breakdown de RAM:** STT 1.38GB · TTS 95MB · CORE 3.55GB · OpenClaw 1.2GB (2.0GB com browser)

**LLM Strategy:** Cloud-first (Claude 3.5 Sonnet, GPT-4o, Gemini 2.0 Flash) via LiteLLM → Fallback Qwen 2.5 1.5B quantized Q4 (500MB RAM)

---

## 📱 Ecossistema 2 — IoT (Raspberry Pi 3B+ 1GB)

Automação residencial com ESP32 DIY + Access Point Wi-Fi dedicado (**SEM LLM**).

### Containers (4 total)

| # | Container | Função | Recursos |
|---|-----------|--------|----------|
| 1 | `iot-orchestrator` | Traduz NATS → MQTT, recebe comandos do Mordomo | 180MB RAM, 25% CPU |
| 2 | `mqtt-broker` | Eclipse Mosquitto (broker MQTT local 10.0.0.x, retain messages) | 100MB RAM, 15% CPU |
| 3 | `iot-state-cache` | Redis — estados em tempo real (<5ms, 50-100 devices ESP32) | 80MB RAM, 10% CPU |
| 4 | `bluetooth-scanner` | BLE presence detection (smartphones, Mi Band, RSSI proximidade) | 60MB RAM, 12% CPU |

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

## 💳 Ecossistema 5 — Pagamentos (Raspberry Pi 5 4GB)

PIX, Open Banking, detecção de fraudes, emissão de boletos/NFe.

### Containers (6 total)

| # | Container | Função | RAM |
|---|-----------|--------|-----|
| 1 | `pagamentos-brain` | LLM Qwen 1.5B | 2.5GB |
| 2 | `pix-gateway` | API Bacen + PSPs | 384MB |
| 3 | `open-banking` | Pluggy/Belvo | 512MB |
| 4 | `fraud-detector` | Isolation Forest ML | 256MB |
| 5 | `invoice-generator` | Boletos/NFe | 192MB |
| 6 | `wallet-integrator` | PicPay, Mercado Pago | 256MB |

### Totais de Recursos

| Recurso | Valor |
|---------|-------|
| **RAM** | 4.1GB / 4GB (103% — swap 1GB) |
| **CPU** | 335% / 400% (84% uso) |
| **LLM** | Qwen 1.5B Q4_K_M (0.9GB VRAM) |

---

## 📈 Ecossistema 6 — Investimentos (Raspberry Pi 5 16GB)

Trading automatizado (ações, cripto, forex), ML predição, apostas esportivas.

### Containers (7 total)

| # | Container | Função | RAM |
|---|-----------|--------|-----|
| 1 | `investimentos-brain` | LLM Qwen 3B | 3GB |
| 2 | `stock-trading-bot` | Binance/B3 | 2GB |
| 3 | `technical-analysis` | TA-Lib | 3GB |
| 4 | `news-sentiment` | FinBERT | 2.5GB |
| 5 | `betting-bot` | Bet365/Pinnacle | 1GB |
| 6 | `ml-predictor` | LSTM + LightGBM | 3GB |
| 7 | `portfolio-manager` | Gestão de portfólio | 1.5GB |

### Totais de Recursos

| Recurso | Valor |
|---------|-------|
| **RAM** | 16GB / 16GB (100% uso) |
| **CPU** | 450% / 400% (113% — ajustado) |
| **LLM** | Qwen 3B Q4_K_M (1.8GB VRAM) |

---

## 🎬 Ecossistema 7 — Entretenimento (Raspberry Pi 5 8GB)

Media server (Jellyfin), downloads automáticos, controle de TV/Som.

### Containers (6 total)

| # | Container | Função | RAM |
|---|-----------|--------|-----|
| 1 | `entretenimento-brain` | LLM Qwen 1.5B | 2.5GB |
| 2 | `media-server` | Jellyfin | 1.5GB |
| 3 | `download-manager` | qBittorrent | 512MB |
| 4 | `media-organizer` | Radarr + Sonarr | 768MB |
| 5 | `subtitle-fetcher` | Bazarr | 256MB |
| 6 | `streaming-aggregator` | Netflix/Spotify APIs | 512MB |

### Totais de Recursos

| Recurso | Valor |
|---------|-------|
| **RAM** | 6GB / 8GB (75% uso) |
| **CPU** | 360% / 400% (90% uso) |
| **Storage** | HD Externo 2TB USB 3.0 |
| **LLM** | Qwen 1.5B Q4_K_M (0.9GB VRAM) |

---

## 💾 Ecossistema 8 — NAS (Raspberry Pi 5 8GB)

Backup automático de fotos do iPhone, armazenamento centralizado, deduplicação.

### Containers (8 total)

| # | Container | Função | RAM |
|---|-----------|--------|-----|
| 1 | `nas-brain` | LLM Qwen 1.5B | 2.5GB |
| 2 | `file-sync` | Syncthing | 512MB |
| 3 | `photo-backup` | PhotoPrism + iCloud | 1.5GB |
| 4 | `object-storage` | MinIO S3 | 1GB |
| 5 | `deduplication` | Btrfs + rmlint | 768MB |
| 6 | `smb-server` | Samba | 384MB |
| 7 | `backup-manager` | Restic | 512MB |
| 8 | `media-indexer` | AI tagging | 1GB |

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
| Orange Pi 5 16GB | 1 | $130 | $130 |
| Raspberry Pi 5 16GB | 1 | $120 | $120 |
| Raspberry Pi 5 8GB | 3 | $80 | $240 |
| Raspberry Pi 5 4GB | 1 | $60 | $60 |
| Raspberry Pi 3B+ | 1 | $35 | $35 |
| Jetson Orin Nano 8GB | 1 | $249 | $249 |
| Periféricos (fontes, cases, cabos) | — | — | $243 |

### Armazenamento ($462)

| Item | Preço |
|------|-------|
| MicroSD cards (7x) | ~$112 |
| HDD 4TB (2x RAID 1) | $180 |
| SSD NVMe 1TB (NAS tiering) | $70 |
| SSD NVMe 256GB (Mordomo) | $35 |
| HD Externo 2TB (Entretenimento) | $65 |

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
| ESP32 DIY vs Zigbee | $240 | $3/device vs $15/device (50-100 devices) |
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

> Detalhes completos: [MARKET_BENCHMARK.md](MARKET_BENCHMARK.md)

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
| **Hardwares** | 7 dispositivos independentes |
| **RAM Total** | 61GB (16+8+1+4+16+8+8) |
| **CPU Total** | 40 cores (diversos ARM64) |
| **Armazenamento** | 12TB+ (MicroSDs + HDs + SSDs) |
| **NPU/GPU** | 6 TOPS (NPU) + 1024 CUDA cores |
| **Consumo Energia** | 47-75W médio |
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
- [ ] Deploy Aslam (Orange Pi 5 16GB)
  - [ ] NATS Cluster (3 nodes)
  - [ ] Consul (service discovery)
  - [ ] Qdrant (vector DB para RAG)
  - [ ] PostgreSQL (dados relacionais)
  - [ ] Prometheus + Loki + Grafana
  - [ ] Brain Aslam (Qwen 2.5 3B)
  - [ ] OpenClaw Agent (Comunicação + RPA)

### 📅 Fases 3-7: Módulos Incrementais
- [ ] **Fase 3:** IoT (RPi 3B+) — Automação básica
- [ ] **Fase 4:** Segurança (Jetson) — Câmeras + Vision AI
- [ ] **Fase 5:** Entretenimento (RPi 5 8GB) — Media server
- [ ] **Fase 6:** Pagamentos (RPi 5 4GB) — PIX + Open Banking
- [ ] **Fase 7:** Investimentos (RPi 5 16GB) — Trading bots

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
| Pagamentos (RPi 5 4GB) | Alta — RAM 103% (swap) precisa validação |
| Investimentos (RPi 5 16GB) | Média — RAM 100% precisa validação |
| Entretenimento (RPi 5 8GB) | Média |
| NAS (RPi 5 8GB) | Média — RAM 103% (swap) precisa validação |

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

| Hardware | README | Containers | Status |
|----------|--------|------------|--------|
| Orange Pi 5 16GB (Mordomo) | [Ver](hardware/mordomo%20-%20(orange-pi-5-16gb)/README.md) | 25 (16+5+4) | ✅ Auditado |
| Jetson Orin Nano (Segurança) | [Ver](hardware/seguranca%20-%20(jetson-orin-nano)/README.md) | 7 + LLM Vision | ✅ Documentado |
| RPi 3B+ (IoT) | [Ver](hardware/iot%20-%20(raspberry-pi-3b)/README.md) | 4 (ESP32 DIY) | ✅ Auditado |
| RPi 5 4GB (Pagamentos) | [Ver](hardware/pagamentos%20-%20(raspberry-pi-5-4gb)/README.md) | 6 + LLM | ✅ Documentado |
| RPi 5 16GB (Investimentos) | [Ver](hardware/investimentos%20-%20(raspberry-pi-5-16gb)/README.md) | 7 + LLM | ✅ Documentado |
| RPi 5 8GB (Entretenimento) | [Ver](hardware/entretenimento%20-%20(raspberry-pi-5-8gb)/README.md) | 6 + LLM | ✅ Documentado |
| RPi 5 8GB (NAS) | [Ver](hardware/nas%20-%20(raspberry-pi-5-8gb)/README.md) | 8 + LLM | ✅ Documentado |

### Documentação Geral

| Documento | Descrição |
|-----------|-----------|
| [hardware/README.md](hardware/README.md) | Visão geral de hardware + análise custo-benefício |
| [VISAO_MACRO_COMPLETA.md](VISAO_MACRO_COMPLETA.md) | Análise técnica detalhada de todos os ecossistemas |
| [MARKET_BENCHMARK.md](MARKET_BENCHMARK.md) | 60+ projetos pesquisados + benchmark competitivo |
| [ANALISE_LIVEKIT_vs_MORDOMO.md](ANALISE_LIVEKIT_vs_MORDOMO.md) | Comparação técnica LiveKit Agents vs Mordomo |
| [ecossistemas/README.md](hardware/mordomo%20-%20(orange-pi-5-16gb)/ecossistemas/README.md) | 3 ecossistemas do Mordomo (app, infra, monitoring) |
| [ecossistemas/SUMARIO.md](hardware/mordomo%20-%20(orange-pi-5-16gb)/ecossistemas/SUMARIO.md) | Guia de leitura completo |

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
