#!/usr/bin/env bash
set -euo pipefail

# Required env
required_vars=(FALCON_CLIENT_ID FALCON_CLIENT_SECRET REPO TAG CLOUD_REGION REGISTRY_HOST REGISTRY_USER REGISTRY_PASS)
for v in "${required_vars[@]}"; do
  if [[ -z "${!v:-}" ]]; then
    echo "Missing required env: $v" >&2
    exit 2
  fi
done

# Guard: REPO must not be a URL
case "$REPO" in
  http://*|https://*)
    echo "REPO must be like 'chainguard.jfrog.io/artifactory/<repo-key>/path', not a URL." >&2
    exit 2
    ;;
esac

# Login to the registry (in-memory via SDK)
/usr/local/bin/docker_login.py

# Run scan
exec python3 /app/cs_scanimage.py \
  -u "$FALCON_CLIENT_ID" \
  -r "$REPO" \
  -t "$TAG" \
  -c "$CLOUD_REGION" \
  "$@"
