#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

PYTHON_VERSION=$1
PROJECT_NAME=$2
RUN_INITIAL_SETUP=$3

echo "--- Post-Create Script Started ---"
echo "Python Version: ${PYTHON_VERSION}"
echo "Project Name: ${PROJECT_NAME}"
echo "Run Initial Setup: ${RUN_INITIAL_SETUP}"

# Ensure uv is in PATH
export PATH="/usr/local/bin:${PATH}"

# Always ensure a virtual environment is created and activated
if [ ! -d ".venv" ]; then
    echo "Creating virtual environment with uv for Python ${PYTHON_VERSION}."
    uv venv --python "${PYTHON_VERSION}"
fi

# Activate the virtual environment
source .venv/bin/activate

# Check for existing pyproject.toml for project-specific dependencies
if [ -f "pyproject.toml" ]; then
    echo "pyproject.toml found. Running uv sync to install dependencies."
    uv sync
else
    if [ "${RUN_INITIAL_SETUP}" = "true" ]; then
        echo "No pyproject.toml found and initial project setup is enabled."
        echo "Initializing a new uv project."
        # uv init will create pyproject.toml and potentially install some default packages (like pip, setuptools)
        uv init --python "${PYTHON_VERSION}"
        echo "Project initialized. Running uv sync."
        uv sync
    else
        echo "No pyproject.toml found. Initial project setup skipped."
        echo "A virtual environment for Python ${PYTHON_VERSION} is available."
    fi
fi

# Inform user about Python interpreter for VS Code.
# The devcontainer.json already points VS Code to the .venv/bin/python.
echo "Default Python interpreter for VS Code is set to the .venv."

echo "--- Post-Create Script Finished ---"
