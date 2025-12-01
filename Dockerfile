FROM python:3.10-slim

RUN apt-get update && apt-get install -y --no-install-recommends ffmpeg && rm -rf /var/lib/apt/lists/*
RUN pip install --no-cache-dir --extra-index-url https://download.pytorch.org/whl/cpu openai-whisper \
 && pip uninstall -y triton

WORKDIR /app
ENTRYPOINT ["whisper"]
