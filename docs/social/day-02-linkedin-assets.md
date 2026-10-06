# Day 2 — LinkedIn Asset Plan

No terminal screenshots were captured in this evidence pass. See the [Screenshot Capture Guide](../evidence/SCREENSHOT_CAPTURE_GUIDE.md) before creating any screenshots. The request-path PNG below is a genuine render of the committed Mermaid source; it is a diagram asset, not a terminal screenshot.

| Order / planned filename | What it should prove | Suggested caption | Availability |
|---|---|---|---|
| 1. `day-02-request-path.png` (in `docs/evidence/day-02/`) | Host → Nginx → Compose DNS → API path, with the broken loopback bind distinguished from the healthy path | “One request path, two listener states: loopback-only fails across containers; wildcard bind is reachable.” | Available: [rendered PNG](../evidence/day-02/day-02-request-path.png), generated from the actual [`day-02-request-path.mmd`](../operations/day-02-request-path.mmd) source; not a screenshot. |
| 2. `02-day2-outage-502.png` | Nginx 502 while API remained running/locally healthy | “The proxy was reachable; its upstream listener was not.” | Not captured. Use the Day-2 outage section of the [capture guide](../evidence/SCREENSHOT_CAPTURE_GUIDE.md#day-2). |
| 3. `03-day2-listener-root-cause.png` | Uvicorn's loopback bind and `127.0.0.1:8000` socket evidence | “Process state looked healthy; the listener was confined to container loopback.” | Not captured. Use the root-cause section of the [capture guide](../evidence/SCREENSHOT_CAPTURE_GUIDE.md#day-2). |
| 4. `04-day2-recovery.png` | Nginx HTTP 200, healthy JSON, corrected listener, and no published API host port | “Recovered through Nginx; backend port remains internal.” | Not captured. Use the recovery section of the [capture guide](../evidence/SCREENSHOT_CAPTURE_GUIDE.md#day-2). |

Keep the post to these four assets at most. Inspect every image for private desktop content before attaching it.
