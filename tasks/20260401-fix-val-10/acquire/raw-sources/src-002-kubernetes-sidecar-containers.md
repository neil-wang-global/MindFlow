# Raw Source

## Source ID
- src-002

## ACQ Event
- ACQ-001 — sidecar pattern for cross-cutting concerns

## Source URL
- https://kubernetes.io/docs/concepts/workloads/pods/sidecar-containers/

## Fetch Timestamp
- 2026-04-01

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- Official Kubernetes project documentation is the authoritative source for Kubernetes concepts and APIs

## Fetch Status
- success

## Fetch Completeness
- truncated
- Tool output was truncated before resource sharing and cgroups sections; core sidecar container definition, lifecycle, configuration, and examples were fully captured

## Original Content

# Sidecar Containers - Kubernetes Documentation

Sidecar containers are secondary containers that run alongside the main application container(s) in the same Pod. Their purpose is to enhance or extend the primary app container's functionality without changing the app code (examples: logging, monitoring, security, data synchronization). Typically a Pod has one app container; supporting services (for example, a local webserver for the app) are implemented as sidecars.

## How sidecar containers are implemented and how they work

Kubernetes implements sidecar containers as a special case of init containers: they are specified in .spec.initContainers but are configured to remain running after Pod startup (see restartPolicy usage below). The SidecarContainers feature gate must be enabled in the cluster (enabled by default since Kubernetes v1.29; feature marked stable in v1.33).

By setting restartPolicy on an init container (e.g., restartPolicy: Always), that init container is treated as a restartable, long-running sidecar container instead of a one-shot init container. Sidecars remain independent of regular init containers and the main app containers; they can be started, stopped, and restarted without affecting other containers in the Pod.

## Lifecycle and ordering semantics

Because sidecars are defined under initContainers, they benefit from init container ordering and sequential guarantees:
- The kubelet starts each init container in order. When a sidecar-style init container is running (kubelet marks it started), the kubelet then starts the next init container in .spec.initContainers.
- This allows mixing regular init containers (one-shot startup tasks) with sidecars (supporting services).

If a readinessProbe is defined for a sidecar defined this way, its result will affect the Pod ready state (i.e., pod readiness considers that sidecar's readiness probe).

On Pod termination, the kubelet postpones terminating sidecar containers until the main application container(s) have fully stopped. Sidecars are shut down in the reverse order of their appearance in the Pod spec. This ensures sidecars remain available to support the app until no longer needed.

For Jobs using Kubernetes-style init-container sidecars, the sidecar does not prevent the Job from completing after the main container finishes.

## Behavioral notes

- Sidecars run concurrently with app containers and can be active for the life of the Pod.
- Sidecars share the Pod's network and storage namespaces with the app container, allowing close interaction and resource sharing (volumes, sockets, etc.).
- Sidecars have independent lifecycle; changing a sidecar image will trigger a container restart (but not necessarily restart the whole Pod).
- On Pod termination, sidecars may receive SIGTERM and then SIGKILL if graceful termination time is exhausted; non-zero exit codes from sidecars on termination are normal and often ignored by external tooling.

## Differences from application containers

- Sidecars provide supporting functionality rather than primary application logic.
- They can be started/stopped/restarted independently of the app container(s).
- They share networking and storage with the app container(s), enabling tight integration (e.g., tails logs on shared volume, proxies on same network namespace).

## Differences from init containers

- Regular init containers execute only during Pod startup and exit before main containers start; they cannot communicate with the app container while running concurrently.
- Sidecars (when defined using an initContainers entry with restartPolicy set to a restartable mode) remain running and can interact with app containers for the Pod lifetime.
- Sidecars support probes to control lifecycle; init containers are one-shot by design.

## Use cases

- Logging agents that tail application logs on a shared volume and ship them out.
- Monitoring agents that collect metrics or traces.
- Sidecars that provide a local proxy, auth, or security function.
- Data synchronization helpers or small helper services that the app depends on but you want to manage separately.

## Examples

### Deployment with a sidecar

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
  labels:
    app: myapp
spec:
  replicas: 1
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
        - name: myapp
          image: alpine:latest
          command: ['sh', '-c', 'while true; do echo "logging" >> /opt/logs.txt; sleep 1; done']
          volumeMounts:
            - name: data
              mountPath: /opt
      initContainers:
        - name: logshipper
          image: alpine:latest
          restartPolicy: Always
          command: ['sh', '-c', 'tail -F /opt/logs.txt']
          volumeMounts:
            - name: data
              mountPath: /opt
      volumes:
        - name: data
          emptyDir: {}
```

### Job with a sidecar

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: myjob
spec:
  template:
    spec:
      containers:
        - name: myjob
          image: alpine:latest
          command: ['sh', '-c', 'echo "logging" > /opt/logs.txt']
          volumeMounts:
            - name: data
              mountPath: /opt
      initContainers:
        - name: logshipper
          image: alpine:latest
          restartPolicy: Always
          command: ['sh', '-c', 'tail -F /opt/logs.txt']
          volumeMounts:
            - name: data
              mountPath: /opt
      restartPolicy: Never
      volumes:
        - name: data
          emptyDir: {}
```

## Feature state
- Kubernetes v1.33 [stable] — SidecarContainers feature enabled by default.
