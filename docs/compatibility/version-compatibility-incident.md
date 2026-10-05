# Version Compatibility Incident

## SYMPTOM

A disposable Terraform configuration declared an impossible local Terraform version constraint.

## EXPECTED BEHAVIOUR

Terraform should reject the incompatible constraint before initialization changes any project state.

## ACTUAL BEHAVIOUR

See the recorded command output below.

```text
PENDING_COMMAND_OUTPUT
```

## INVESTIGATION

The host reported Terraform 1.14.3 on `darwin_arm64`. The initial configuration required `>= 99.0.0`, which cannot be satisfied by the installed binary.

## ROOT CAUSE

The version constraint was incompatible with the detected toolchain.

## FIX

The constraint was corrected to `>= 1.14.0, < 2.0.0` in `main.tf.corrected`.

## VERIFICATION

The corrected configuration was initialized with `terraform init -backend=false`; actual output is recorded after the command is run.

## PREVENTION

Record versions, pin compatible ranges deliberately, run `make doctor`, and exercise constraints in disposable directories before changing shared environments.
