# Dockerfile — Go Microservice

Task: 20260401-concurrent-14

```dockerfile
# ============================================================
# Stage 1: Build
# ============================================================
# Use a specific Go version on Alpine for a smaller build image.
FROM golang:1.22-alpine AS builder

# Install ca-certificates so the final image can make HTTPS calls,
# and git in case any dependency uses a git-based import path.
RUN apk add --no-cache ca-certificates git

WORKDIR /src

# Copy dependency manifests first to leverage Docker layer caching.
# If go.mod / go.sum haven't changed, this layer is reused.
COPY go.mod go.sum ./
RUN go mod download

# Copy the rest of the source code.
COPY . .

# Build a statically linked binary with CGO disabled.
# -trimpath removes local filesystem paths from the binary.
# -ldflags="-s -w" strips debug info to reduce binary size.
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -trimpath -ldflags="-s -w" -o /bin/service ./cmd/service

# ============================================================
# Stage 2: Runtime
# ============================================================
# Distroless contains only the application and its runtime
# dependencies — no shell, no package manager, no OS utilities.
FROM gcr.io/distroless/static-debian12:nonroot

# Copy the CA certificates from the builder stage.
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

# Copy the compiled binary.
COPY --from=builder /bin/service /service

# Expose the default service port.
EXPOSE 8080

# Run as nonroot user (uid 65534) — the distroless nonroot
# image already sets this, but we make it explicit.
USER nonroot:nonroot

# Use ENTRYPOINT so the container always runs the service binary.
ENTRYPOINT ["/service"]
```

## Design Decisions

- **Multi-stage build**: separates the ~800 MB build toolchain from the ~2 MB runtime image
- **Distroless nonroot base**: smallest viable image with no shell attack surface; already configured for non-root execution
- **Layer caching**: `go.mod` / `go.sum` copied before source so dependency downloads are cached across builds
- **Static binary**: `CGO_ENABLED=0` produces a fully static binary that runs on distroless without libc
- **Trimpath + stripped symbols**: removes build-host paths and debug symbols, reducing binary size and information leakage
- **CA certificates**: copied explicitly to support outbound HTTPS from the service
- **Port 8080**: conventional non-privileged port for microservices
