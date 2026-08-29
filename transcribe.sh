#!/usr/bin/env bash
# Transcribe a video/audio file using Azure AI Foundry Speech (Fast Transcription API).
#
# Usage:
#   ./transcribe.sh <path-to-video-or-audio> [output-name]
#
# Requires: ffmpeg, az cli (logged in), VPN connected (private endpoint only).
# See CLAUDE.md for the full explanation of why this approach was used.
set -euo pipefail
cd "$(dirname "$0")"
source ./config.sh

if [ $# -lt 1 ]; then
  echo "Usage: $0 <path-to-video-or-audio> [output-name]" >&2
  exit 1
fi

INPUT_FILE="$1"
if [ ! -f "$INPUT_FILE" ]; then
  echo "File not found: $INPUT_FILE" >&2
  exit 1
fi

BASENAME="$(basename "$INPUT_FILE")"
DEFAULT_NAME="${BASENAME%.*}"
OUTPUT_NAME="${2:-$DEFAULT_NAME}"

OUT_DIR="./transcripts/$OUTPUT_NAME"
mkdir -p "$OUT_DIR"
AUDIO_FILE="$OUT_DIR/audio.flac"
RAW_JSON="$OUT_DIR/transcript_raw.json"
TRANSCRIPT_TXT="$OUT_DIR/transcript.txt"

command -v ffmpeg >/dev/null 2>&1 || { echo "ffmpeg not found. Install with: brew install ffmpeg" >&2; exit 1; }
command -v az >/dev/null 2>&1 || { echo "az cli not found." >&2; exit 1; }

echo "== 1/5: Extracting audio (mono 16kHz FLAC) =="
if [ -f "$AUDIO_FILE" ]; then
  echo "Audio already extracted at $AUDIO_FILE (delete it to force re-extraction). Skipping."
else
  ffmpeg -y -i "$INPUT_FILE" -vn -ac 1 -ar 16000 -c:a flac "$AUDIO_FILE" \
    -loglevel error -stats
fi

FILE_SIZE=$(stat -f%z "$AUDIO_FILE" 2>/dev/null || stat -c%s "$AUDIO_FILE")
DURATION=$(ffprobe -v quiet -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$AUDIO_FILE")
DURATION_MIN=$(python3 -c "print(round($DURATION/60, 1))")
echo "Audio: ${FILE_SIZE} bytes, ${DURATION_MIN} min"

if [ "$FILE_SIZE" -gt "$MAX_SIZE_BYTES" ]; then
  echo "ERROR: audio file ($FILE_SIZE bytes) exceeds the Fast Transcription API's 250MB limit." >&2
  echo "This script doesn't yet support chunking long files. Options: trim the source video," >&2
  echo "or switch to the batch transcription API with blob storage for files this long." >&2
  exit 1
fi
if python3 -c "exit(0 if $DURATION > 7200 else 1)"; then
  echo "ERROR: audio duration (${DURATION_MIN} min) exceeds the Fast Transcription API's 2 hour limit." >&2
  exit 1
fi

echo "== 2/5: Checking Azure login =="
az account show >/dev/null 2>&1 || { echo "Not logged in. Run: az login" >&2; exit 1; }

echo "== 3/5: Checking connectivity to Speech private endpoint =="
if ! curl -s -o /dev/null -w "" --max-time 8 \
    --resolve "$SPEECH_RESOURCE_HOST:443:$SPEECH_PRIVATE_IP" \
    "https://$SPEECH_RESOURCE_HOST/"; then
  echo "ERROR: cannot reach $SPEECH_RESOURCE_HOST at $SPEECH_PRIVATE_IP." >&2
  echo "  - Make sure your VPN is connected." >&2
  echo "  - If it still fails after reconnecting, the private endpoint IP may have changed: run ./refresh_ip.sh" >&2
  exit 1
fi

echo "== 4/5: Submitting to Fast Transcription API (this uploads the full audio file) =="
TOKEN=$(az account get-access-token --resource https://cognitiveservices.azure.com --query accessToken -o tsv)

HTTP_CODE=$(curl -s -o "$RAW_JSON" -w "%{http_code}" \
  --max-time 900 \
  --resolve "$SPEECH_RESOURCE_HOST:443:$SPEECH_PRIVATE_IP" \
  -X POST \
  -H "Authorization: Bearer $TOKEN" \
  -F "audio=@\"$AUDIO_FILE\";type=audio/flac" \
  -F "definition={\"locales\":$CANDIDATE_LOCALES};type=application/json" \
  "https://$SPEECH_RESOURCE_HOST/speechtotext/transcriptions:transcribe?api-version=$API_VERSION")

if [ "$HTTP_CODE" != "200" ]; then
  echo "ERROR: transcription request failed (HTTP $HTTP_CODE). Response:" >&2
  cat "$RAW_JSON" >&2
  exit 1
fi

echo "== 5/5: Extracting plain-text transcript =="
python3 - "$RAW_JSON" "$TRANSCRIPT_TXT" <<'PYEOF'
import json, sys
raw_path, out_path = sys.argv[1], sys.argv[2]
d = json.load(open(raw_path))
parts = []
for cp in d.get("combinedPhrases", []):
    label = f"[channel {cp['channel']}]\n" if "channel" in cp else ""
    parts.append(label + cp["text"])
with open(out_path, "w") as f:
    f.write("\n\n".join(parts))
locales = sorted({p.get("locale") for p in d.get("phrases", []) if p.get("locale")})
print(f"Duration: {d.get('durationMilliseconds', 0)/60000:.1f} min")
print(f"Detected locale(s): {', '.join(locales) if locales else 'n/a'}")
print(f"Transcript length: {sum(len(p['text']) for p in d.get('combinedPhrases', []))} chars")
PYEOF

echo ""
echo "Done. Output:"
echo "  Raw JSON:   $RAW_JSON"
echo "  Transcript: $TRANSCRIPT_TXT"
