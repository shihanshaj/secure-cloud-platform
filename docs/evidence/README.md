# Engineering Evidence Index

This repository documents controlled engineering labs across reproducibility, platform operations, networking, reliability, and security. The entries below are local learning exercises; they do not claim production deployments or production incident experience.

**Visibility:** the GitHub repository is verified **private**. Its existing visibility was not changed. Public portfolio proof requires visibility approval; no public URL is presented here.

| Day | Scenario | Engineering skills demonstrated | Failure / challenge | Evidence | Status |
|---|---|---|---|---|---|
| 1 | Reproducible engineering environment | Git, shell tooling, tool-version documentation, Terraform version constraints, environment validation | Deliberately incompatible Terraform constraint `>= 99.0.0` rejected Terraform 1.14.3; correction initialized successfully | [Day 1 reviewer page](day-01/README.md), [compatibility report](../compatibility/version-compatibility-incident.md), [captured checks](day-01/README.md#evidence) | Compatibility exercise verified. Current `make doctor` is not fully green because `kind` is missing. |
| 2 | Service running but unreachable through reverse proxy | Docker, Compose, FastAPI/Uvicorn, Nginx, Docker DNS, container network namespaces, listening sockets, evidence-based troubleshooting | API listened on `127.0.0.1:8000`; Nginx returned 502 although API's local health check passed | [Day 2 reviewer page](day-02/README.md), [incident report](../operations/day-02-linux-service-outage.md), [actual terminal excerpts](day-02/README.md#source-evidence) | Controlled outage diagnosed and fixed; healthy Compose rebuild and host-port isolation verified. |

Because no clean Terminal-window screenshots were captured, use the [Screenshot Capture Guide](SCREENSHOT_CAPTURE_GUIDE.md) to create genuine images later. The [Day-2 LinkedIn draft](../social/day-02-linkedin-post.md) is a draft only; it has not been published.

## How to review

- [If you have 3 minutes](REVIEWER_GUIDE.md#if-you-have-3-minutes)
- [If you have 10 minutes](REVIEWER_GUIDE.md#if-you-have-10-minutes)
- [Day 1 evidence](day-01/README.md)
- [Day 2 evidence](day-02/README.md)

Milestones: Day 1 ends at commit `c972f1f`; Day 2's engineering evidence is tagged at its completed documentation commit. The repository remains private; public access was not enabled.
