# Task Profile

## Task ID
- 20260401-concurrent-18

## Task Type
- delivery

## Goal
- Write a gRPC protocol buffer definition file for a user service. The proto file should define standard CRUD operations (Create, Read, Update, Delete) for user entities, with well-structured message types and service definitions following protobuf best practices and contract-first API design principles.

## Inputs
- Task statement: "Write a gRPC proto file for user service"
- Soul constraints: contract-first API design, explicit failure handling

## Success Criteria
- A complete .proto file (or equivalent documented output) with UserService definition
- Standard CRUD RPC methods defined (CreateUser, GetUser, UpdateUser, DeleteUser, ListUsers)
- Well-defined request/response message types
- Proper use of proto3 syntax, package naming, and field numbering
- Output delivered to _output/user-service-proto.md

## Complexity
- low

## Risk
- low

## Capability Needs
- Protocol buffer / gRPC API design
- Service interface design

## Constraints
- Output file must be _output/user-service-proto.md
- Task ID must be included in all created files per concurrency rules
- Must not modify existing shared files

## Task-level Learning Possibility
- not-expected

## Mode
- compact

## Inference Possibility
- not needed — straightforward proto definition with well-established patterns

## Notes
- This is a low-complexity delivery task producing a single proto file artifact
- Compact mode applies: low complexity, low risk
