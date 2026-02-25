#!/usr/bin/env bash
set -e

PYTHON_VERSION="$1"
PROJECT_NAME="$2"
RUN_INITIAL_SETUP="$3"

echo "=== Post-create ==="
echo "Python version: ${PYTHON_VERSION}"
echo "Project name: ${PROJECT_NAME}"
echo "Run initial setup: ${RUN_INITIAL_SETUP}"

export PATH="/usr/local/bin:${PATH}"

# ------------------------------------------------------------------
# 1️⃣ SEMPRE garantir que a .venv exista
# ------------------------------------------------------------------
if [ ! -d ".venv" ]; then
  echo "Creating virtual environment (.venv) with Python ${PYTHON_VERSION}"
  uv venv --python "${PYTHON_VERSION}"
fi

source .venv/bin/activate

# ------------------------------------------------------------------
# 2️⃣ Se existir projeto → sync
# ------------------------------------------------------------------
if [ -f "pyproject.toml" ]; then
  echo "pyproject.toml found → running uv sync"
  uv sync
  exit 0
fi

# ------------------------------------------------------------------
# 3️⃣ Se NÃO existir projeto
# ------------------------------------------------------------------
if [ "${RUN_INITIAL_SETUP}" = "true" ]; then
  echo "Initializing new uv project"

  if [ -n "${PROJECT_NAME}" ]; then
    uv init --name "${PROJECT_NAME}" --python "${PYTHON_VERSION}"
  else
    uv init --python "${PYTHON_VERSION}"
  fi

  uv sync
else
  echo "No project initialized (runInitialSetup=false)"
  echo ".venv is ready and active"
fi

echo "=== Post-create finished ==="