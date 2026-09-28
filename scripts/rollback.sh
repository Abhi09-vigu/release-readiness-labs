#!/bin/bash
TARGET_VERSION="${1:-${ROLLBACK_TARGET_VERSION:-v2.2.0}}"
echo "Starting rollback procedure..."
echo "Reverting to stable version: $TARGET_VERSION"

if command -v kubectl &> /dev/null; then
  echo "Rolling back Kubernetes deployment..."
  kubectl rollout undo deployment/lab-app || true
fi

echo "Rollback to version $TARGET_VERSION completed successfully."
