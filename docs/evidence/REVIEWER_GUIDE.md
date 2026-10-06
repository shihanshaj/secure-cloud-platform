# Reviewer Guide

## If you have 3 minutes

1. Read the [main README](../../README.md) for the project overview.
2. Read [Day 2 — Service Running but Unreachable](day-02/README.md).
3. Skim the [incident report](../operations/day-02-linux-service-outage.md) for the evidence trail and hypothesis table.
4. Check the Day 2 commit sequence with `git log --oneline --decorate -10`.

## If you have 10 minutes

- Review [Day 1 evidence](day-01/README.md), including the Terraform compatibility fixture.
- Inspect the [Day 2 API](../../labs/day-02-linux-service-outage/app/main.py), [Compose file](../../labs/day-02-linux-service-outage/docker-compose.yml), and [request-path diagram](../operations/day-02-request-path.mmd).
- Run [the verifier](../../scripts/verify-day-02-service.sh) from `labs/day-02-linux-service-outage/` while the stack is running.
- Review the [captured terminal evidence](day-02/README.md#source-evidence) and `git log --oneline --decorate --graph -15`.

All scenarios are local engineering exercises; none is represented as production work.
