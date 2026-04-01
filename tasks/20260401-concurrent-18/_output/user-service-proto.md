# gRPC User Service Proto Definition

Task ID: 20260401-concurrent-18

## Proto File: user_service.proto

```protobuf
syntax = "proto3";

package user.v1;

option go_package = "github.com/example/user-service/proto/user/v1;userv1";
option java_package = "com.example.userservice.proto.user.v1";
option java_multiple_files = true;

import "google/protobuf/timestamp.proto";
import "google/protobuf/field_mask.proto";

// UserService provides CRUD operations for user management.
service UserService {
  // CreateUser creates a new user and returns the created user.
  rpc CreateUser(CreateUserRequest) returns (CreateUserResponse);

  // GetUser retrieves a single user by ID.
  rpc GetUser(GetUserRequest) returns (GetUserResponse);

  // UpdateUser applies a partial update to an existing user.
  rpc UpdateUser(UpdateUserRequest) returns (UpdateUserResponse);

  // DeleteUser removes a user by ID.
  rpc DeleteUser(DeleteUserRequest) returns (DeleteUserResponse);

  // ListUsers returns a paginated list of users.
  rpc ListUsers(ListUsersRequest) returns (ListUsersResponse);
}

// User represents a user entity.
message User {
  // Unique identifier for the user.
  string id = 1;

  // Display name of the user.
  string name = 2;

  // Email address of the user. Must be unique.
  string email = 3;

  // Phone number of the user. Optional.
  string phone = 4;

  // Current status of the user account.
  UserStatus status = 5;

  // Timestamp when the user was created. Set by the server.
  google.protobuf.Timestamp created_at = 6;

  // Timestamp when the user was last updated. Set by the server.
  google.protobuf.Timestamp updated_at = 7;
}

// UserStatus defines the possible states of a user account.
enum UserStatus {
  USER_STATUS_UNSPECIFIED = 0;
  USER_STATUS_ACTIVE = 1;
  USER_STATUS_INACTIVE = 2;
  USER_STATUS_SUSPENDED = 3;
}

// CreateUserRequest is the request message for CreateUser.
message CreateUserRequest {
  // Required. The display name for the new user.
  string name = 1;

  // Required. The email address for the new user. Must be unique.
  string email = 2;

  // Optional. The phone number for the new user.
  string phone = 3;
}

// CreateUserResponse is the response message for CreateUser.
message CreateUserResponse {
  // The newly created user.
  User user = 1;
}

// GetUserRequest is the request message for GetUser.
message GetUserRequest {
  // Required. The ID of the user to retrieve.
  string id = 1;
}

// GetUserResponse is the response message for GetUser.
message GetUserResponse {
  // The requested user.
  User user = 1;
}

// UpdateUserRequest is the request message for UpdateUser.
message UpdateUserRequest {
  // Required. The user with updated fields.
  // The user.id field identifies which user to update.
  User user = 1;

  // Required. The set of fields to update.
  // Only fields specified in the field mask will be modified.
  google.protobuf.FieldMask update_mask = 2;
}

// UpdateUserResponse is the response message for UpdateUser.
message UpdateUserResponse {
  // The updated user.
  User user = 1;
}

// DeleteUserRequest is the request message for DeleteUser.
message DeleteUserRequest {
  // Required. The ID of the user to delete.
  string id = 1;
}

// DeleteUserResponse is the response message for DeleteUser.
// Empty response indicates successful deletion.
message DeleteUserResponse {}

// ListUsersRequest is the request message for ListUsers.
message ListUsersRequest {
  // Optional. Maximum number of users to return. Default is 20, max is 100.
  int32 page_size = 1;

  // Optional. Token for retrieving the next page of results.
  // Empty string or omitted for the first page.
  string page_token = 2;

  // Optional. Filter by user status.
  UserStatus status_filter = 3;
}

// ListUsersResponse is the response message for ListUsers.
message ListUsersResponse {
  // The list of users for the current page.
  repeated User users = 1;

  // Token for retrieving the next page. Empty if no more pages.
  string next_page_token = 2;

  // Total number of users matching the filter criteria.
  int32 total_count = 3;
}
```

## Design Notes

- **Proto3 syntax** with explicit package naming (`user.v1`) for versioning support
- **Contract-first design**: all RPCs have dedicated request/response message types, enabling independent evolution
- **FieldMask for updates**: UpdateUser uses `google.protobuf.FieldMask` to support partial updates without overwriting unspecified fields
- **Pagination**: ListUsers supports cursor-based pagination via `page_token` / `next_page_token` pattern
- **Status enum**: follows proto3 convention with `_UNSPECIFIED = 0` as the default/zero value
- **Temporal fields**: uses `google.protobuf.Timestamp` for `created_at` and `updated_at` (server-managed)
- **Empty delete response**: DeleteUserResponse is empty, following the convention that successful deletion needs no payload
- **Language options**: includes `go_package` and `java_package` options for common target languages
