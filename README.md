# Secure Cloud Platform Engineering Lab

A portfolio of **controlled, local engineering exercises** in reproducibility, platform operations, networking, and incident response. These are learning labs—not production deployments or production incidents.

## Engineering Log

| Day | Scenario | Skills | Result | Evidence |
|---|---|---|---|---|
| 1 | Reproducible engineering environment and version compatibility | Git, shell tooling, Terraform constraints, tool manifests, environment validation | Incompatible Terraform constraint reproduced and corrected. Current `make doctor` still reports `kind` missing. | [Day 1 evidence](docs/evidence/day-01/README.md) |
| 2 | API process running but unreachable through Nginx | Docker, Compose, FastAPI, Uvicorn, Nginx, DNS, network namespaces, socket diagnosis | Loopback-only bind caused HTTP 502; corrected bind returned HTTP 200. Rebuild and backend exposure checks pass. | [Day 2 evidence](docs/evidence/day-02/README.md) |

## Current Highlight — Container Service Outage

- **Problem:** A container-local API health check passed while Nginx returned HTTP 502.
- **Evidence:** Nginx logged `connect() failed (111: Connection refused)`; Uvicorn was listening on `127.0.0.1:8000`.
- **Root cause:** The API socket was bound to loopback inside its own container network namespace, not reachable through the API container's network interface from Nginx.
- **Resolution:** Recreated the API with a container-reachable `0.0.0.0:8000` listener.
- **Verification:** Nginx returned HTTP 200 with `{"status":"healthy"}`; Docker DNS and peer request succeeded; API port 8000 remained unpublished to the host; `docker compose down` followed by `docker compose up -d --build` returned a healthy stack.

## Repository Evidence

Start with the [Engineering Evidence Index](docs/evidence/README.md) or the concise [Reviewer Guide](docs/evidence/REVIEWER_GUIDE.md).

## Current Technologies

Technologies actually exercised or checked so far: Git, macOS shell tooling, Linux containers, Terraform, Docker, Docker Compose, Nginx, Python, FastAPI, Uvicorn, `curl`, and `kubectl` client version checks. `kind` is recorded as missing in the current tool manifest; planned technologies are not presented as completed work.

## Engineering Approach

**Build → break safely → observe → diagnose → fix → verify → document.** Each failure is confined to a local lab, supported by evidence, and restored to a reproducible healthy state.

## Working Principles

- Prefer reproducible, reviewable changes and small commits.
- Keep credentials, private keys, and Terraform state out of Git.
- Record compatibility assumptions and verification commands.
- Preserve the distinction between a controlled exercise and production experience.
