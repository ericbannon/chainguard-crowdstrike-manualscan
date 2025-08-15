Built using Crowdtrikes utility: https://github.com/CrowdStrike/container-image-scan

# Build
docker build -t cs-scan:latest .

# Run 
docker run --rm \
  -e FALCON_CLIENT_ID="…" \
  -e FALCON_CLIENT_SECRET="…" \
  -e REPO="<repo>>" \
  -e TAG="l<tag>>" \
  -e CLOUD_REGION="us-2" \
  -e REGISTRY_HOST="cgr.dev" \
  -e REGISTRY_USER=<token_user>" \
  -e REGISTRY_PASS="<token_pass>" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v "$PWD/.docker-portable:/root/.docker:ro" \
  cs-scan:latest


Check Image Assessments Tab for GUI details to confirm functionality and results
