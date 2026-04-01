# Raw Source

## Source ID
- src-005

## ACQ Event
- ACQ-002

## Source URL
- https://datatracker.ietf.org/doc/html/rfc7515

## Fetch Timestamp
- 2026-04-01T10:13:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- IETF RFC — the authoritative specification for JSON Web Signature

## Fetch Status
- success

## Fetch Completeness
- truncated
- Tool output truncated to sections on algorithms and security considerations

## Original Content

RFC 7515 - JSON Web Signature (JWS)

Abstract

JSON Web Signature (JWS) represents content secured with digital signatures or Message Authentication Codes (MACs) using JSON-based data structures.

3.1. JWS Compact Serialization Overview

In the JWS Compact Serialization, no JWS Unprotected Header is used. In this case, the JOSE Header and the JWS Protected Header are the same.

The JWS Compact Serialization represents digitally signed or MACed content as a compact, URL-safe string. This string is:

BASE64URL(UTF8(JWS Protected Header)) || '.' || BASE64URL(JWS Payload) || '.' || BASE64URL(JWS Signature)

4.1. "alg" (Algorithm) Header Parameter

The "alg" (algorithm) Header Parameter identifies the cryptographic algorithm used to secure the JWS. The JWS Signature value is not valid if the "alg" value does not represent a supported algorithm or if there is not a key for use with that algorithm associated with the party that digitally signed or MACed the content.

Commonly used algorithms:
- HS256: HMAC using SHA-256 — symmetric key algorithm; the same secret key is used for both signing and verification
- HS384: HMAC using SHA-384
- HS512: HMAC using SHA-512
- RS256: RSASSA-PKCS1-v1_5 using SHA-256 — asymmetric algorithm; uses a private key for signing and a public key for verification
- RS384: RSASSA-PKCS1-v1_5 using SHA-384
- RS512: RSASSA-PKCS1-v1_5 using SHA-512
- ES256: ECDSA using P-256 and SHA-256 — asymmetric algorithm with shorter key sizes
- ES384: ECDSA using P-384 and SHA-384
- ES512: ECDSA using P-521 and SHA-512
- PS256: RSASSA-PSS using SHA-256 and MGF1 with SHA-256

8. Security Considerations

8.1. Key Entropy and Random Values
Keys are only as strong as the amount of entropy used to generate them. A minimum of 128 bits of entropy should be used for all keys.

8.2. Key Protection
Implementations MUST protect signing/MAC keys from disclosure.

8.3. Key Origin Authentication
Validation of the JWS only provides integrity protection and source authentication for the JWS Protected Header and JWS Payload. It does not provide key origin authentication.

8.4. Cryptographic Agility
It is RECOMMENDED that implementations support cryptographic agility. JWS supports different algorithms for different deployments.

8.5. Differences Between Digital Signatures and MACs
Digital signatures provide non-repudiation (the signer cannot deny signing), while MACs do not. HMAC-based algorithms (HS256, HS384, HS512) use symmetric keys, meaning anyone who can verify the MAC can also create it. RSA and ECDSA-based algorithms use asymmetric keys, providing true non-repudiation.

Security tradeoff:
- HS256 (symmetric): simpler key management for single-service scenarios; both parties share the same secret; faster computation; NOT suitable when the verifier should not be able to create tokens
- RS256 (asymmetric): private key signs, public key verifies; suitable for distributed systems where multiple services need to verify tokens but only the auth server should issue them; provides non-repudiation; recommended for microservice architectures
- ES256 (asymmetric): same security model as RS256 but with shorter key sizes and faster computation for equivalent security levels
