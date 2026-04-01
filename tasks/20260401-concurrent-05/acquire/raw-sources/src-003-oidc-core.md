# Raw Source

## Source ID
- src-003

## ACQ Event
- ACQ-001

## Source URL
- https://openid.net/specs/openid-connect-core-1_0.html

## Fetch Timestamp
- 2026-04-01T10:04:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- OpenID Foundation official specification

## Fetch Status
- success

## Fetch Completeness
- truncated
- Very large specification; tool output truncated to sections on token types and claims

## Original Content

OpenID Connect Core 1.0

Abstract

OpenID Connect 1.0 is a simple identity layer on top of the OAuth 2.0 protocol. It enables Clients to verify the identity of the End-User based on the authentication performed by an Authorization Server, as well as to obtain basic profile information about the End-User in an interoperable and REST-like manner.

1. Introduction

OpenID Connect 1.0 is a simple identity layer on top of the OAuth 2.0 [RFC6749] protocol. It allows Clients to verify the identity of the End-User based on the authentication performed by an Authorization Server, as well as to obtain basic profile information about the End-User.

OpenID Connect implements authentication as an extension to the OAuth 2.0 authorization process. The OpenID Connect login flow is:
1. The client sends an authentication request to the OpenID Provider (OP).
2. The OP authenticates the End-User and obtains authorization.
3. The OP responds with an ID Token and usually an Access Token.
4. The client can send a request with the Access Token to the UserInfo Endpoint.
5. The UserInfo Endpoint returns Claims about the End-User.

2. ID Token

The primary extension that OpenID Connect makes to OAuth 2.0 to enable End-Users to be authenticated is the ID Token data structure. The ID Token is a security token that contains Claims about the Authentication of an End-User by an Authorization Server when using a Client, and potentially other requested Claims. The ID Token is represented as a JSON Web Token (JWT) [JWT].

The following Claims are used within the ID Token:
- iss (REQUIRED): Issuer Identifier for the Issuer of the response.
- sub (REQUIRED): Subject Identifier. A locally unique and never reassigned identifier within the Issuer for the End-User.
- aud (REQUIRED): Audience(s) that this ID Token is intended for. It MUST contain the OAuth 2.0 client_id of the Relying Party as an audience value.
- exp (REQUIRED): Expiration time on or after which the ID Token MUST NOT be accepted for processing.
- iat (REQUIRED): Time at which the JWT was issued.
- auth_time: Time when the End-User authentication occurred.
- nonce: String value used to associate a Client session with an ID Token, and to mitigate replay attacks.
- acr: Authentication Context Class Reference.
- amr: Authentication Methods References.
- azp: Authorized party — the party to which the ID Token was issued.

3.1.3.7. ID Token Validation

When using the Authorization Code Flow, the Client MUST validate the ID Token as follows:
1. If the ID Token is encrypted, decrypt it.
2. The Issuer Identifier for the OpenID Provider MUST exactly match the value of the iss (issuer) Claim.
3. The Client MUST validate that the aud (audience) Claim contains its client_id value.
4. If the ID Token contains multiple audiences, the Client SHOULD verify that an azp Claim is present.
5. The current time MUST be before the time represented by the exp Claim.

5.1. Standard Claims

OpenID Connect defines a set of standard Claims:
- sub: Subject — Identifier for the End-User at the Issuer.
- name: End-User's full name.
- given_name: Given name(s) or first name(s).
- family_name: Surname(s) or last name(s).
- email: End-User's preferred e-mail address.
- email_verified: True if the End-User's e-mail address has been verified.
- phone_number: End-User's preferred telephone number.

16. Security Considerations

16.1. Request Disclosure
Since requests to the authorization endpoint result in the transmission of authentication credentials, their confidentiality MUST be maintained.

16.2. Server Masquerading
An attacker could attempt to impersonate a valid server. ID Token validation and TLS server certificate verification can be used to prevent this.

16.15. Token Manufacture/Modification
An attacker could generate a bogus ID Token. The ID Token MUST be digitally signed using JWS.
