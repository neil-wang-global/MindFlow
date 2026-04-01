# Raw Source

## Source ID
- src-004

## ACQ Event
- ACQ-002

## Source URL
- https://datatracker.ietf.org/doc/html/rfc7519

## Fetch Timestamp
- 2026-04-01T10:12:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- IETF RFC — the authoritative specification for JSON Web Tokens

## Fetch Status
- success

## Fetch Completeness
- truncated
- Tool output truncated to key sections on claims, validation, and security

## Original Content

RFC 7519 - JSON Web Token (JWT)

Abstract

JSON Web Token (JWT) is a compact, URL-safe means of representing claims to be transferred between two parties. The claims in a JWT are encoded as a JSON object that is used as the payload of a JSON Web Signature (JWS) structure or as the plaintext of a JSON Web Encryption (JWE) structure, enabling the claims to be digitally signed or integrity protected with a Message Authentication Code (MAC) and/or encrypted.

1. Introduction

JSON Web Token (JWT) is a compact claims representation format intended for space constrained environments such as HTTP Authorization headers and URI query parameters.

JWTs encode claims to be transmitted as a JSON [RFC7159] object that is used as the payload of a JSON Web Signature (JWS) [JWS] structure or as the plaintext of a JSON Web Encryption (JWE) [JWE] structure, enabling the claims to be digitally signed or integrity protected with a Message Authentication Code (MAC) and/or encrypted.

4. JWT Claims

The following Claim Names are registered in the IANA "JSON Web Token Claims" registry:

4.1.1. "iss" (Issuer) Claim
The "iss" (issuer) claim identifies the principal that issued the JWT. The processing of this claim is generally application specific. The "iss" value is a case-sensitive string containing a StringOrURI value.

4.1.2. "sub" (Subject) Claim
The "sub" (subject) claim identifies the principal that is the subject of the JWT. The claims in a JWT are normally statements about the subject. The "sub" value is a case-sensitive string containing a StringOrURI value.

4.1.3. "aud" (Audience) Claim
The "aud" (audience) claim identifies the recipients that the JWT is intended for. Each principal intended to process the JWT MUST identify itself with a value in the audience claim. If the principal processing the claim does not identify itself with a value in the "aud" claim when this claim is present, then the JWT MUST be rejected.

4.1.4. "exp" (Expiration Time) Claim
The "exp" (expiration time) claim identifies the expiration time on or after which the JWT MUST NOT be accepted for processing. Its value MUST be a number containing a NumericDate value. Implementers MAY provide for some small leeway, usually no more than a few minutes, to account for clock skew.

4.1.5. "nbf" (Not Before) Claim
The "nbf" (not before) claim identifies the time before which the JWT MUST NOT be accepted for processing. Its value MUST be a number containing a NumericDate value.

4.1.6. "iat" (Issued At) Claim
The "iat" (issued at) claim identifies the time at which the JWT was issued. This claim can be used to determine the age of the JWT.

4.1.7. "jti" (JWT ID) Claim
The "jti" (JWT ID) claim provides a unique identifier for the JWT. The identifier value MUST be assigned in a manner that ensures that there is a negligible probability that the same value will be accidentally assigned to a different data object.

7. Creating and Validating JWTs

7.1. Creating a JWT
To create a JWT, the following steps are performed:
1. Create a JWT Claims Set containing the desired claims.
2. Let the Message be the octets of the UTF-8 representation of the JWT Claims Set.
3. Create a JOSE Header containing the desired set of Header Parameters.
4. Depending on whether the JWT is a JWS or JWE, create a JWS or JWE using the Message as the JWS Payload or the JWE Plaintext.

7.2. Validating a JWT
When validating a JWT, the following steps MUST be performed:
1. Verify that the JWT contains at least one period ('.') character.
2. Let the Encoded JOSE Header be the portion of the JWT before the first period ('.') character.
3. Base64url decode the Encoded JOSE Header.
4. Verify that the resulting octet sequence is a UTF-8-encoded representation of a completely valid JSON object.
5. Verify that the resulting JOSE Header includes only parameters and values whose syntax and semantics are both understood and supported.
6. Determine whether the JWT is a JWS or a JWE.
7. Validate the JWS or JWE respectively.
8. If the JWT Claims Set has to be validated, validate the claims.

8. Implementation Requirements

Of the signature and MAC algorithms specified in JSON Web Algorithms [JWA], only HMAC SHA-256 ("HS256") and "none" MUST be implemented by conforming JWT implementations. It is RECOMMENDED that implementations also support RSASSA-PKCS1-v1_5 with SHA-256 ("RS256") and ECDSA using P-256 and SHA-256 ("ES256").

11. Security Considerations

11.1. Trust Decisions
The contents of a JWT cannot be relied upon in a trust decision unless its contents have been cryptographically secured and bound to the context necessary for the trust decision.

11.2. Signing and Encryption Order
While syntactically the signing and encryption operations for Nested JWTs may be applied in any order, if both signing and encryption are necessary, normally producers should sign the JWT first and then encrypt the resulting JWS.
