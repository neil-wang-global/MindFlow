# Raw Source

## Source ID
- src-001

## ACQ Event
- ACQ-001

## Source URL
- https://datatracker.ietf.org/doc/html/rfc6749

## Fetch Timestamp
- 2026-04-01T10:02:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- IETF RFC — the authoritative specification for OAuth 2.0

## Fetch Status
- success

## Fetch Completeness
- truncated
- RFC 6749 is a large document (76 pages); tool output was truncated to key sections

## Original Content

RFC 6749 - The OAuth 2.0 Authorization Framework

Abstract

The OAuth 2.0 authorization framework enables a third-party application to obtain limited access to an HTTP service, either on behalf of a resource owner by orchestrating an approval interaction between the resource owner and the HTTP service, or by allowing the third-party application to obtain access on its own behalf.

1. Introduction

In the traditional client-server authentication model, the client requests an access-restricted resource (protected resource) on the server by authenticating with the server using the resource owner's credentials. In order to provide third-party applications access to restricted resources, the resource owner shares its credentials with the third party.

OAuth addresses these issues by introducing an authorization layer and separating the role of the client from that of the resource owner. In OAuth, the client requests access to resources controlled by the resource owner and hosted by the resource server, and is issued a different set of credentials than those of the resource owner.

1.1. Roles

OAuth defines four roles:
- resource owner: An entity capable of granting access to a protected resource.
- resource server: The server hosting the protected resources, capable of accepting and responding to protected resource requests using access tokens.
- client: An application making protected resource requests on behalf of the resource owner and with its authorization.
- authorization server: The server issuing access tokens to the client after successfully authenticating the resource owner and obtaining authorization.

1.2. Protocol Flow

     +--------+                               +---------------+
     |        |--(A)- Authorization Request ->|   Resource    |
     |        |                               |     Owner     |
     |        |<-(B)-- Authorization Grant ---|               |
     |        |                               +---------------+
     |        |
     |        |                               +---------------+
     |        |--(C)-- Authorization Grant -->| Authorization |
     | Client |                               |     Server    |
     |        |<-(D)----- Access Token -------|               |
     |        |                               +---------------+
     |        |
     |        |                               +---------------+
     |        |--(E)----- Access Token ------>|    Resource   |
     |        |                               |     Server    |
     |        |<-(F)--- Protected Resource ---|               |
     +--------+                               +---------------+

1.3. Authorization Grant

An authorization grant is a credential representing the resource owner's authorization, used by the client to obtain an access token. This specification defines four grant types:
- authorization code
- implicit
- resource owner password credentials
- client credentials

1.3.1. Authorization Code

The authorization code is obtained by using an authorization server as an intermediary between the client and resource owner. The client directs the resource owner to an authorization server, which in turn directs the resource owner back to the client with the authorization code. The authorization code provides a few important security benefits: the ability to authenticate the client, as well as the transmission of the access token directly to the client without passing it through the resource owner's user-agent.

1.3.2. Implicit

The implicit grant is a simplified authorization code flow optimized for clients implemented in a browser using a scripting language such as JavaScript. In the implicit flow, instead of issuing the client an authorization code, the client is issued an access token directly. The grant type is implicit, as no intermediate credentials are issued. Note: The implicit grant type is no longer recommended per OAuth 2.0 Security Best Current Practice.

1.3.3. Resource Owner Password Credentials

The resource owner password credentials can be used directly as an authorization grant to obtain an access token. The credentials should only be used when there is a high degree of trust between the resource owner and the client.

1.3.4. Client Credentials

The client credentials can be used as an authorization grant when the authorization scope is limited to the protected resources under the control of the client. Client credentials are used as an authorization grant typically when the client is acting on its own behalf.

1.4. Access Token

Access tokens are credentials used to access protected resources. An access token is a string representing an authorization issued to the client. Tokens represent specific scopes and durations of access, granted by the resource owner, and enforced by the resource server and authorization server.

1.5. Refresh Token

Refresh tokens are credentials used to obtain access tokens. Refresh tokens are issued to the client by the authorization server and are used to obtain a new access token when the current access token becomes invalid or expires.

4.1. Authorization Code Grant

     +----------+
     | Resource |
     |   Owner  |
     |          |
     +----------+
          ^
          |
         (B)
     +----|-----+          Client Identifier      +---------------+
     |         -+----(A)-- & Redirection URI ---->|               |
     |  User-   |                                 | Authorization |
     |  Agent  -+----(B)-- User authenticates --->|     Server    |
     |          |                                 |               |
     |         -+----(C)-- Authorization Code ---<|               |
     +-|----|---+                                 +---------------+
       |    |                                         ^      v
      (A)  (C)                                        |      |
       |    |                                         |      |
       ^    v                                         |      |
     +---------+                                      |      |
     |         |>---(D)-- Authorization Code ---------'      |
     |  Client |          & Redirection URI                  |
     |         |                                             |
     |         |<---(E)----- Access Token -------------------'
     +---------+       (w/ Optional Refresh Token)

The authorization code grant type is used to obtain both access tokens and refresh tokens and is optimized for confidential clients.

Step (A): The client initiates the flow by directing the resource owner's user-agent to the authorization endpoint. The client includes its client identifier, requested scope, local state, and a redirection URI.
Step (B): The authorization server authenticates the resource owner and establishes whether the resource owner grants or denies the client's access request.
Step (C): The authorization server redirects the user-agent back to the client using the redirection URI provided earlier. The redirection URI includes an authorization code and any local state provided by the client earlier.
Step (D): The client requests an access token from the authorization server's token endpoint by including the authorization code and the redirection URI used to obtain the authorization code.
Step (E): The authorization server authenticates the client, validates the authorization code, and ensures that the redirection URI matches the URI used to redirect the client in step (C). If valid, the authorization server responds back with an access token and, optionally, a refresh token.

10. Security Considerations

10.1. Client Authentication
The authorization server MUST NOT issue client credentials to clients that are incapable of keeping their credentials confidential.

10.3. Access Tokens
Access token credentials MUST only be transmitted using TLS.

10.4. Refresh Tokens
The authorization server MUST maintain the binding between a refresh token and the client to whom it was issued.

10.12. Cross-Site Request Forgery
The client MUST implement CSRF protection for its redirection URI. This is typically accomplished by requiring any request sent to the redirection URI endpoint to include a value that binds the request to the user-agent's authenticated state (e.g., a hash of the session cookie used to authenticate the user-agent).
