#!/usr/bin/env bash
set -euo pipefail

# ---
# Home Manager + 1Password seamless secrets automation
#
# Usage:
#   ./hm-secrets.sh [inject|run]
#   - inject: Use home.template.nix + op inject (default, recommended)
#   - run:    Use .env + op run (fallback)
#
# Requirements: 1Password CLI (op), home-manager, secrets in 1Password
#
# This script will:
#   - Use op inject if home.template.nix exists
#   - Use op run with .env if .env exists and no template is found
#   - Clean up resolved files
#   - Warn if secrets are missing
# ---

METHOD="${1:-inject}"

if [[ "$METHOD" == "inject" ]]; then
  if [[ -f home.template.nix ]]; then
    echo "[INFO] Injecting secrets from home.template.nix using op inject..."
    if ! op inject -i home.template.nix -o home.nix; then
      echo "[ERROR] op inject failed. Check your 1Password session and secret references." >&2
      exit 1
    fi
    echo "[INFO] Running home-manager switch..."
    if ! sudo nixos-rebuild switch --flake .; then
      echo "[ERROR] home-manager switch failed." >&2
      rm -f home.nix
      exit 1
    fi
    echo "[INFO] Cleaning up resolved home.nix..."
    rm -f home.nix
    echo "[SUCCESS] Home Manager config applied with secrets."
  else
    echo "[WARN] home.template.nix not found. Falling back to 'run' method."
    METHOD="run"
  fi
fi

if [[ "$METHOD" == "run" ]]; then
  if [[ -f .env ]]; then
    echo "[INFO] Using op run with .env for environment variable secrets..."
    if ! op run --env-file=.env -- sudo nixos-rebuild switch --flake .; then
      echo "[ERROR] op run or home-manager switch failed." >&2
      exit 1
    fi
    echo "[SUCCESS] Home Manager config applied with secrets from env."
  else
    echo "[ERROR] No .env file found for 'run' method. Aborting." >&2
    exit 1
  fi
fi
