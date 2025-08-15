# Use a tiny, reliable Python base
FROM cgr.dev/chainguard/python:latest-dev

USER 0

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1
WORKDIR /app

# Your scanner
COPY cs_scanimage.py /app/cs_scanimage.py

# Deps
RUN pip3 install --no-cache-dir --upgrade pip \
 && pip3 install --no-cache-dir docker crowdstrike-falconpy retry

# Login helper (no heredoc)
COPY docker_login.py /usr/local/bin/docker_login.py
RUN chmod +x /usr/local/bin/docker_login.py

# Entrypoint (LF endings + executable)
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN sed -i 's/\r$//' /usr/local/bin/docker-entrypoint.sh \
 && chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
