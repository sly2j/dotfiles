# Secure secrets
export OPENAI_API_KEY="$(security find-generic-password -a $USER -s openai-api-key -w 2>/dev/null || true)"
export DOCKER_API_KEY="$(security find-generic-password -a $USER -s docker-api-key -w 2>/dev/null || true)"

