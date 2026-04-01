# Raw Source

## Source ID
- src-002

## ACQ Event
- ACQ-001

## Source URL
- https://datatracker.ietf.org/doc/html/rfc7636

## Fetch Timestamp
- 2026-04-01T10:03:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- IETF RFC — the authoritative specification for PKCE

## Fetch Status
- success

## Fetch Completeness
- truncated
- Tool output truncated to key sections; full RFC is shorter than RFC 6749

## Original Content

RFC 7636 - Proof Key for Code Exchange by OAuth Public Clients

Abstract

OAuth 2.0 public clients utilizing the Authorization Code Grant are susceptible to the authorization code interception attack. This specification describes the attack as well as a technique to mitigate against the threat through the use of Proof Key for Code Exchange (PKCE, pronounced "pixy").

1. Introduction

OAuth 2.0 [RFC6749] public clients are susceptible to the authorization code interception attack. In this attack, the attacker intercepts the authorization code returned from the authorization endpoint within a communication path not protected by Transport Layer Security (TLS), such as inter-application communication within the client's operating system.

To mitigate this attack, this extension utilizes a dynamically created cryptographically random key called "code verifier". A unique code verifier is created for every authorization request, and its transformed value, called "code challenge", is sent to the authorization server to obtain the authorization code. The authorization code obtained is then sent to the token endpoint with the "code verifier", and the server compares it with the previously received request code so it can perform the proof of possession of the "code verifier" by the client.

1.1. Protocol Flow

                                                 +-------------------+
                                                 |   Authz Server    |
       +--------+                                | +---------------+ |
       |        |--(A)- Authorization Request ---->|               | |
       |        |       + t(code_verifier), t_m  | | Authorization | |
       |        |                                | |    Endpoint   | |
       |        |<-(B)---- Authorization Code -----|               | |
       |        |                                | +---------------+ |
       | Client |                                |                   |
       |        |                                | +---------------+ |
       |        |--(C)-- Access Token Request ---->|               | |
       |        |          + code_verifier       | |    Token      | |
       |        |                                | |   Endpoint    | |
       |        |<-(D)------ Access Token --------|               | |
       +--------+                                | +---------------+ |
                                                 +-------------------+

A. The client creates and records a secret named the "code_verifier" and derives a transformed version "t(code_verifier)" (referred to as the "code_challenge"), which is sent in the OAuth 2.0 Authorization Request along with the transformation method "t_m".

B. The Authorization Endpoint responds as usual but records "t(code_verifier)" and the transformation method.

C. The client then sends the authorization code in the Access Token Request as usual but includes the "code_verifier" secret generated at (A).

D. The authorization server transforms "code_verifier" and compares it to "t(code_verifier)" from (B). Access is denied if they are not equal.

4.2. Client Creates the Code Challenge

The client then creates a code challenge derived from the code verifier by using one of the following transformations on the code verifier:

plain
  code_challenge = code_verifier

S256
  code_challenge = BASE64URL(SHA256(code_verifier))

If the client is capable of using "S256", it MUST use "S256", as "S256" is Mandatory To Implement (MTI) on the server. Clients are permitted to use "plain" only if they cannot support "S256" for some technical reason and know via out-of-band configuration that the server supports "plain".

7. Security Considerations

7.1. If the attacker can learn the "code_verifier" value, then the mitigation offered by PKCE is lost. In order to prevent this, the "code_verifier" must be created in such a manner that it is cryptographically random and has sufficient entropy.

7.3. Clients MUST NOT downgrade to "plain" if "S256" was initially used. The authorization server MUST reject the token request if the transformation method is not the same as the one used in the authorization request.
