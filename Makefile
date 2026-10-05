SHELL := /bin/sh
REQUIRED_TOOLS := git python3 docker terraform kubectl kind

.PHONY: help doctor
help:
	@printf '%s\n' 'Targets:' '  make doctor  Check required engineering tools and Docker engine availability'

doctor:
	@set -u; failed=0; \
	for tool in $(REQUIRED_TOOLS); do \
	  if command -v "$$tool" >/dev/null 2>&1; then \
	    case "$$tool" in \
	      kubectl) version=$$(kubectl version --client 2>&1 | sed -n '1p');; \
	      docker) version=$$(docker --version 2>&1);; \
	      *) version=$$("$$tool" --version 2>&1 | sed -n '1p');; \
	    esac; \
	    printf '[OK] %s — %s\n' "$$tool" "$$version"; \
	  else \
	    printf '[MISSING] %s\n' "$$tool"; failed=1; \
	  fi; \
	done; \
	if command -v docker >/dev/null 2>&1; then \
	  if docker info >/dev/null 2>&1; then printf '[OK] docker-engine — daemon available\n'; \
	  else printf '[MISSING] docker-engine — client exists but daemon is unavailable\n'; failed=1; fi; \
	fi; \
	if [ "$$failed" -ne 0 ]; then printf '%s\n' 'Doctor found one or more missing/unusable requirements.'; exit 1; fi; \
	printf '%s\n' 'Doctor passed.'
