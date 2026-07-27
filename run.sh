#!/usr/bin/env bash

echo "Installing dependencies..."

if ! command -v uv >/dev/null 2>&1; then
  echo "Installing uv..."
  curl -LsSf https://astral.sh/uv/install.sh | sh

  echo ""
  echo "uv has been installed"
  echo "Make sure the following is in your shell startup file (~/.bashrc, ~/.zshenv, etc.):"
  cat <<'EOF'
# Set PATH so it includes user binaries
if [ -d "${HOME}/.local/bin" ]; then
    export PATH="${HOME}/.local/bin:${PATH}"
fi
EOF
fi

if ! command -v rustup >/dev/null 2>&1; then
  echo "Installing rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

  echo ""
  echo "Rust has been installed"
  echo "Make sure the following is in your shell startup file (~/.bashrc, ~/.zshrc, etc.):"
  cat <<'EOF'
# Set PATH so it includes Cargo binaries
if [ -f "${HOME}/.cargo/env" ]; then
    source "${HOME}/.cargo/env"
fi
EOF
fi

echo "Dependencies are installed"

echo ""
echo "Use the following command to install the core configuration:"
echo "\`\`\`"
echo "uv run pyinfra @local core.py"
echo "\`\`\`"
