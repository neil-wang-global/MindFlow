# Raw Source

## Source ID
- src-005

## ACQ Event
- ACQ-003

## Source URL
- https://pkg.go.dev/go.etcd.io/etcd/client/v3/concurrency

## Fetch Timestamp
- 2026-04-01T00:03:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — official Go package documentation for etcd client v3 concurrency package, maintained by etcd project

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

Package overview
- Package: go.etcd.io/etcd/client/v3/concurrency
- Purpose: Implements concurrency primitives on top of etcd (distributed locks, elections, STM). Mutex implements the sync.Locker interface backed by etcd.

Errors (package vars)
- ErrLocked = errors.New("mutex: Locked by another session")
  - Returned by TryLock when the mutex is already locked by another session.
- ErrSessionExpired = errors.New("mutex: session is expired")
- ErrLockReleased = errors.New("mutex: lock has already been released")

Type
- type Mutex struct { /* contains unexported fields */ }

Constructors
- func NewMutex(s *Session, pfx string) *Mutex
  - Creates a new Mutex associated with the Session s and using the key prefix pfx.

Methods (signatures and descriptions)
- func (m *Mutex) Lock(ctx context.Context) error
  - Lock the mutex. Uses a cancelable context. If the context is canceled while trying to acquire the lock, the mutex attempts to clean up its stale lock entry. Blocks until it acquires the lock or returns an error.

- func (m *Mutex) TryLock(ctx context.Context) error
  - Attempts to lock the mutex immediately if not already locked by another session. If already held by another session, returns immediately (after any necessary cleanup). ctx is used for the Txn RPC. If lock is held by another session, TryLock returns ErrLocked.

- func (m *Mutex) Unlock(ctx context.Context) error
  - Releases the lock.

- func (m *Mutex) IsOwner() v3.Cmp
  - Returns a v3.Cmp comparison that can be used to check whether this session owns the lock.

- func (m *Mutex) Key() string
  - Returns the leader/lock key (the created key) if the caller is the owner, or empty string otherwise.

- func (m *Mutex) Header() *pb.ResponseHeader
  - Returns the etcd response header returned when the lock was acquired (useful for metadata / revision info).

Notes / behavior
- Mutex implements sync.Locker semantics, but operations are backed by etcd and a session lease.
- Lock will block until it obtains the lock or an error occurs (or ctx is canceled).
- TryLock returns immediately; if the lock is held by another session, TryLock returns ErrLocked.
- If the session expires, operations will return ErrSessionExpired.
- Unlock on a lock that has already been released returns ErrLockReleased.

Minimal usage example
- Create session, mutex, lock/unlock (pseudocode):
  - s, err := concurrency.NewSession(cli)           // client is *v3.Client
  - m := concurrency.NewMutex(s, "/my-lock-prefix/")
  - ctx := context.TODO()
  - if err := m.Lock(ctx); err != nil {
      // handle error
    }
  - // critical section
  - if err := m.Unlock(ctx); err != nil {
      // handle error
    }
- TryLock usage:
  - if err := m.TryLock(ctx); err != nil {
      if err == concurrency.ErrLocked {
         // lock held by another session
      } else {
         // other error
      }
    } else {
      // acquired lock
    }

Helpful related functions/types
- Session: represents a lease kept alive for the lifetime of a client and is used to bind lock ownership.
  - NewSession(client *v3.Client, opts ...SessionOption) (*Session, error)
  - (s *Session) Close() error
  - (s *Session) Ctx() context.Context
  - (s *Session) Done() <-chan struct{}
  - (s *Session) Lease() v3.LeaseID
  - Session options: WithContext(ctx), WithLease(leaseID), WithTTL(ttl)

References (source file locations in the module)
- mutex implementation: client/v3/concurrency/mutex.go (examples and full logic live here)
- session logic: client/v3/concurrency/session.go
