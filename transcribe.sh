#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
shopt -s nullglob nocaseglob

MODEL="${MODEL:-small}"
mkdir -p recordings outputs .cache

pending=()
for f in recordings/*.{wav,mp3,m4a,flac,ogg,webm,mp4}; do
  name="$(basename "${f%.*}")"
  [[ -f "outputs/$name.txt" ]] || pending+=("/app/$f")
done

if [[ ${#pending[@]} -eq 0 ]]; then
  echo "Nothing to transcribe."
  exit 0
fi

docker build -q -t whisper-transcription . >/dev/null
docker run --rm --user "$(id -u):$(id -g)" \
  -e HOME=/tmp -e XDG_CACHE_HOME=/app/.cache \
  -v "$PWD":/app whisper-transcription \
  "${pending[@]}" --model "$MODEL" --language English --task transcribe --fp16 False \
  --output_dir /app/outputs --output_format txt
