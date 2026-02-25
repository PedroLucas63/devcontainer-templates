#!/bin/bash
cd $(dirname "$0")
source ../test-utils/test-utils.sh

# Template specific tests
check "uv-installed" uv --version
check "nvcc-installed" nvcc --version
# Verifica se o python está disponível (via sistema ou uv)
if command -v python3 >/dev/null 2>&1; then
	check "python-available" python3 --version
else
	check "python-via-uv" uv run python --version
fi

# Report result
reportResults
