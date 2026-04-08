#!/usr/bin/env bash

if ! command -v uv >/dev/null 2>&1; then
  echo "Installing uv..."
  curl -LsSf https://astral.sh/uv/install.sh | sh
fi

if ! command -v rustup >/dev/null 2>&1; then
  echo "Installing rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

uv run pyinfra @local core.py
