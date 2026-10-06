# Day 2 — LinkedIn Draft

I built a small FastAPI service behind Nginx with Docker Compose, then reproduced a failure that looked contradictory: the API container was healthy, but Nginx returned HTTP 502.

The investigation narrowed it down one hop at a time. Docker service-name lookup worked. The API answered its own health check. Nginx logged `connection refused`, and the listener check showed Uvicorn bound to `127.0.0.1:8000` inside the API container.

That loopback socket was local to the API container's network namespace; Nginx ran in another container and could not reach it. I restored the listener to `0.0.0.0:8000`, verified HTTP 200 through Nginx, confirmed port 8000 was not published to the host, and rebuilt the healthy Compose stack from scratch.

The useful reminder: **a running process is not the same as a reachable service.** This was a controlled local lab, not a production incident.

#DevOps #Docker #PlatformEngineering

## Alternate opening hooks

1. “The container was healthy. The API was running. Nginx still returned 502. Here’s what the socket table showed.”
2. “A FastAPI health check passed inside its container while a neighboring Nginx container got connection refused. The difference was the bind address.”

## Editorial note

The GitHub repository is verified private, so no repository URL is included. Public portfolio proof requires visibility approval.
