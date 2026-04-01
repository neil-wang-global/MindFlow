# Raw Source

## Source ID
- src-007

## ACQ Event
- ACQ-003

## Source URL
- https://cheatsheetseries.owasp.org/cheatsheets/Input_Validation_Cheat_Sheet.html

## Fetch Timestamp
- 2026-04-01T10:22:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- OWASP Cheat Sheet Series — authoritative security guideline maintained by the OWASP Foundation

## Fetch Status
- success

## Fetch Completeness
- truncated
- Tool output truncated; full cheat sheet is extensive

## Original Content

OWASP Input Validation Cheat Sheet

Introduction

Input validation is performed to ensure only properly formed data is entering the workflow in an information system, preventing malformed data from persisting in the database and triggering malfunction of various downstream components. Input validation should happen as early as possible in the data flow, preferably as soon as the data is first received from the user.

Goals of Input Validation

Input validation is one of the first lines of defense for secure application development. Input validation:
- Prevents injection attacks (SQL injection, XSS, command injection, LDAP injection)
- Ensures data integrity
- Prevents application errors from malformed data

Input Validation Strategies

Syntactic validation enforces correct syntax of structured fields (e.g., SSN, date, currency symbol).
Semantic validation enforces correctness of values in the specific business context (e.g., start date is before end date, price is within expected range).

Allowlist vs Denylist

Allowlist (Positive) Validation:
- Define what IS allowed — reject everything else
- More secure than denylist because new attack vectors are automatically blocked
- Example: for a username field, allow only alphanumeric characters [a-zA-Z0-9]
- RECOMMENDED approach per OWASP

Denylist (Negative) Validation:
- Define what is NOT allowed — accept everything else
- Weaker because new attack patterns may not be in the denylist
- Should only be used as a secondary defense, never as the primary validation mechanism
- Example: blocking <script> tags (easily bypassed with encoding variations)

Validating Free-Form Text

Free-form text fields are the hardest to validate. Strategies include:
- Encoding: use context-appropriate encoding (HTML encoding, URL encoding, JavaScript encoding) when outputting user input
- Sanitization: remove or escape dangerous characters while preserving intended content
- Content Security Policy (CSP): use HTTP headers to restrict script execution in browsers

Input Validation for APIs

REST API input validation considerations:
- Validate Content-Type header (accept only expected types, e.g., application/json)
- Validate request body against a schema (JSON Schema validation)
- Validate URL parameters and query strings
- Validate HTTP method (reject unexpected methods)
- Set maximum request body size
- Validate all incoming data types (reject integers when strings are expected, etc.)

Common Input Validation Techniques

1. Type checking: verify data type matches expected type
2. Length checking: enforce minimum and maximum length constraints
3. Range checking: verify numeric values are within acceptable ranges
4. Pattern matching: use regular expressions to enforce format (e.g., email, phone)
5. Encoding validation: verify character encoding (reject invalid UTF-8)
6. Business logic validation: verify data makes sense in context

Parameterized Queries

For SQL injection prevention, NEVER construct SQL queries by concatenating user input. Use parameterized queries (prepared statements) or ORMs that handle parameterization:

// Vulnerable
String query = "SELECT * FROM users WHERE name = '" + userName + "'";

// Safe - parameterized query
String query = "SELECT * FROM users WHERE name = ?";
PreparedStatement stmt = connection.prepareStatement(query);
stmt.setString(1, userName);

Output Encoding

Input validation alone is not sufficient — output encoding is also required:
- HTML context: use HTML entity encoding
- JavaScript context: use JavaScript encoding
- URL context: use URL encoding
- CSS context: use CSS encoding
- SQL context: use parameterized queries (not encoding)

The encoding must be appropriate for the output context. Applying HTML encoding to data used in a JavaScript context will not prevent XSS.

Server-Side Validation

Client-side validation can be bypassed. All validation MUST be performed server-side. Client-side validation is acceptable only as a user experience improvement, never as a security control.
