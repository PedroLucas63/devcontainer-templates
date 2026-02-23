#!/bin/bash
cd $(dirname "$0")
source ../test-utils/test-utils.sh

# Template specific tests
check "uv-installed" uv --version
check "nvcc-installed" nvcc --version
# Verifica se o python está disponível (via uv ou sistema)
check "python-available" python3 --version || check "python-via-uv" uv run python --version

# Report result
reportResults
