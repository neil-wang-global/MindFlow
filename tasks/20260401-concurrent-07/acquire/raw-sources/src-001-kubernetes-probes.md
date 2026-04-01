# Raw Source

## Source ID
- src-001

## ACQ Event
- ACQ-001

## Source URL
- https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/

## Fetch Timestamp
- 2026-04-01T10:02:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- Official Kubernetes project documentation maintained by the CNCF

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

Summary: liveness, readiness and startup probes
- Purpose
  - Liveness probe: tells kubelet whether to restart a container. Use it to detect and recover from unrecoverable app failures (deadlocks, hung main thread).
  - Readiness probe: tells kubelet (and Services) whether a container is ready to receive traffic. When not ready the Pod is removed from service endpoints.
  - Startup probe: tells kubelet whether the application in the container has finished starting. If a startup probe is configured, the kubelet disables liveness and readiness probes until the startup probe succeeds — useful for slow-starting apps so they aren't killed early.

When to use each
- Liveness: for detecting unrecoverable runtime failures that require a restart. Be careful — misconfigured liveness probes can cause restarts under load.
- Readiness: whenever your app needs time to warm up, load data, or otherwise should not receive traffic immediately; use it to control traffic routing.
- Startup: when your app takes a long time to initialize (e.g., JIT, DB migrations). Use it instead of relaxing liveness/readiness settings, so normal liveness/readiness semantics resume after startup succeeds.

Probe types (what they do and how they check)
- exec
  - Runs a command inside the container.
  - Success = exit code 0 → probe passes. Non-zero → probe fails.
  - Example (from docs):
      livenessProbe:
        exec:
          command: ["cat", "/tmp/healthy"]
        initialDelaySeconds: 5
        periodSeconds: 5
  - Typical use: internal health checks that can be determined by reading a file, checking pid, status file, etc.

- HTTP (httpGet)
  - Kubelet performs an HTTP GET against the container on the given path/port.
  - Success: HTTP status in 200–399 range; otherwise probe fails.
  - Use for web services exposing a lightweight health endpoint (e.g., /healthz, /live, /ready).
  - Keep endpoint cheap and non-blocking.

- TCP (tcpSocket)
  - Kubelet attempts to open a TCP connection to the container port.
  - Success: connection established. Use when a TCP acceptability check is sufficient (e.g., service listening on port).

- gRPC
  - Uses the gRPC health-check protocol (if supported by app).
  - Useful for gRPC services that implement the standard health service.

Common configuration fields (applies to liveness/readiness/startup)
- initialDelaySeconds: wait before starting probes.
- periodSeconds: how often to run the probe.
- timeoutSeconds: how long to wait for probe response before it times out.
- successThreshold: number of consecutive successes for the probe to be considered successful (mostly used for readiness/startup).
- failureThreshold: number of consecutive failures required before action (restart/remove) is taken.
- probe types: exec / httpGet / tcpSocket / grpc

Behavior differences
- Liveness: failing liveness typically causes container restart.
- Readiness: failing readiness removes Pod from Service endpoints (no restart).
- Startup: failing startup for long enough will be treated as startup failure (container restart depending on thresholds); until it passes, liveness/readiness are disabled.

Best practices and guidance
- Use readiness for in-flight readiness (don't send traffic until app is prepared). Use liveness for unrecoverable failure detection.
- Protect slow-starting containers with a startup probe instead of lengthening liveness timeouts; when startup probe is configured, liveness and readiness probes are suspended until startup probe succeeds.
- Prefer inexpensive, fast health endpoints. Health checks should be low-cost and non-blocking so they don't add load or become a source of failure.
- Use the same HTTP endpoint for both readiness and liveness when appropriate, but give liveness a higher failureThreshold to avoid killing pods under short transient failures. Example: same low-cost /health endpoint; readiness with lower failureThreshold; liveness with higher failureThreshold.
- Avoid running expensive diagnostic logic in probes. Heavy checks under load can cascade into failures and restarts.
- Understand the difference between readiness and liveness to avoid unnecessary restarts and cascading failures.
- Use named ports in Pod/Container specs if you refer to ports by name in probes.

Example: exec liveness probe (from the docs)
- Pod YAML that creates a /tmp/healthy file for 30s, then removes it so probe fails and the container is restarted:

    apiVersion: v1
    kind: Pod
    metadata:
      labels:
        test: liveness
      name: liveness-exec
    spec:
      containers:
      - name: liveness
        image: registry.k8s.io/busybox:1.27.2
        args:
        - /bin/sh
        - -c
        - touch /tmp/healthy; sleep 30; rm -f /tmp/healthy; sleep 600
        livenessProbe:
          exec:
            command:
            - cat
            - /tmp/healthy
          initialDelaySeconds: 5
          periodSeconds: 5

Notes and cautions
- Liveness probes are powerful but must be configured carefully. Incorrect probes can cause cascading failures (restarts under load, failed client requests, increased load on remaining pods).
- Test probes in staging to ensure thresholds/timeouts tune correctly for your workload and node conditions.
- Consider higher failureThreshold for liveness than readiness to give transient errors time to resolve before restarts.

Where to read more
- Kubernetes concept page: "Liveness, Readiness and Startup Probes" (concepts/configuration) and task walkthrough: "Configure Liveness, Readiness and Startup Probes" (tasks/configure-pod-container/configure-liveness-readiness-startup-probes) — the docs include HTTP, TCP and gRPC probe examples and descriptions of probe-level terminationGracePeriodSeconds and other advanced options.
