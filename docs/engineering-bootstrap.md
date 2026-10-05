# Engineering Bootstrap — ENG-001

## Purpose

This document records the Day-1 baseline for a reproducible 60-day Cloud, DevOps, and Cloud Security engineering workspace. The setup favors reuse of working tools, project-local documentation, and explicit verification over broad system changes.

## Host

- **Operating system:** macOS 27.0.1 (Darwin 27.0.0)
- **Architecture:** arm64 (Apple Silicon)
- **Shell:** `/bin/zsh`
- **Workspace:** this repository is one of five sibling repositories under the Day-1 workspace directory.

## Core toolchain snapshot

| Tool | Installed version | Executable | Status |
|---|---:|---|---|
| Git | 2.54.0 | `/usr/bin/git` | Reused |
| GitHub CLI | 2.82.1 | `/opt/homebrew/bin/gh` | Reused; login token invalid |
| Python 3 | 3.13.0 | `~/.pyenv/shims/python3` | Reused |
| pip | 26.0.1 | `~/.pyenv/shims/pip3` | Reused |
| Docker | 28.5.1 | `/usr/local/bin/docker` | Reused; client present |
| Docker Compose | v2.40.2-desktop.1 | `/usr/local/bin/docker-compose` | Reused |
| Terraform | 1.14.3 | `/opt/homebrew/bin/terraform` | Reused |
| kubectl | v1.34.1 | `/usr/local/bin/kubectl` | Reused |
| kind | Missing | — | Pending safe installation |
| make | 3.81 | `/usr/bin/make` | Reused |
| curl | 8.7.1 | `/usr/bin/curl` | Reused |
| OpenSSL | 3.6.5 | `/opt/homebrew/bin/openssl` | Reused |
| jq | 1.7.1 | `/usr/bin/jq` | Reused |

The machine has Homebrew at `/opt/homebrew/bin/brew`; no alternate version manager was added. The exact snapshot is also kept in `.tool-versions`.

## Installation decisions

No tool was successfully installed today. `kind` was the only missing core tool. A Homebrew installation was attempted because Homebrew is the established package manager, but it was correctly not forced: the Cellar was not writable without `sudo`, and Homebrew could not resolve `formulae.brew.sh`. No permissions, ownership, or global configuration were changed.

Existing tools were deliberately reused because they run and meet the Day-1 needs. The GitHub CLI was not reauthenticated because that is an authentication-sensitive user action.

## Repository structure

The workspace contains five independent Git repositories: `secure-cloud-platform`, `secure-delivery-platform`, `k8s-reliability-security-lab`, `cloud-attack-defense-lab`, and `web-api-security-lab`. Each includes a README, MIT license, `.gitignore`, `.editorconfig`, GitHub collaboration templates, and purpose-specific directories.

## Setup and validation

From this repository:

```sh
make help
make doctor
terraform version
kubectl version --client
git status
```

`make doctor` intentionally exits non-zero while `kind` is unavailable; it also checks the Docker daemon with `docker info`, not merely the client version.

## Compatibility considerations

- Tool versions are recorded, not silently upgraded.
- `kind` must be installed for local Kubernetes cluster exercises.
- Docker engine availability is separate from the Docker CLI.
- Terraform compatibility is demonstrated in `docs/compatibility/version-compatibility-incident.md`.
- Fresh-shell checks must resolve tools through `PATH`, not an IDE-only environment.

## Troubleshooting

- If `kind` is missing, install it through the established package manager after Homebrew permissions and network resolution are repaired; do not use `sudo` or an untrusted script automatically.
- If Docker client commands work but `docker info` fails, start the existing Docker Desktop application and rerun the check; do not reinstall Docker.
- If GitHub operations are needed, reauthenticate with `gh auth login -h github.com` interactively; tokens are never stored in this repository.

## Security and hygiene

The repository ignores environment files, credentials, private keys, Terraform state, virtual environments, build output, and OS/editor artifacts. No credentials, account IDs, or private material belong in these documents.
