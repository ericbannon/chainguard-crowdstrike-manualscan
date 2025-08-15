#!/usr/bin/env python3
import os, json, base64, pathlib

host = os.environ["REGISTRY_HOST"]              # e.g., chainguard.jfrog.io
user = os.environ["REGISTRY_USER"]
pw   = os.environ["REGISTRY_PASS"]

cfg_dir = pathlib.Path("/root/.docker")
cfg_dir.mkdir(parents=True, exist_ok=True)
cfg_path = cfg_dir / "config.json"

auth_b64 = base64.b64encode(f"{user}:{pw}".encode()).decode()

# Merge with any existing config to be nice
cfg = {"auths": {}}
if cfg_path.exists():
    try:
        cfg = json.loads(cfg_path.read_text() or "{}")
    except Exception:
        pass
cfg.setdefault("auths", {})[host] = {"auth": auth_b64}

cfg_path.write_text(json.dumps(cfg))
print(f"Wrote Docker auth for {host} to {cfg_path}", flush=True)
