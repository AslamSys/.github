# ═══════════════════════════════════════════════════════════════
# 🤖 Aslam System — Clone All Repositories (PowerShell)
# ═══════════════════════════════════════════════════════════════
# Clona todos os 55 repositórios da organização AslamSys
# para que o workspace funcione corretamente.
#
# Uso:  .\scripts\clone-all-repos.ps1
# ═══════════════════════════════════════════════════════════════

$ErrorActionPreference = "Continue"

$Org = "AslamSys"
$BaseDir = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

# Se chamado de fora do scripts/, ajustar
if (-not (Test-Path "$BaseDir\.github")) {
    $BaseDir = Split-Path $PSScriptRoot -Parent
    $BaseDir = Split-Path $BaseDir -Parent
}

Write-Host "══════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "🤖 Aslam System — Clonando todos os repositórios" -ForegroundColor Cyan
Write-Host "📂 Diretório base: $BaseDir" -ForegroundColor Gray
Write-Host "══════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

$Repos = @(
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

$Total = $Repos.Count
$Cloned = 0
$Skipped = 0
$Failed = 0
$i = 0

foreach ($repo in $Repos) {
    $i++
    $Target = Join-Path $BaseDir $repo
    
    if (Test-Path $Target) {
        Write-Host "⏭️  [$i/$Total] $repo — já existe, pulando" -ForegroundColor Yellow
        $Skipped++
    } else {
        Write-Host "📥 [$i/$Total] Clonando $repo..." -ForegroundColor Green
        $result = git clone "https://github.com/$Org/$repo.git" $Target 2>&1
        if ($LASTEXITCODE -eq 0) {
            $Cloned++
        } else {
            Write-Host "   ❌ Falha ao clonar $repo" -ForegroundColor Red
            $Failed++
        }
    }
}

Write-Host ""
Write-Host "══════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "✅ Concluído!" -ForegroundColor Green
Write-Host "   📥 Clonados: $Cloned" -ForegroundColor Green
Write-Host "   ⏭️  Já existiam: $Skipped" -ForegroundColor Yellow
Write-Host "   ❌ Falhas: $Failed" -ForegroundColor Red
Write-Host "   📊 Total: $Total repositórios" -ForegroundColor White
Write-Host ""
Write-Host "🚀 Agora abra o workspace:" -ForegroundColor Cyan
Write-Host "   code `"$BaseDir\.github\aslam-system.code-workspace`"" -ForegroundColor White
Write-Host "══════════════════════════════════════════════" -ForegroundColor Cyan
