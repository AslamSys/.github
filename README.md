# 🤖 Aslam System — Workspace Central

> **Este repositório `.github` serve como hub central para visualizar, navegar e gerenciar todos os 55 repositórios do projeto Aslam de uma só vez.**

---

## 🚀 Quick Start — Abrir o Workspace Completo

### 1. Clonar todos os repositórios

```powershell
# PowerShell (Windows)
cd C:\Users\renanb3137_00\AslamSys\.github
.\scripts\clone-all-repos.ps1
```

```bash
# Bash (Linux/Mac)
cd ~/AslamSys/.github
chmod +x scripts/clone-all-repos.sh
./scripts/clone-all-repos.sh
```

### 2. Abrir o workspace no VS Code

```powershell
code aslam-system.code-workspace
```

Isso abre **todos os 55 repositórios** organizados por ecossistema no VS Code — com emojis, agrupados por hardware.

---

## 📊 Mapa Completo do Sistema

```
                    ┌─────────────────────────────────────┐
                    │   NATS Message Broker (Central)     │
                    │   Orange Pi 5 16GB                  │
                    └───────────┬─────────────────────────┘
                                │
        ┌───────────────────────┼────────────────────────────┐
        │                       │                            │
   ┌────▼────────┐    ┌────────▼────────┐    ┌──────────▼──────────┐
   │ 🧠 ASLAM    │    │ 🏗️ INFRA       │    │ 📊 MONITORAMENTO    │
   │   BRAIN     │    │ NATS+Consul    │    │ Prometheus+Grafana  │
   │  16 cont.   │    │ Qdrant+PG+App  │    │ Loki+Promtail      │
   │  STT+TTS    │    │  5 containers  │    │  4 containers       │
   │  Core+OClaw │    │                │    │                     │
   └──────┬──────┘    └────────────────┘    └─────────────────────┘
          │
          │ NATS pub/sub (<1ms)
          │
  ┌───────┼──────────────────────────────────────────────┐
  │       │           │            │           │         │
┌─▼──┐ ┌──▼──┐ ┌─────▼────┐ ┌────▼───┐ ┌─────▼──┐ ┌────▼──┐
│🛡️  │ │📱   │ │💳        │ │📈      │ │🎬      │ │💾     │
│SEG │ │IOT  │ │PAGAMENTO │ │INVEST. │ │ENTRET. │ │NAS    │
│7c  │ │4c   │ │6c        │ │7c      │ │6c      │ │8c     │
│Jet.│ │RPi3 │ │RPi5-4GB  │ │RPi5-16 │ │RPi5-8  │ │RPi5-8 │
└────┘ └─────┘ └──────────┘ └────────┘ └────────┘ └───────┘
```

**Totais:** 7 hardwares · 71+ containers · 6 LLMs · 61GB RAM · 40 CPU cores

---

## 📁 Estrutura do Workspace

O arquivo `aslam-system.code-workspace` organiza tudo assim:

| Emoji | Ecossistema | Hardware | Repos | Containers |
|-------|-------------|----------|-------|------------|
| 📋 | `_system` | — | 1 | Orchestration (docker-compose + docs) |
| 🏠 | `.github` | — | 1 | Este repo (overview) |
| 🎤 | Mordomo — STT | Orange Pi 5 16GB | 6 | audio-capture-vad, wake-word, speaker-verify, whisper, diarization, source-sep |
| 🔊 | Mordomo — TTS | Orange Pi 5 16GB | 2 | tts-engine, audio-bridge |
| 🧠 | Mordomo — Core | Orange Pi 5 16GB | 7 | orchestrator, brain, watchdog, skills, gateway, dispatcher, dashboard |
| 🐙 | Mordomo — OpenClaw | Orange Pi 5 16GB | 1 | openclaw-agent (4 módulos internos) |
| 📱 | IoT | RPi 3B+ 1GB | 3 | orchestrator, mqtt-broker, state-cache |
| 🛡️ | Segurança | Jetson Orin Nano | 7 | brain, cameras, yolo, face-rec, events, alerts, recorder |
| 💳 | Pagamentos | RPi 5 4GB | 6 | brain, pix, open-banking, fraud, invoices, wallets |
| 📈 | Investimentos | RPi 5 16GB | 7 | brain, trading, tech-analysis, sentiment, betting, ml, portfolio |
| 🎬 | Entretenimento | RPi 5 8GB | 6 | brain, media-server, radarr, sonarr, bazarr, streaming |
| 💾 | NAS | RPi 5 8GB | 8 | brain, file-sync, photo-backup, object-storage, dedup, smb, backup, indexer |

---

## 🔗 Links Rápidos

| Recurso | Link |
|---------|------|
| **Organização GitHub** | [github.com/AslamSys](https://github.com/AslamSys) |
| **Todos os Repos** | [github.com/orgs/AslamSys/repositories](https://github.com/orgs/AslamSys/repositories) |
| **_system (Orchestration)** | [github.com/AslamSys/_system](https://github.com/AslamSys/_system) |
| **Visão Macro Completa** | [VISAO_MACRO_COMPLETA.md](https://github.com/renancaf/mordomo-system-estudos-ia/blob/main/VISAO_MACRO_COMPLETA.md) |
| **Market Benchmark** | [MARKET_BENCHMARK.md](https://github.com/renancaf/mordomo-system-estudos-ia/blob/main/MARKET_BENCHMARK.md) |
| **Análise LiveKit vs Aslam** | [ANALISE_LIVEKIT_vs_MORDOMO.md](https://github.com/renancaf/mordomo-system-estudos-ia/blob/main/ANALISE_LIVEKIT_vs_MORDOMO.md) |

---

## 📦 Repositórios por Ecossistema

### 🧠 Ecossistema 1 — Mordomo Central (Orange Pi 5 16GB) — 25 containers

> Sistema central de assistente de voz: STT → LLM → TTS + OpenClaw (Comunicação + RPA)

| Área | Repositório | Função |
|------|-------------|--------|
| **STT** | [mordomo-audio-capture-vad](https://github.com/AslamSys/mordomo-audio-capture-vad) | Captura áudio + Voice Activity Detection |
| **STT** | [mordomo-wake-word-detector](https://github.com/AslamSys/mordomo-wake-word-detector) | Detecção de "ASLAM" (Porcupine) |
| **STT** | [mordomo-speaker-verification](https://github.com/AslamSys/mordomo-speaker-verification) | Autenticação por voz (ECAPA-TDNN) |
| **STT** | [mordomo-whisper-asr](https://github.com/AslamSys/mordomo-whisper-asr) | Transcrição fala→texto (Whisper base) |
| **STT** | [mordomo-speaker-id-diarization](https://github.com/AslamSys/mordomo-speaker-id-diarization) | Identificação de quem fala (Pyannote) |
| **STT** | [mordomo-source-separation](https://github.com/AslamSys/mordomo-source-separation) | Separação de vozes sobrepostas |
| **TTS** | [mordomo-tts-engine](https://github.com/AslamSys/mordomo-tts-engine) | Síntese de voz (Piper / Azure TTS) |
| **TTS** | [mordomo-audio-bridge](https://github.com/AslamSys/mordomo-audio-bridge) | WebRTC ↔ NATS streaming (Rust) |
| **Core** | [mordomo-orchestrator](https://github.com/AslamSys/mordomo-orchestrator) | Session + LLM + Dispatcher + Events + Cache |
| **Core** | [mordomo-brain](https://github.com/AslamSys/mordomo-brain) | RAG + Raciocínio avançado (Qdrant) |
| **Core** | [mordomo-system-watchdog](https://github.com/AslamSys/mordomo-system-watchdog) | Proteção térmica + DEFCON levels |
| **Core** | [mordomo-skills-runner](https://github.com/AslamSys/mordomo-skills-runner) | Python sandbox para skills |
| **Core** | [mordomo-core-gateway](https://github.com/AslamSys/mordomo-core-gateway) | API Gateway (HTTP/WS + auth) |
| **Core** | [mordomo-action-dispatcher](https://github.com/AslamSys/mordomo-action-dispatcher) | Roteamento de ações via NATS |
| **Core** | [mordomo-dashboard-ui](https://github.com/AslamSys/mordomo-dashboard-ui) | Dashboard web (React) |
| **OpenClaw** | [mordomo-openclaw-agent](https://github.com/AslamSys/mordomo-openclaw-agent) | Comunicação multi-canal + RPA + LLM próprio |

### 📱 Ecossistema 2 — IoT (Raspberry Pi 3B+ 1GB) — 4 containers

> Automação residencial com ESP32 DIY + Access Point Wi-Fi (SEM LLM)

| Repositório | Função |
|-------------|--------|
| [iot-orchestrator](https://github.com/AslamSys/iot-orchestrator) | Traduz NATS → MQTT |
| [iot-mqtt-broker](https://github.com/AslamSys/iot-mqtt-broker) | Eclipse Mosquitto |
| [iot-state-cache](https://github.com/AslamSys/iot-state-cache) | Redis — estados tempo real |

### 🛡️ Ecossistema 4 — Segurança (Jetson Orin Nano 8GB) — 7 containers

> 4 câmeras + YOLO + reconhecimento facial + análise comportamental

| Repositório | Função |
|-------------|--------|
| [seguranca-brain](https://github.com/AslamSys/seguranca-brain) | LLM Qwen 3B Vision |
| [seguranca-camera-stream-manager](https://github.com/AslamSys/seguranca-camera-stream-manager) | RTSP + NVENC |
| [seguranca-yolo-detector](https://github.com/AslamSys/seguranca-yolo-detector) | YOLOv8n TensorRT |
| [seguranca-face-recognition](https://github.com/AslamSys/seguranca-face-recognition) | FaceNet |
| [seguranca-event-analyzer](https://github.com/AslamSys/seguranca-event-analyzer) | Análise de comportamento |
| [seguranca-alert-manager](https://github.com/AslamSys/seguranca-alert-manager) | Alertas via NATS |
| [seguranca-video-recorder](https://github.com/AslamSys/seguranca-video-recorder) | Gravação 24/7 |

### 💳 Ecossistema 5 — Pagamentos (Raspberry Pi 5 4GB) — 6 containers

> PIX, Open Banking, detecção de fraudes, boletos/NFe

| Repositório | Função |
|-------------|--------|
| [pagamentos-brain](https://github.com/AslamSys/pagamentos-brain) | LLM Qwen 1.5B |
| [pagamentos-pix-gateway](https://github.com/AslamSys/pagamentos-pix-gateway) | API Bacen + PSPs |
| [pagamentos-open-banking](https://github.com/AslamSys/pagamentos-open-banking) | Pluggy/Belvo |
| [pagamentos-fraud-detector](https://github.com/AslamSys/pagamentos-fraud-detector) | Isolation Forest ML |
| [pagamentos-invoice-generator](https://github.com/AslamSys/pagamentos-invoice-generator) | Boletos/NFe |
| [pagamentos-wallet-integrator](https://github.com/AslamSys/pagamentos-wallet-integrator) | PicPay, Mercado Pago |

### 📈 Ecossistema 6 — Investimentos (Raspberry Pi 5 16GB) — 7 containers

> Trading automatizado, ML predição, apostas esportivas

| Repositório | Função |
|-------------|--------|
| [investimentos-brain](https://github.com/AslamSys/investimentos-brain) | LLM Qwen 3B |
| [investimentos-trading-bot](https://github.com/AslamSys/investimentos-trading-bot) | Binance/B3 |
| [investimentos-technical-analysis](https://github.com/AslamSys/investimentos-technical-analysis) | TA-Lib |
| [investimentos-news-sentiment](https://github.com/AslamSys/investimentos-news-sentiment) | FinBERT |
| [investimentos-betting-bot](https://github.com/AslamSys/investimentos-betting-bot) | Bet365/Pinnacle |
| [investimentos-ml-predictor](https://github.com/AslamSys/investimentos-ml-predictor) | LSTM + LightGBM |
| [investimentos-portfolio-manager](https://github.com/AslamSys/investimentos-portfolio-manager) | Gestão de portfólio |

### 🎬 Ecossistema 7 — Entretenimento (Raspberry Pi 5 8GB) — 6 containers

> Media server, downloads automáticos, controle de mídia

| Repositório | Função |
|-------------|--------|
| [entretenimento-brain](https://github.com/AslamSys/entretenimento-brain) | LLM Qwen 1.5B |
| [entretenimento-media-server](https://github.com/AslamSys/entretenimento-media-server) | Jellyfin |
| [entretenimento-radarr-movies](https://github.com/AslamSys/entretenimento-radarr-movies) | Radarr (filmes) |
| [entretenimento-sonarr-series](https://github.com/AslamSys/entretenimento-sonarr-series) | Sonarr (séries) |
| [entretenimento-bazarr-subtitles](https://github.com/AslamSys/entretenimento-bazarr-subtitles) | Bazarr (legendas) |
| [entretenimento-streaming-aggregator](https://github.com/AslamSys/entretenimento-streaming-aggregator) | Netflix/Spotify APIs |

### 💾 Ecossistema 8 — NAS (Raspberry Pi 5 8GB) — 8 containers

> Backup automático, armazenamento centralizado, deduplicação

| Repositório | Função |
|-------------|--------|
| [nas-brain](https://github.com/AslamSys/nas-brain) | LLM Qwen 1.5B |
| [nas-file-sync](https://github.com/AslamSys/nas-file-sync) | Syncthing |
| [nas-photo-backup](https://github.com/AslamSys/nas-photo-backup) | PhotoPrism + iCloud |
| [nas-object-storage](https://github.com/AslamSys/nas-object-storage) | MinIO S3 |
| [nas-deduplication](https://github.com/AslamSys/nas-deduplication) | Btrfs + rmlint |
| [nas-smb-server](https://github.com/AslamSys/nas-smb-server) | Samba |
| [nas-backup-manager](https://github.com/AslamSys/nas-backup-manager) | Restic |
| [nas-media-indexer](https://github.com/AslamSys/nas-media-indexer) | AI tagging |

---

## 📊 Status de Implementação

| Ecossistema | Status | Containers | Auditado |
|-------------|--------|------------|----------|
| **Mordomo Central + OpenClaw** | ✅ Implementado | 25 (16+5+4) | ✅ Completo |
| **IoT** | ✅ Implementado | 4 | ✅ Completo |
| Segurança | 📋 Especificado | 7 | ❌ Pendente |
| Pagamentos | 📋 Especificado | 6 | ❌ Pendente |
| Investimentos | 📋 Especificado | 7 | ❌ Pendente |
| Entretenimento | 📋 Especificado | 6 | ❌ Pendente |
| NAS | 📋 Especificado | 8 | ❌ Pendente |

---

## 🏗️ Como Contribuir / Desenvolver

1. **Abrir o workspace** — `code aslam-system.code-workspace`
2. **Navegar por ecossistema** — Os repos aparecem agrupados por emoji/hardware no Explorer
3. **Busca global** — `Ctrl+Shift+F` busca em todos os 55 repos de uma vez
4. **Terminal por repo** — Clique direito em qualquer repo → "Open in Integrated Terminal"

### Convenções

- Cada repo = 1 container Docker
- Comunicação entre módulos = **NATS pub/sub**
- Padrão de tópicos: `{modulo}.{recurso}.{acao}`
- Docker Compose central em `_system`

---

<div align="center">

**Projeto Aslam** · 7 hardwares · 71+ containers · 6 LLMs · $1.579 investimento

*[AslamSys](https://github.com/AslamSys) · Renan · 2026*

</div>
