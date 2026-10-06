# Day 1 — Reproducible Engineering Environment

## Problem

An undocumented toolchain makes results difficult to reproduce. Incompatible versions can block initialization before an engineering task begins, while a successful client version check does not guarantee that a daemon or companion tool is available.

## What I Built

Day 1 established five sibling repositories and a documented local tool baseline. In `secure-cloud-platform`, I added a `.tool-versions` snapshot, a `make doctor` check, a workspace map, and a disposable Terraform compatibility exercise.

## Controlled Failure

With Terraform **1.14.3**, the initial disposable fixture required:

```hcl
required_version = ">= 99.0.0"
```

`terraform init -backend=false` rejected it with **Unsupported Terraform Core version**. This was a deliberately incompatible local fixture, not a production failure and not a change to shared infrastructure.

## Evidence

The captured commands are in [Day-1 terminal evidence](terminal/). The relevant actual outputs include:

```text
$ terraform -chdir=docs/compatibility/initial-run init -backend=false
Error: Unsupported Terraform Core version
This configuration does not support Terraform version 1.14.3.
[exit status: 1]
```

The corrected fixture used:

```hcl
required_version = ">= 1.14.0, < 2.0.0"
```

Its captured `terraform init -backend=false` completed successfully with exit status 0. The full logs are preserved in [failure output](terminal/day-01-terraform-version-failure.txt) and [corrected output](terminal/day-01-terraform-fixed.txt).

## Root Cause

The tested constraint could not be satisfied by the installed Terraform 1.14.3 binary. Terraform rejected the configuration before initialization could proceed.

## Resolution

The exercise corrected the supported range to `>= 1.14.0, < 2.0.0` and kept the test in disposable fixture directories. It did not change Terraform globally or apply infrastructure.

## Verification

The corrected fixture was rerun on 2026-10-06 with Terraform 1.14.3 and `terraform init -backend=false` succeeded. The current [captured `make doctor` output](terminal/day-01-make-doctor.txt) reports Git, Python, Docker client, Terraform, kubectl, and Docker Engine as available, but still exits non-zero because `kind` is missing. This is **not** represented as a full environment PASS.

**Historical vs current state:** the Day-1 bootstrap record says Docker Engine was unavailable during Day-1 final verification and `kind` was missing. In the current captured check, Docker Engine is available; `kind` remains missing. A fresh GitHub CLI authentication check now succeeds. The target repository is private; its existing visibility was left unchanged.

## Engineering Concepts Demonstrated

- Reproducibility through explicit tool-version documentation.
- Version constraints and dependency compatibility.
- Environment validation beyond checking that a CLI exists.
- Safe, disposable failure testing.
- Git discipline and evidence-oriented documentation.

## Source Evidence

- [Engineering bootstrap](../../engineering-bootstrap.md)
- [Tool-version manifest](../../../.tool-versions)
- [Makefile doctor check](../../../Makefile)
- [Day-1 environment map](../../environment-map.md)
- [Terraform compatibility incident](../../compatibility/version-compatibility-incident.md)
- [Day-1 initial and corrected Terraform fixtures](../../compatibility/)
- Day-1 completion commit: `c972f1f` (`docs: record final environment verification`); compatibility test commit: `5b8d025`.
