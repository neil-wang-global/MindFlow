# Makefile for Multi-Service Build

Task ID: 20260401-concurrent-15

## Overview

A Makefile for orchestrating builds across multiple services in a monorepo layout. Supports per-service and aggregate build, test, and clean targets. Designed for parallel execution via `make -j`.

## Makefile

```makefile
# =============================================================================
# Multi-Service Build Makefile
# Task: 20260401-concurrent-15
# =============================================================================

# ---------------------------------------------------------------------------
# Configuration — add or remove services here
# ---------------------------------------------------------------------------
SERVICES := api gateway worker scheduler

# Build toolchain defaults
GO       ?= go
NPM      ?= npm
DOCKER   ?= docker

# Directories
SRC_DIR    := services
BUILD_DIR  := build
DIST_DIR   := dist

# ---------------------------------------------------------------------------
# Aggregate targets
# ---------------------------------------------------------------------------
.PHONY: all build test clean lint docker help

all: build  ## Default target — build all services

build: $(addprefix build-,$(SERVICES))  ## Build every service

test: $(addprefix test-,$(SERVICES))  ## Test every service

clean: $(addprefix clean-,$(SERVICES))  ## Clean every service
	@rm -rf $(BUILD_DIR) $(DIST_DIR)
	@echo "Global clean complete."

lint: $(addprefix lint-,$(SERVICES))  ## Lint every service

docker: $(addprefix docker-,$(SERVICES))  ## Build Docker images for every service

# ---------------------------------------------------------------------------
# Per-service pattern targets
# ---------------------------------------------------------------------------
.PHONY: $(addprefix build-,$(SERVICES))
$(addprefix build-,$(SERVICES)): build-%:
	@echo "==> Building $*"
	@mkdir -p $(BUILD_DIR)/$*
	$(GO) build -o $(BUILD_DIR)/$*/$* ./$(SRC_DIR)/$*/...

.PHONY: $(addprefix test-,$(SERVICES))
$(addprefix test-,$(SERVICES)): test-%:
	@echo "==> Testing $*"
	$(GO) test -v -count=1 ./$(SRC_DIR)/$*/...

.PHONY: $(addprefix clean-,$(SERVICES))
$(addprefix clean-,$(SERVICES)): clean-%:
	@echo "==> Cleaning $*"
	@rm -rf $(BUILD_DIR)/$*

.PHONY: $(addprefix lint-,$(SERVICES))
$(addprefix lint-,$(SERVICES)): lint-%:
	@echo "==> Linting $*"
	golangci-lint run ./$(SRC_DIR)/$*/...

.PHONY: $(addprefix docker-,$(SERVICES))
$(addprefix docker-,$(SERVICES)): docker-%: build-%
	@echo "==> Building Docker image for $*"
	$(DOCKER) build -t $*:latest -f $(SRC_DIR)/$*/Dockerfile $(BUILD_DIR)/$*

# ---------------------------------------------------------------------------
# Dependency ordering (uncomment and adjust as needed)
# ---------------------------------------------------------------------------
# build-gateway: build-api       # gateway depends on api
# build-worker: build-api        # worker depends on api
# build-scheduler: build-worker  # scheduler depends on worker

# ---------------------------------------------------------------------------
# Help
# ---------------------------------------------------------------------------
help:  ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'
```

## Usage

| Command | Description |
|---------|-------------|
| `make` | Build all services (default) |
| `make build` | Build all services |
| `make test` | Test all services |
| `make clean` | Clean all build artifacts |
| `make lint` | Lint all services |
| `make docker` | Build Docker images for all services |
| `make build-api` | Build a single service |
| `make test-worker` | Test a single service |
| `make -j4 build` | Build all services in parallel (4 jobs) |
| `make help` | Show available targets |

## Design Notes

- **SERVICES variable**: single point of configuration for adding/removing services
- **Pattern rules**: `build-%`, `test-%`, `clean-%` etc. eliminate per-service boilerplate
- **Parallel-safe**: all per-service targets are independent by default; dependency ordering is opt-in via commented examples
- **Docker targets depend on build**: `docker-%` depends on `build-%` to ensure binaries exist before image build
- **Toolchain overridable**: `GO`, `NPM`, `DOCKER` can be overridden from the command line (e.g., `make GO=/usr/local/go/bin/go build`)
- **Self-documenting**: `make help` extracts `##` comments from targets
