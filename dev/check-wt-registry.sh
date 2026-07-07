#!/bin/bash
# Runs wt-registry directly against the ALREADY-INSTALLED compiled workflow
# env — no environment resolution, no pixi solve. Saves the full JSON output
# and reports timing. Optionally checks that specific task names are present.
#
# Usage:
#   ./dev/check-wt-registry.sh                          # just dump + time it
#   ./dev/check-wt-registry.sh task_one task_two ...     # also check presence

set -e

GENERATED_DIR="ecoscope-workflows-community-engagement-workflow"
REGISTRY_BIN="${GENERATED_DIR}/.pixi/envs/default/bin/wt-registry"
OUT="/tmp/wt_registry_output.json"

if [ ! -x "$REGISTRY_BIN" ]; then
    echo "Error: $REGISTRY_BIN not found or not executable. Compile the workflow first."
    exit 1
fi

echo "Running wt-registry against the already-installed env (no environment resolution)..."
time "$REGISTRY_BIN" --format json \
    --package ecoscope.platform.tasks \
    --package ecoscope_workflows_ext_custom.tasks \
    --package ecoscope_workflows_ext_eden.tasks \
    > "$OUT"

echo ""
echo "Full output saved to: $OUT"

if [ "$#" -gt 0 ]; then
    echo ""
    echo "Checking for requested tasks:"
    for task in "$@"; do
        if grep -q "\"$task\"" "$OUT"; then
            echo "  ✔ $task found"
        else
            echo "  ✘ $task MISSING"
        fi
    done
fi
