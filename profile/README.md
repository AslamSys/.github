# 🤖 Aslam — Distributed AI System

<div align="center">

**Sistema distribuído de IA com assistente de voz inteligente e módulos especializados executando em 7 hardwares ARM64 dedicados, cada um com LLM própria para processamento assíncrono.**

> *Aslam: Assistente de voz com pipeline STT→LLM→TTS + 6 módulos especializados*
> *(Segurança, IoT, Pagamentos, Investimentos, Entretenimento, NAS)*

[![System](https://img.shields.io/badge/📚_system-Orchestration-blue)](https://github.com/AslamSys/_system)
[![Repos](https://img.shields.io/badge/Containers-55_repos-blue)](https://github.com/orgs/AslamSys/repositories)
[![License](https://img.shields.io/badge/License-MIT-green)](#-licença)
[![Status](https://img.shields.io/badge/Fase-1_Concluída-brightgreen)](#-roadmap-de-implementação)

</div>

---

## 📊 Resumo Executivo

| Métrica | Valor |
|---------|-------|
| **Hardwares** | 7 dispositivos ARM64 independentes |
| **Investimento Total** | $1.579 (hardware $1.077 + armazenamento $462 + rede $40) |
| **Containers Totais** | 71+ (25 Aslam + 46 módulos especializados) |
| **LLMs Independentes** | 6 (1 central + 5 módulos; IoT sem LLM; Comunicação/RPA integrados) |
| **Consumo Energético** | 47-75W (≈ 438 kWh/ano ≈ R$350/ano) |
| **Comunicação** | NATS pub/sub (<1ms latência) |
| **Armazenamento** | 12TB+ (HDDs + SSDs + MicroSDs) |
| **RAM Total** | 61GB · **CPU Total** 40 cores · **NPU/GPU** 6 TOPS + 1024 CUDA |
| **Latência Voz→Ação** | < 500ms (target < 400ms) |
| **Latência IoT** | < 150ms (ESP32 via Access Point — mais rápido que Zigbee) |
| **Economia obtida** | $230 (OpenClaw) + $240 (ESP32 DIY vs Zigbee) |

### Status de Implementação

| Módulo | Status | Containers | Auditado |
|--------|--------|------------|----------|
| **Aslam Central + OpenClaw** | ✅ Implementado | 25 (16+5+4) | ✅ Completo |
| **IoT** | ✅ Implementado | 4 | ✅ Completo |
| Segurança | 📋 Especificado | 7 | ❌ Pendente |
| Pagamentos | 📋 Especificado | 6 | ❌ Pendente |
| Investimentos | 📋 Especificado | 7 | ❌ Pendente |
| Entretenimento | 📋 Especificado | 6 | ❌ Pendente |
| NAS | 📋 Especificado | 8 | ❌ Pendente |

---

## 🔗 Navegação Rápida

### Documentação por Hardware

| Hardware | Link | Containers |
|----------|------|------------|
| 🏠 Aslam Central (Orange Pi 5 16GB) | [README](https://github.com/AslamSys/_system/blob/main/hardware/mordomo%20-%20(orange-pi-5-16gb)/README.md) | 25 |
| 🔒 Segurança (Jetson Orin Nano) | [README](https://github.com/AslamSys/_system/blob/main/hardware/seguranca%20-%20(jetson-orin-nano)/README.md) | 7 |
| 🏢 IoT (Raspberry Pi 3B+) | [README](https://github.com/AslamSys/_system/blob/main/hardware/iot%20-%20(raspberry-pi-3b)/README.md) | 4 |
| 💰 Pagamentos (RPi 5 4GB) | [README](https://github.com/AslamSys/_system/blob/main/hardware/pagamentos%20-%20(raspberry-pi-5-4gb)/README.md) | 6 |
| 📈 Investimentos (RPi 5 16GB) | [README](https://github.com/AslamSys/_system/blob/main/hardware/investimentos%20-%20(raspberry-pi-5-16gb)/README.md) | 7 |
| 🎬 Entretenimento (RPi 5 8GB) | [README](https://github.com/AslamSys/_system/blob/main/hardware/entretenimento%20-%20(raspberry-pi-5-8gb)/README.md) | 6 |
| 💾 NAS (RPi 5 8GB) | [README](https://github.com/AslamSys/_system/blob/main/hardware/nas%20-%20(raspberry-pi-5-8gb)/README.md) | 8 |

### Repositórios

- 📚 [**_system** (Orchestration)](https://github.com/AslamSys/_system) — Docker-compose + Documentação completa
- 🗂️ [**Todos os repositórios**](https://github.com/orgs/AslamSys/repositories) — 55 repos (containers individuais)

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

> _OpenClaw Agent (WhatsApp/Telegram/Discord/Email/SMS + RPA Browser) integrado ao Aslam com LLM próprio — economia de $230_

---

## 🏗️ Arquitetura de Hardware

| # | Hardware | Módulo | LLM | Preço | Função Principal |
|---|----------|--------|-----|-------|------------------|
| 1 | Orange Pi 5 16GB | **Aslam Central + OpenClaw** | Cloud (fallback Qwen 1.5B) + Gemini Flash | $130 | Assistente de voz + Comunicação + RPA (25 containers) |
| 2 | Jetson Orin Nano | Segurança | Qwen 3B Vision | $249 | Câmeras, YOLOv8, reconhecimento facial |
| 3 | Raspberry Pi 3B+ | IoT | **SEM LLM** | $83 | ESP32 DIY, Access Point Wi-Fi, MQTT, BLE |
| 4 | Raspberry Pi 5 4GB | Pagamentos | Qwen 1.5B | $60 | PIX, Open Banking, antifraud |
| 5 | Raspberry Pi 5 16GB | Investimentos | Qwen 3B | $120 | Trading, apostas, ML predição |
| 6 | Raspberry Pi 5 8GB | Entretenimento | Qwen 1.5B | $80 | Jellyfin, downloads, streaming |
| 7 | Raspberry Pi 5 8GB | NAS | Qwen 1.5B | $355 | Storage, backup, deduplicação |

> _Comunicação e RPA integrados ao Aslam via OpenClaw Agent (economia de $230)_

---

## 📁 Estrutura da Organização

Cada container vive em seu próprio repositório:

```
AslamSys/
├── _system                         # Orchestration central (docker-compose + docs)
│
├── aslam-*                         # 16 containers (Orange Pi 5 16GB)
│   ├── aslam-orchestrator
│   ├── aslam-brain
│   ├── aslam-whisper-asr
│   └── ...
│
├── seguranca-*                     # 7 containers (Jetson Orin Nano)
│   ├── seguranca-face-recognition
│   ├── seguranca-yolo-detector
│   └── ...
│
├── iot-*                           # 3 containers (Raspberry Pi 3B)
├── pagamentos-*                    # 6 containers (RPi 5 4GB)
├── investimentos-*                 # 7 containers (RPi 5 16GB)
├── entretenimento-*                # 6 containers (RPi 5 8GB)
└── nas-*                           # 8 containers (RPi 5 8GB)
```

[**Ver todos os 55 repositórios →**](https://github.com/orgs/AslamSys/repositories)

---

## 🧠 Ecossistema 1 — Aslam Central (Orange Pi 5 16GB)

Sistema central: pipeline de voz + orquestração + comunicação + RPA. **25 containers** (16 app + 5 infra + 4 monitoramento).

### 🎤 STT — Speech-to-Text (6 containers)

| Container | Função | Modelo/Tech | Recursos |
|-----------|--------|-------------|----------|
| `audio-capture-vad` | Captura áudio com VAD | VAD 0.5, PCM 16kHz | 50MB RAM |
| `wake-word-detector` | Detecção de "ASLAM" | Porcupine/Pocketsphinx (<100ms) | 80MB RAM |
| `speaker-verification` | Autenticação por voz | ECAPA-TDNN | 150MB RAM |
| `whisper-asr` | Transcrição fala→texto | Whisper base 74M (200-400ms) | 400MB RAM |
| `speaker-id-diarization` | Quem está falando | Pyannote + embeddings | 300MB RAM |
| `source-separation` | Separação de vozes | Spleeter/Demucs (condicional) | 400MB RAM |

### 🔊 TTS — Text-to-Speech (2 containers)

| Container | Função | Recursos |
|-----------|--------|----------|
| `tts-engine` | Síntese de voz (Piper/Azure, 80-150ms) | 80MB RAM |
| `audio-bridge` | WebRTC ↔ NATS streaming (Rust, zero-copy) | 15MB RAM |

### 🧠 CORE — Orquestração + Brain (5 containers)

| Container | Função | Recursos |
|-----------|--------|----------|
| `mordomo-orchestrator` | Session + LLM service + dispatcher + events + semantic cache (FAISS) | 2.5GB RAM |
| `system-watchdog` | Proteção térmica + DEFCON levels (5→1) + auto-shutdown >85°C | 100MB RAM |
| `mordomo-brain` | RAG + Raciocínio avançado multi-step (Qdrant) | 500MB RAM |
| `skills-runner` | Python Sandbox para skills dinâmicas (seguro) | 300MB RAM |
| `core-gateway` | API Gateway (HTTP/WS + rate limiting + auth) | 150MB RAM |

### 🐙 OpenClaw Agent — Comunicação + RPA (1 container, 4 módulos)

| Container | Função | Recursos |
|-----------|--------|----------|
| `openclaw-agent` | Agente unificado: Gateway multi-canal + Browser RPA + Skills Hub + Brain Bridge | 1.2GB (2.0GB com browser) |

**Módulos internos:**
- **Gateway** — WhatsApp (Baileys), Telegram (grammY), Discord, Email, SMS
- **Browser RPA** — Chromium headless via CDP (on-demand, +800MB)
- **Skills Hub** — MordomoHub registry (auto-discovery Consul, hot-reload)
- **Brain Bridge** — NATS bridge → Orchestrator (request-reply + retry)
- **LLM próprio:** Gemini Flash 2.0 / GPT-4o-mini — decide se resolve local ou escalona

### 🏗️ Infraestrutura (5 containers)

`nats` (message broker) · `consul` (service discovery) · `qdrant` (vector DB/RAG) · `postgres` (relacional) · `aslam-app` (tablet React)

### 📊 Monitoramento (4 containers)

`prometheus` (métricas) · `loki` (logs) · `grafana` (dashboards) · `promtail` (collector)

### 📦 Totais de Recursos

| Recurso | Uso | Capacidade |
|---------|-----|------------|
| **RAM** | ~6.0GB (38%) | 16GB |
| **CPU** | 23-41% | 800% (8 cores) |
| **LLM** | Cloud-first (Claude/GPT/Gemini) via LiteLLM → Fallback Qwen 2.5 1.5B Q4 (500MB) |  |

---

## 📱 Ecossistema 2 — IoT (Raspberry Pi 3B+ 1GB)

Automação residencial com ESP32 DIY + Access Point Wi-Fi dedicado (**SEM LLM**).

| Container | Função | RAM |
|-----------|--------|-----|
| `iot-orchestrator` | Traduz NATS → MQTT | 180MB |
| `mqtt-broker` | Eclipse Mosquitto (10.0.0.x) | 100MB |
| `iot-state-cache` | Redis (<5ms, 50-100 devices) | 80MB |
| `bluetooth-scanner` | BLE presence (smartphones, Mi Band) | 60MB |

**Total:** 420MB/1GB (42%) · Latência <150ms · ESP32 $3 cada (5x economia vs Zigbee)

---

## 💬 Ecossistema 3 — Comunicação & RPA → ✅ Integrado ao Aslam

**1 container OpenClaw substitui 7 standalone** — economia $230 hardware + $35/ano energia.
Browser RPA: Chromium headless via CDP (+800MB on-demand).
Decisão inteligente: LLM próprio (Gemini Flash) resolve local ou escalona via NATS.

---

## 🛡️ Ecossistema 4 — Segurança (Jetson Orin Nano 8GB)

4 câmeras + YOLO + reconhecimento facial + análise de comportamento.

| Container | Função | RAM | VRAM |
|-----------|--------|-----|------|
| `seguranca-brain` | Qwen 3B Vision | 4GB | 2GB |
| `camera-stream-manager` | RTSP + NVENC | 1GB | 256MB |
| `yolo-detector` | YOLOv8n TensorRT | 512MB | 1.5GB |
| `face-recognition` | FaceNet | 768MB | 512MB |
| `event-analyzer` | Análise comportamento | 384MB | — |
| `alert-manager` | Alertas NATS | 256MB | — |
| `storage-manager` | Gravação 24/7 | 512MB | 256MB |

**Total:** 7.43GB/8GB (93%) · 1024 CUDA cores · Qwen 3B Vision Q4_K_M

---

## 💳 Ecossistema 5 — Pagamentos (Raspberry Pi 5 4GB)

| Container | Função | RAM |
|-----------|--------|-----|
| `pagamentos-brain` | Qwen 1.5B | 2.5GB |
| `pix-gateway` | API Bacen + PSPs | 384MB |
| `open-banking` | Pluggy/Belvo | 512MB |
| `fraud-detector` | Isolation Forest ML | 256MB |
| `invoice-generator` | Boletos/NFe | 192MB |
| `wallet-integrator` | PicPay, MP | 256MB |

**Total:** 4.1GB/4GB (swap 1GB) · Qwen 1.5B Q4_K_M

---

## 📈 Ecossistema 6 — Investimentos (Raspberry Pi 5 16GB)

| Container | Função | RAM |
|-----------|--------|-----|
| `investimentos-brain` | Qwen 3B | 3GB |
| `stock-trading-bot` | Binance/B3 | 2GB |
| `technical-analysis` | TA-Lib | 3GB |
| `news-sentiment` | FinBERT | 2.5GB |
| `betting-bot` | Bet365/Pinnacle | 1GB |
| `ml-predictor` | LSTM + LightGBM | 3GB |
| `portfolio-manager` | Gestão de portfólio | 1.5GB |

**Total:** 16GB/16GB (100%) · Qwen 3B Q4_K_M

---

## 🎬 Ecossistema 7 — Entretenimento (Raspberry Pi 5 8GB)

| Container | Função | RAM |
|-----------|--------|-----|
| `entretenimento-brain` | Qwen 1.5B | 2.5GB |
| `media-server` | Jellyfin | 1.5GB |
| `download-manager` | qBittorrent | 512MB |
| `media-organizer` | Radarr + Sonarr | 768MB |
| `subtitle-fetcher` | Bazarr | 256MB |
| `streaming-aggregator` | Netflix/Spotify APIs | 512MB |

**Total:** 6GB/8GB (75%) · HD Externo 2TB USB 3.0 · Qwen 1.5B Q4_K_M

---

## 💾 Ecossistema 8 — NAS (Raspberry Pi 5 8GB)

| Container | Função | RAM |
|-----------|--------|-----|
| `nas-brain` | Qwen 1.5B | 2.5GB |
| `file-sync` | Syncthing | 512MB |
| `photo-backup` | PhotoPrism + iCloud | 1.5GB |
| `object-storage` | MinIO S3 | 1GB |
| `deduplication` | Btrfs + rmlint | 768MB |
| `smb-server` | Samba | 384MB |
| `backup-manager` | Restic | 512MB |
| `media-indexer` | AI tagging | 1GB |

**Total:** 8.2GB/8GB (swap 1GB) · 2x HDD 4TB RAID 1 + SSD NVMe 1TB · Qwen 1.5B Q4_K_M

---

## 🔌 Comunicação entre Módulos (NATS)

**Formato dos tópicos:** `{modulo}.{recurso}.{acao}`

```yaml
# Aslam Central
mordomo.speech.transcribed    mordomo.brain.response_generated
mordomo.tts.generate_request  mordomo.action.completed

# OpenClaw Agent
mordomo.openclaw.gateway.send          openclaw.response.{request_id}
mordomo.openclaw.browser.scrape        openclaw.notification

# IoT                          # Segurança
iot.device.control             seguranca.alert.intrusion
iot.device.state_changed       seguranca.camera.snapshot

# Pagamentos                   # Investimentos
pagamentos.pix.send            investimentos.order.create
pagamentos.pix.received        investimentos.portfolio.balance

# Entretenimento               # NAS
entretenimento.play.movie      nas.file.uploaded
entretenimento.download.complete  nas.backup.completed
```

### Exemplo: Alerta de Segurança Integrado

```
1. Câmera detecta invasão (Segurança - Jetson)
   → NATS: seguranca.alert.intrusion { "level": "critical", "snapshot_url": "..." }

2. Aslam recebe → Dispatcher despacha 3 ações paralelas:
   a) iot.device.control → Sirene + luzes
   b) openclaw.gateway.send → WhatsApp com snapshot
   c) seguranca.recording.start → Vídeo HD

3. Executam em paralelo (~150ms total)
4. Aslam: "Alerta enviado. Sirene ativada."
```

**Vantagem:** 3 ações paralelas → **6x mais rápido** que sequencial

---

## ⚡ Benchmark de Latência vs Mercado

| Componente | Aslam (Target) | LiveKit Agents | Pipecat | Vapi.ai | Retell AI |
|------------|----------------|----------------|---------|---------|-----------|
| **VAD** | <10ms | <10ms (Silero) | <10ms | <10ms | <10ms |
| **Wake Word** | <100ms | N/A | N/A | N/A | N/A |
| **STT** | <300ms | <200ms (Deepgram) | <250ms | <150ms | <200ms |
| **LLM** | <500ms | <300ms (GPT-4o) | <400ms | <200ms | <300ms |
| **TTS** | <200ms | <100ms (Cartesia) | <150ms | <100ms | <100ms |
| **Total** | **<500ms** | **~400ms** | **~500ms** | **~300ms** | **~500ms** |
| **IoT Action** | **<150ms** | N/A | N/A | N/A | N/A |

- ✅ **IoT <150ms** → Mais rápido que todos (ESP32 + Access Point local)
- 🎯 **Target:** <400ms com Silero VAD + Cartesia TTS + Faster-Whisper

---

## 🏅 Diferenciais Únicos

| # | Diferencial | Detalhe |
|---|-------------|---------|
| 1 | **Arquitetura Distribuída** | 7 hardwares especializados — ninguém no mercado faz isso |
| 2 | **IoT Mais Rápido** | ESP32 <150ms vs Zigbee 300-500ms (2-3x mais rápido) |
| 3 | **Multi-LLM** | 6 LLMs independentes + 1 OpenClaw = nunca bloqueia |
| 4 | **Privacy-First** | LLM local + Cloud fallback (seamless handoff) |
| 5 | **Custo Fixo** | $1.579 one-time vs Vapi/Retell $0.10-0.50/min |
| 6 | **NATS Modular** | Adicionar módulos sem reescrever — plug & play |
| 7 | **Multi-Speaker** | Speaker Verification + ID + contextos + permissões (GUEST→ADMIN) |
| 8 | **Observabilidade** | Prometheus + Loki + Grafana (métricas de tudo) |
| 9 | **OpenClaw Agent** | Comunicação + RPA em 1 container com LLM próprio |

---

## 🧠 Por que LLMs Distribuídas?

### ❌ Monolítica Bloqueia
```
Usuário: "Envia WhatsApp pro João"
Brain: Processa + envia (500ms de espera...)
Usuário: "Qual a temperatura?" ❌ BLOQUEADO
```

### ✅ Módulos Assíncronos
```
Usuário: "Envia WhatsApp pro João"
Aslam: Delega → OpenClaw Agent (via NATS)
Aslam: "Ok, enviando!" (retorna imediatamente)
Usuário: "Qual a temperatura?" ✅ Responde sem bloqueio
```

---

## 💡 Casos de Uso Integrados

### 1. 💰 Gestão Financeira Automática
```
PIX recebido R$ 5.000 (Pagamentos)
  → Aslam: "Cliente X pagou"
  → Investimentos: "Sugestão: 70% em PETR4 (sinal compra)"
  → Usuário aprova por voz → Trade executado
  → OpenClaw: Confirma via Telegram
```

### 2. 🏠 Casa Inteligente Proativa
```
21:00 Sexta-feira (padrão detectado via ML)
  → Entretenimento: "Novo episódio Stranger Things!"
  → IoT: Apaga luzes + ajusta temp 22°C
  → OpenClaw: Notifica família "Cinema 21:30"
```

### 3. 🔒 Segurança Total
```
Câmera: Pessoa desconhecida (Vision AI)
  → Aslam: Alerta crítico (DEFCON 2)
  → IoT: Sirene + todas luzes acendem
  → OpenClaw: WhatsApp com snapshot
  → Segurança: Grava HD + busca rosto no Qdrant
```

---

## 💰 Investimento Detalhado

### Hardware ($1.077)
| Item | Total |
|------|-------|
| Orange Pi 5 16GB | $130 |
| Raspberry Pi 5 16GB | $120 |
| Raspberry Pi 5 8GB (3x) | $240 |
| Raspberry Pi 5 4GB | $60 |
| Raspberry Pi 3B+ | $35 |
| Jetson Orin Nano 8GB | $249 |
| Periféricos | $243 |

### Armazenamento ($462) + Rede ($40)
MicroSD (7x) $112 · HDD 4TB RAID 1 $180 · SSD NVMe 1TB $70 · SSD 256GB $35 · HD Ext 2TB $65 · Switch 8p $25 · Cabos $15

### Energia ≈ R$350/ano
50W médio × 24h × 365d = 438 kWh/ano × R$0.80 = **R$350/ano (~$70/ano)**

**TOTAL INICIAL: $1.579** · **OPERACIONAL: ~$70/ano**

---

## 🎯 Roadmap de Implementação

### ✅ Fase 1: Planejamento e Documentação (CONCLUÍDO)
- [x] Pesquisa de mercado + análise de recursos por módulo
- [x] Documentação completa de 7 hardwares (7 READMEs detalhados)
- [x] Integração OpenClaw Agent (Comunicação + RPA consolidados)
- [x] Benchmark competitivo (60+ projetos pesquisados)

### ⏳ Fase 2: Infraestrutura Central (Próximo)
- [ ] Deploy Aslam (Orange Pi 5 16GB) — NATS, Consul, Qdrant, PostgreSQL, Prometheus/Loki/Grafana, Brain, OpenClaw

### 📅 Fases 3-7: Módulos Incrementais
- [ ] **3:** IoT (RPi 3B+) · **4:** Segurança (Jetson) · **5:** Entretenimento (RPi 5 8GB) · **6:** Pagamentos (RPi 5 4GB) · **7:** Investimentos (RPi 5 16GB)

### 🎯 Fase 8: Otimização e Produção
- [ ] Testes de carga · Backup/DR · Docker Compose consolidado · Deploy automatizado · Testes em hardware real

---

## 🚀 Quick Start

```bash
# 1. Clone o repositório central
git clone https://github.com/AslamSys/_system
cd _system

# 2. Configurar environment
cp .env.example .env

# 3. Iniciar containers do Aslam (Orange Pi 5)
docker compose -f hardware/aslam/docker-compose.yml up -d

# 4. Verificar status
docker compose ps

# 5. Acessar dashboards
# Grafana: http://orange-pi:3000 · Dashboard: http://orange-pi:80
```

---

## 📚 Documentação Completa

| Hardware | README | Containers | Status |
|----------|--------|------------|--------|
| Orange Pi 5 16GB (Aslam) | [Ver](https://github.com/AslamSys/_system/blob/main/hardware/mordomo%20-%20(orange-pi-5-16gb)/README.md) | 25 (16+5+4) | ✅ Auditado |
| Jetson Orin Nano (Segurança) | [Ver](https://github.com/AslamSys/_system/blob/main/hardware/seguranca%20-%20(jetson-orin-nano)/README.md) | 7 + Vision | ✅ Documentado |
| RPi 3B+ (IoT) | [Ver](https://github.com/AslamSys/_system/blob/main/hardware/iot%20-%20(raspberry-pi-3b)/README.md) | 4 (ESP32 DIY) | ✅ Auditado |
| RPi 5 4GB (Pagamentos) | [Ver](https://github.com/AslamSys/_system/blob/main/hardware/pagamentos%20-%20(raspberry-pi-5-4gb)/README.md) | 6 + LLM | ✅ Documentado |
| RPi 5 16GB (Investimentos) | [Ver](https://github.com/AslamSys/_system/blob/main/hardware/investimentos%20-%20(raspberry-pi-5-16gb)/README.md) | 7 + LLM | ✅ Documentado |
| RPi 5 8GB (Entretenimento) | [Ver](https://github.com/AslamSys/_system/blob/main/hardware/entretenimento%20-%20(raspberry-pi-5-8gb)/README.md) | 6 + LLM | ✅ Documentado |
| RPi 5 8GB (NAS) | [Ver](https://github.com/AslamSys/_system/blob/main/hardware/nas%20-%20(raspberry-pi-5-8gb)/README.md) | 8 + LLM | ✅ Documentado |

**Documentação adicional:** [Visão Macro Completa](https://github.com/renancaf/mordomo-system-estudos-ia/blob/main/VISAO_MACRO_COMPLETA.md) · [Market Benchmark](https://github.com/renancaf/mordomo-system-estudos-ia/blob/main/MARKET_BENCHMARK.md) · [LiveKit Análise](https://github.com/renancaf/mordomo-system-estudos-ia/blob/main/ANALISE_LIVEKIT_vs_MORDOMO.md)

---

## 📊 Métricas do Sistema

| Métrica | Valor |
|---------|-------|
| **Hardwares** | 7 dispositivos ARM64 |
| **RAM Total** | 61GB |
| **CPU Total** | 40 cores |
| **Armazenamento** | 12TB+ |
| **NPU/GPU** | 6 TOPS + 1024 CUDA |
| **Consumo** | 47-75W |
| **Latência Voz→Ação** | < 500ms |
| **Latência IoT** | < 150ms |
| **NATS Throughput** | 10.000+ msg/s |
| **Disponibilidade** | 99.9% |

---

## 📄 Licença

MIT License

---

<div align="center">

**Aslam** · **Autor:** Renan · **Versão:** 2.0.0 · **Última atualização:** 13/02/2026

*7 hardwares · 71+ containers · 6 LLMs · <500ms latência · $1.579 investimento*

</div>
