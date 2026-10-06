# Day 2 — 90-Second Demo Script

**Setting:** controlled local Docker Compose lab only. This walkthrough deliberately replays the documented failure; do not run it against a non-lab service. Expected duration: about 90 seconds.

| Time | Screen/action | Narration |
|---|---|---|
| 0:00–0:10 | Show the request-path diagram and `docker compose ps`. | “This local lab puts Nginx in front of a small FastAPI service. The API is internal to the Compose network; only Nginx publishes a host port.” |
| 0:10–0:22 | Run `API_HOST=127.0.0.1 docker compose up -d --force-recreate api`; then `docker compose ps`. | “I’m applying one controlled fault: Uvicorn will listen on the API container’s loopback interface. The container can still appear healthy.” |
| 0:22–0:35 | Run `curl -i http://localhost:8080/health` and `docker compose logs --no-color --tail=10 nginx`. | “From the host, Nginx is reachable, but it returns 502. Its log reports connection refused while connecting to the upstream.” |
| 0:35–0:52 | Run `docker compose logs api`; run the `/proc/net/tcp` listener command from the screenshot guide. | “Uvicorn is running, and its own health check succeeds. The log and socket table show `127.0.0.1:8000`; that is process state and listener state, not proof of peer reachability.” |
| 0:52–1:04 | Run the network-peer request from the [incident report](../../operations/day-02-linux-service-outage.md#investigation). | “A separate container uses the Compose service name, but cannot connect to the loopback-only listener. Docker DNS and a TCP listener are separate parts of the path.” |
| 1:04–1:17 | Run `env -u API_HOST docker compose up -d --force-recreate api`; show logs or listener. | “The correction is to bind Uvicorn to `0.0.0.0:8000`, making it reachable on the API container’s network interface.” |
| 1:17–1:28 | Run `curl -i --fail http://localhost:8080/health`, then `docker compose ps`. | “The same Nginx path now returns HTTP 200 and the healthy JSON. API request logs record the successful request.” |
| 1:28–1:35 | Run `curl --max-time 2 -v http://localhost:8000/health` and the API port `docker inspect` check. | “The backend still is not published directly to the host. The core lesson: a running process is not the same as a reachable service.” |

At the end, leave the lab healthy. If the demo stops before recovery, run `env -u API_HOST docker compose up -d --force-recreate api` and verify `/health` again.
