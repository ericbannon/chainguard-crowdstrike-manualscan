Built using Crowdtrikes utility: https://github.com/CrowdStrike/container-image-scan

# Build
docker build -t cs-scan:latest .

# Run 
docker run --rm \
  -e FALCON_CLIENT_ID="…" \
  -e FALCON_CLIENT_SECRET="…" \
  -e REPO="repository-in-crowdstrike including image>" \ ### example chainguard.jfrog.io/myrepo/customer.com/adoptium-jre" ---> replace with acr repo path and CG image
  -e TAG="l<tag>>" \
  -e CLOUD_REGION="us-2" \
  -e REGISTRY_HOST="cgr.dev" \
  -e REGISTRY_USER=<ACS_token_user>" \
  -e REGISTRY_PASS="<ACR_token_pass>" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v "$PWD/.docker-portable:/root/.docker:ro" \
  cs-scan:latest


Check Image Assessments Tab for GUI details to confirm functionality and results
