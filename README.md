# Ollama-Android-V.1

> Run a fully offline, zero-history LLM on Android using Termux and Ollama — no cloud, no logs, no telemetry.

---

## Overview

This guide walks you through installing Ollama on Android via Termux, optionally creating a custom model with a system prompt, and configuring your shell so history is permanently disabled across every session.

---

## Prerequisites

- Android device with [Termux](https://play.google.com/store/apps/details?id=com.termux) installed
- Enough storage for your model (varies — most models are 4–8GB)
- An internet connection for the initial setup (after that, fully offline)

---

## Step 1 — Install Ollama

Open Termux and run the following commands one at a time:

```bash
pkg install tur-repo
```

```bash
pkg update
```

```bash
pkg install ollama
```

---

## Step 2 — Pull Your Model

This guide uses `dolphin-mistral` as an example, but you can use any model from [ollama.com/library](https://ollama.com/library):

```bash
ollama pull dolphin-mistral
```

> This may take a few minutes depending on your connection speed and model size.

---

## Step 3 — Disable History Permanently (Recommended)

To ensure zero history across all Termux and Ollama sessions, add two lines to your shell config.

Open your bash configuration file:

```bash
nano ~/.bashrc
```

Scroll to the bottom and add these two lines:

```bash
set +o history
export OLLAMA_NOHISTORY=1
```

Save with `Ctrl+O` then `Enter`, and exit with `Ctrl+X`.

Apply the changes immediately:

```bash
source ~/.bashrc
```

This runs automatically on every new Termux session going forward.

---

## Step 4 — Create a Modelfile (Optional)

Skip this step if you just want to run a base model as-is.

A Modelfile lets you bake a system prompt into a custom model so it starts every session with your instructions already loaded.

Create the file:

```bash
touch modelfile
nano modelfile
```

Paste the following, replacing the model name and prompt with your own:

```
FROM dolphin-mistral
SYSTEM "Your system prompt goes here."
```

**Example:**

```
FROM dolphin-mistral
SYSTEM "You are a helpful assistant. Be concise and direct. Never mention that you are an AI."
```

Save with `Ctrl+O` then `Enter`, and exit with `Ctrl+X`.

Create your custom model:

```bash
ollama create CUSTOM_MODEL_NAME -f ./modelfile
```

Verify it was created:

```bash
ollama list
```

---

## Step 5 — Run It

Running Ollama on Android requires two Termux consoles — one to serve the model, one to talk to it.

**In your first console**, start the Ollama server:

```bash
ollama serve
```

**Open a second console** by swiping right from the left edge of the screen, then tap the `+` to open a new session.

**In the second console**, run your model:

```bash
# If you created a custom model:
ollama run CUSTOM_MODEL_NAME

# If you want to run the base model directly:
ollama run dolphin-mistral
```

Type your questions and press Enter. Use `/bye` or `Ctrl+C` to exit.

---

## How It Works

| Feature | Detail |
|---|---|
| **Zero history** | `set +o history` and `OLLAMA_NOHISTORY=1` disable all logging permanently |
| **System prompt** | Baked into the model at creation — loads automatically every run |
| **Fully offline** | After the initial pull, no internet connection is needed |
| **Two consoles** | Termux requires one session for `ollama serve` and one to run the model |

---

## Customization Tips

- **Change the system prompt** — edit the `modelfile` and re-run `ollama create` with the same name to overwrite it
- **Multiple models** — create several modelfiles for different use cases (e.g. a coding assistant, a writing assistant, a research assistant)
- **Swipe to switch** — swipe right from the left edge in Termux to manage and switch between open console sessions

---

## Related

- [Ollama-Windows-V.1](https://github.com/quintenlittle/Ollama-Windows-V.1) — Same setup guide for Windows
- [RAG-Technique-V.1](https://github.com/quintenlittle/RAG-Technique-V.1) — Index your personal files and query them with a local LLM

---

## License

MIT
