#!/bin/bash
# ═══════════════════════════════════════════════════════════════
# 🤖 Aslam System — Clone All Repositories
# ═══════════════════════════════════════════════════════════════
# Clona todos os 55 repositórios da organização AslamSys
# para que o workspace funcione corretamente.
#
# Uso:  chmod +x scripts/clone-all-repos.sh
#       ./scripts/clone-all-repos.sh
# ═══════════════════════════════════════════════════════════════

set -e

ORG="AslamSys"
BASE_DIR="$(cd "$(dirname "$0")/../.." && pwd)"

echo "══════════════════════════════════════════════"
echo "🤖 Aslam System — Clonando todos os repositórios"
echo "📂 Diretório base: $BASE_DIR"
echo "══════════════════════════════════════════════"
echo ""

# Lista completa de repositórios (extraída de repos-github.txt)
REPOS=(
  # ── Orchestration ──
  "_system"

  # ── Mordomo Central (Orange Pi 5 16GB) — 16 containers ──
  "mordomo-audio-capture-vad"
  "mordomo-wake-word-detector"
  "mordomo-speaker-verification"
  "mordomo-whisper-asr"
  "mordomo-speaker-id-diarization"
  "mordomo-source-separation"
  "mordomo-tts-engine"
  "mordomo-audio-bridge"
  "mordomo-orchestrator"
  "mordomo-brain"
  "mordomo-system-watchdog"
  "mordomo-skills-runner"
  "mordomo-core-gateway"
  "mordomo-action-dispatcher"
  "mordomo-dashboard-ui"
  "mordomo-openclaw-agent"

  # ── IoT (Raspberry Pi 3B+) — 3 containers ──
  "iot-orchestrator"
  "iot-mqtt-broker"
  "iot-state-cache"

  # ── Segurança (Jetson Orin Nano) — 7 containers ──
  "seguranca-brain"
  "seguranca-camera-stream-manager"
  "seguranca-yolo-detector"
  "seguranca-face-recognition"
  "seguranca-event-analyzer"
  "seguranca-alert-manager"
  "seguranca-video-recorder"

  # ── Pagamentos (RPi 5 4GB) — 6 containers ──
  "pagamentos-brain"
  "pagamentos-pix-gateway"
  "pagamentos-open-banking"
  "pagamentos-fraud-detector"
  "pagamentos-invoice-generator"
  "pagamentos-wallet-integrator"

  # ── Investimentos (RPi 5 16GB) — 7 containers ──
  "investimentos-brain"
  "investimentos-trading-bot"
  "investimentos-technical-analysis"
  "investimentos-news-sentiment"
  "investimentos-betting-bot"
  "investimentos-ml-predictor"
  "investimentos-portfolio-manager"

  # ── Entretenimento (RPi 5 8GB) — 6 containers ──
  "entretenimento-brain"
  "entretenimento-media-server"
  "entretenimento-radarr-movies"
  "entretenimento-sonarr-series"
  "entretenimento-bazarr-subtitles"
  "entretenimento-streaming-aggregator"

  # ── NAS (RPi 5 8GB) — 8 containers ──
  "nas-brain"
  "nas-file-sync"
  "nas-photo-backup"
  "nas-object-storage"
  "nas-deduplication"
  "nas-smb-server"
  "nas-backup-manager"
  "nas-media-indexer"
)

TOTAL=${#REPOS[@]}
CLONED=0
SKIPPED=0
FAILED=0

for repo in "${REPOS[@]}"; do
  TARGET="$BASE_DIR/$repo"
  
  if [ -d "$TARGET" ]; then
    echo "⏭️  [$((CLONED + SKIPPED + FAILED + 1))/$TOTAL] $repo — já existe, pulando"
    SKIPPED=$((SKIPPED + 1))
  else
    echo "📥 [$((CLONED + SKIPPED + FAILED + 1))/$TOTAL] Clonando $repo..."
    if git clone "https://github.com/$ORG/$repo.git" "$TARGET" 2>/dev/null; then
      CLONED=$((CLONED + 1))
    else
      echo "❌ Falha ao clonar $repo"
      FAILED=$((FAILED + 1))
    fi
  fi
done

echo ""
echo "══════════════════════════════════════════════"
echo "✅ Concluído!"
echo "   📥 Clonados: $CLONED"
echo "   ⏭️  Já existiam: $SKIPPED"
echo "   ❌ Falhas: $FAILED"
echo "   📊 Total: $TOTAL repositórios"
echo ""
echo "🚀 Agora abra o workspace:"
echo "   code $BASE_DIR/.github/aslam-system.code-workspace"
echo "══════════════════════════════════════════════"
