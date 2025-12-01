# Transcription

> [!WARNING]
> **AI-authored:** This change was autonomously planned and implemented by an AI software factory from a human-authored specification, with possible subsequent human review or modification.

Basic Whisper flow: every recording in `recordings/` is transcribed to `outputs/<name>.txt`, running OpenAI Whisper on CPU inside Docker. Example output within docs/narration.txt.

## Usage

```sh
cp ~/some-meeting.wav recordings/
./transcribe.sh            # MODEL=tiny|base|small|medium|large, default small
```

Recordings that already have a transcript in `outputs/` are skipped.

## Notes

- Ultimately leaning away from local-first transcription; too much human invocation/process compared with managed services.
- No meaningful quality difference observed so far for the kinds of inputs being tested; may be workload/data dependent.
- Managed transcription fits broader direction toward removing manual workflow steps rather than optimizing for locality itself.
- Potential area for future investigation, but no strong reason to continue exploring it at present.
