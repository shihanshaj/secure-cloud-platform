# Screenshot Capture Guide

**No screenshots were captured for this evidence pack.** This session could not reliably target and inspect a clean Terminal window before saving a screenshot. Although macOS provides a `screencapture` utility, an unscoped desktop capture could include unrelated private windows; no image was fabricated or committed. Use the steps below to capture genuine evidence manually if desired.

## Before capturing

1. Open macOS Terminal and navigate to the repository or the Day-2 lab directory.
2. Close or move unrelated windows; ensure no credentials, account pages, private files, or personal notifications are visible.
3. Use `Shift-Command-4` to select only the Terminal window region. Save the PNGs in the indicated folder, then inspect each image before adding it to Git.
4. Keep terminal font large enough to read. Do not crop away the command or its relevant output.

## Day 1

- **`docs/evidence/day-01/screenshots/01-day1-make-doctor.png`** — Run `make doctor` from the repository root. This shows the current state: `kind` is missing while Docker Engine is available. Do not present it as a historical Day-1 screenshot.
- **`02-day1-version-failure.png`** — Run `terraform -chdir=docs/compatibility/initial-run init -backend=false`; include the `>= 99.0.0` constraint and unsupported-version error.
- **`03-day1-version-fixed.png`** — Run `terraform -chdir=docs/compatibility/corrected-run init -backend=false`; show the successful initialization and exit status.

## Day 2

From `labs/day-02-linux-service-outage/`:

- **`docs/evidence/day-02/screenshots/01-day2-healthy-baseline.png`** — Run `docker compose ps` and `curl -i --fail http://localhost:8080/health`; show HTTP 200 and the healthy JSON.
- **`02-day2-outage-502.png`** — For a fresh controlled local demonstration only, run `API_HOST=127.0.0.1 docker compose up -d --force-recreate api`, then `curl -i http://localhost:8080/health` and `docker compose logs --no-color --tail=10 nginx`. Show the 502 and connection-refused log.
- **`03-day2-listener-root-cause.png`** — In that same temporary failure, show `docker compose ps`, `docker compose logs api`, and the `/proc/net/tcp` listener check below. It should show the process running and `0100007F:1F40`.
- **`04-day2-recovery.png`** — Restore the default binding with `env -u API_HOST docker compose up -d --force-recreate api`, then show `curl -i --fail http://localhost:8080/health`, `docker compose ps`, and the corrected listener. Show that host port 8000 remains unpublished.

The listener command is:

```sh
docker compose exec -T api python -c 'rows=open("/proc/net/tcp").read().splitlines()[1:]; print("\\n".join(r for r in rows if r.split()[1].endswith(":1F40") and r.split()[3]=="0A"))'
```

After the temporary failure, always restore the healthy default. Do not recreate this scenario on production or any non-lab service.
