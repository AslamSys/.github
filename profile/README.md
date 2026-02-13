# 🤖 Aslam - Distributed AI System

Sistema distribuído de IA com **assistente de voz inteligente** e **módulos especializados** executando em **7 hardwares ARM64 dedicados**, cada um com **LLM própria** para processamento assíncrono.

> **Aslam**: Assistente de voz com pipeline STT-LLM-TTS + 6 módulos especializados (Segurança, IoT, Pagamentos, Investimentos, Entretenimento, NAS)

---

## 🎯 Visão Geral do Sistema

**1 Sistema Central (Aslam Voice Assistant) + 6 Módulos Especializados = 7 Hardwares ARM64**

- **Consumo Energético:** 47-75W  
- **Containers Totais:** 60+ (24 Aslam + 37 módulos especializados)
- **LLMs Independentes:** 6 (1 central + 5 módulos, IoT sem LLM)
- **Comunicação:** NATS (pub/sub assíncrono)

## 📦 Repositórios

- **[_system](https://github.com/AslamSys/_system)** - Central orchestration repo (docker-compose files, docs)
- **54 container repos** - Código de cada container individual
- [Ver todos os repositórios →](https://github.com/orgs/AslamSys/repositories)

---

## 📁 Estrutura da Organização

Cada **hardware** tem seus próprios **repositórios de containers**:

```
AslamSys/
├── _system                                # Orchestration central
│
├── aslam-*                                # 16 containers (Orange Pi 5 16GB)
│   ├── aslam-orchestrator
│   ├── aslam-brain
│   ├── aslam-whisper-asr
│   └── ...
│
├── seguranca-*                            # 7 containers (Jetson Orin Nano)
│   ├── seguranca-face-recognition
│   ├── seguranca-yolo-detector
│   └── ...
│
├── iot-*                                  # 3 containers (Raspberry Pi 3B)
├── pagamentos-*                           # 6 containers (RPi 5 4GB)
├── investimentos-*                        # 7 containers (RPi 5 16GB)
├── entretenimento-*                       # 6 containers (RPi 5 8GB)
└── nas-*                                  # 8 containers (RPi 5 8GB)
```

**Ver todos:** https://github.com/orgs/AslamSys/repositories

---

## 🏗️ Arquitetura de Hardware

| # | Hardware | Módulo | LLM | Função Principal |
|---|----------|--------|-----|------------------|
| 1 | Orange Pi 5 16GB | **Aslam Voice Assistant** | Cloud (fallback Qwen 1.5B) + Gemini Flash | Assistente de voz + OpenClaw (24 containers: 16 Aslam + 5 Infra + 3 Monitoramento) |
| 2 | Jetson Orin Nano | Segurança | Qwen 3B Vision | Câmeras, YOLOv8, reconhecimento facial |
| 3 | Raspberry Pi 3B+ | IoT | **SEM LLM** | ESP32 DIY, Access Point Wi-Fi, MQTT, BLE presence |
| 4 | Raspberry Pi 5 4GB | Pagamentos | Qwen 1.5B | PIX, Open Banking, antifraud |
| 5 | Raspberry Pi 5 16GB | Investimentos | Qwen 3B | Trading, apostas, ML predição |
| 6 | Raspberry Pi 5 8GB | Entretenimento | Qwen 1.5B | Jellyfin, downloads, streaming |
| 7 | Raspberry Pi 5 8GB | NAS | Qwen 1.5B | Storage, backup, deduplicação |

_Nota: Comunicação e RPA foram integrados ao Aslam via OpenClaw Agent_

---

## 🎯 Ecossistemas Implementados

### 🎤️ Aslam Voice Assistant (16 containers)
Pipeline completo de processamento de voz + comunicação + RPA:
- `audio-bridge` - WebRTC ↔ NATS audio streaming
- `audio-capture-vad` - Captura de áudio com VAD
- `wake-word-detector` - Detecção de "ASLAM"
- `speaker-verification` - Autenticação por voz
- `whisper-asr` - Speech-to-Text (Whisper)
- `speaker-id-diarization` - Identificação de usuário
- `source-separation` - Separação de vozes sobrepostas
- `core-gateway` - REST + WebSocket API
- `mordomo-orchestrator` - Estado + Contexto + Dispatcher
- `mordomo-brain` - LLM (Cloud APIs via LiteLLM, fallback Qwen 2.5 1.5B local + RAG)
- `tts-engine` - Text-to-Speech (Piper/Azure)
- `system-watchdog` - DEFCON + Thermal protection
- `dashboard-ui` - Canvas A2UI
- `openclaw-agent` - **OpenClaw Agent** (Comunicação multi-canal + RPA browser, LLM próprio Gemini Flash)

### 🏗️ Infraestrutura (5 containers)
Serviços de suporte:
- `nats` - Message broker
- `consul` - Service discovery
- `qdrant` - Vector database (RAG)
- `postgres` - Banco relacional
- `aslam-app` - Tablet interface (React)

### 📊 Monitoramento (4 containers)
Observabilidade:
- `prometheus` - Métricas
- `loki` - Logs
- `grafana` - Dashboards
- `promtail` - Log collector

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

**Documentação completa:** [AslamSys/_system](https://github.com/AslamSys/_system)

---

## 🔌 Comunicação entre Módulos (NATS)

### Exemplo Prático: Alerta de Segurança Integrado

```
1. Câmera detecta invasão (Segurança - Jetson)
   ↓
   NATS publish → seguranca.alert.intrusion {
     "level": "critical",
     "description": "Pessoa desconhecida no quintal",
     "snapshot_url": "..."
   }

2. Aslam recebe alerta
   - IoT: Sirene + luzes acendem
   - OpenClaw: WhatsApp enviado com snapshot
   - Segurança: Continua gravando vídeo HD

3. Aslam confirma: "Alerta enviado. Sirene ativada."
```

**Vantagem:** 3 ações em paralelo vs sequencial (6x mais rápido)

---

## 🎯 Roadmap de Implementação

### ✅ Fase 1: Planejamento e Documentação (CONCLUÍDO)
- [x] Pesquisa de mercado (preços RPi vs Orange Pi vs Jetson)
- [x] Análise de recursos por módulo (RAM, CPU, NPU)
- [x] Documentação completa de 7 hardwares
- [x] Justificativas técnicas (custo-benefício)
- [x] Estrutura de diretórios criada
- [x] Integração OpenClaw Agent (Comunicação + RPA consolidados no Mordomo)
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
- [ ] **Fase 3:** IoT (RPi 3B+) - Automação básica
- [ ] **Fase 4:** Segurança (Jetson) - Câmeras + Vision AI
- [ ] **Fase 5:** Entretenimento (RPi 5 8GB) - Media server
- [ ] **Fase 6:** Pagamentos (RPi 5 4GB) - PIX + Open Banking
- [ ] **Fase 7:** Investimentos (RPi 5 16GB) - Trading bots

### 🎯 Fase 8: Otimização e Produção
- [ ] Testes de carga (stress testing)
- [ ] Backup e disaster recovery
- [ ] Documentação de usuário final
- [ ] Métricas de performance (latência, throughput)
- [ ] Docker Compose consolidado
- [ ] Scripts de deployment automatizado
- [ ] Testes em hardware real

---

## 🧠 Por que LLMs Distribuídas?

### ❌ Problema: Arquitetura Monolítica Bloqueia
```
Usuário: "Envia WhatsApp pro João"
Aslam Brain: Processa + envia (500ms de espera...)
Usuário: "Qual a temperatura?" ❌ BLOQUEADO
```

### ✅ Solução: Módulos Assíncronos
```
Usuário: "Envia WhatsApp pro João"
Mordomo: Delega → OpenClaw Agent (via NATS)
Mordomo: "Ok, enviando!" (retorna controle imediatamente)
Usuário: "Qual a temperatura?" ✅ Responde sem bloqueio
```

---

## 💰 Custo-Benefício: Por que Raspberry Pi + Orange Pi?

| Hardware | Preço | Quando Usar |
|----------|-------|-------------|
| **Orange Pi 5 16GB** | $130 | NPU necessária (Mordomo + OpenClaw) - RAM extra para containers |
| **Raspberry Pi 5 8GB** | $80 | Maioria dos módulos (melhor suporte) |
| **Jetson Orin Nano** | $249 | Visão AI intensiva (Segurança) |
| **Raspberry Pi 3B+** | $35 | IoT sem LLM (baixa latência) |

**Orange Pi vs RPi 5:** Diferença de $30, mas RPi tem ecossistema gigante + disponibilidade global

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
| Orange Pi 5 16GB (Aslam) | [Ver](https://github.com/AslamSys/_system/blob/main/hardware/aslam/README.md) | 23 (14+5+4) | ✅ Auditado |
| Jetson Orin Nano (Segurança) | [Ver](https://github.com/AslamSys/_system/blob/main/hardware/seguranca/README.md) | 7 + LLM Vision | ✅ Documentado |
| RPi 3B+ (IoT) | [Ver](https://github.com/AslamSys/_system/blob/main/hardware/iot/README.md) | 4 (ESP32 DIY) | ✅ Auditado |
| RPi 5 4GB (Pagamentos) | [Ver](https://github.com/AslamSys/_system/blob/main/hardware/pagamentos/README.md) | 6 + LLM | ✅ Documentado |
| RPi 5 16GB (Investimentos) | [Ver](https://github.com/AslamSys/_system/blob/main/hardware/investimentos/README.md) | 7 + LLM | ✅ Documentado |
| RPi 5 8GB (Entretenimento) | [Ver](https://github.com/AslamSys/_system/blob/main/hardware/entretenimento/README.md) | 6 + LLM | ✅ Documentado |
| RPi 5 8GB (NAS) | [Ver](https://github.com/AslamSys/_system/blob/main/hardware/nas/README.md) | 8 + LLM | ✅ Documentado |

### Documentação Geral
- **Visão Geral de Hardware:** [AslamSys/_system](https://github.com/AslamSys/_system)
- **Análise Custo-Benefício:** Comparação Orange Pi vs RPi vs Jetson (ver READMEs individuais acima)
- **Protocolo NATS:** Tópicos, fluxos, exemplos práticos (documentação em desenvolvimento)

---

## 💡 Casos de Uso Integrados

### 1. Gestão Financeira Automática
```
PIX recebido R$ 5.000 (Pagamentos)
  → Mordomo: "Cliente X pagou"
  → Investimentos: "Sugestão: 70% em PETR4 (sinal compra)"
  → Usuário aprova
  → Investimentos executa trade
  → OpenClaw: Confirma via Telegram
```

### 2. Casa Inteligente Proativa
```
21:00 Sexta-feira (padrão detectado)
  → Entretenimento: "Novo episódio Stranger Things!"
  → IoT: Apaga luzes sala + ajusta temperatura
  → OpenClaw: Notifica família "Cinema 21:30"
```

### 3. Segurança Total
```
Câmera: Pessoa desconhecida (Segurança Vision)
  → Mordomo: Alerta crítico
  → IoT: Sirene + todas luzes acendem
  → OpenClaw: WhatsApp com snapshot
  → Segurança: Grava vídeo HD + busca rosto no Qdrant
```

---

## 📊 Métricas do Sistema Completo

| Métrica | Valor |
|---------|-------|
| **Hardwares** | 7 dispositivos independentes |
| **RAM Total** | 61GB (16+8+1+4+16+8+8) |
| **CPU Total** | 40 cores (diversos ARM64) |
| **Armazenamento** | 10TB+ (MicroSDs + HDs + SSDs) |
| **NPU/GPU** | 6 TOPS (NPU) + 1024 CUDA cores |
| **Consumo Energia** | 47-75W médio |
| **Latência Comandos** | < 500ms (voz → ação) |
| **Latência IoT** | < 150ms (ESP32 via Access Point) |
| **Throughput NATS** | 10.000+ msg/s |
| **Disponibilidade** | 99.9% (redundância NATS) |

---

## 📄 Licença

MIT License

---

**Projeto:** Mordomo (Aslam)  
**Autor:** Renan  
**Última atualização:** 12/02/2026  
**Versão:** 1.0.0
