# Raw Source

## Source ID
- src-002

## ACQ Event
- ACQ-001

## Source URL
- https://learn.microsoft.com/en-us/azure/architecture/patterns/health-endpoint-monitoring

## Fetch Timestamp
- 2026-04-01T10:03:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- Microsoft Azure Architecture Center — authoritative cloud architecture pattern documentation

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

Health Endpoint Monitoring pattern - Azure Architecture Center

To verify that applications and services are performing correctly, you can use the Health Endpoint Monitoring pattern. This pattern specifies the use of functional checks in an application. External tools can access these checks at regular intervals through exposed endpoints.

Context and problem

It's a good practice to monitor web applications and back-end services. Monitoring helps ensure that applications and services are available and performing correctly. Business requirements often include monitoring.

It's sometimes more difficult to monitor cloud services than on-premises services. One reason is that you don't have full control of the hosting environment. Another is that the services typically depend on other services that platform vendors and others provide.

Many factors affect cloud-hosted applications. Examples include network latency, the performance and availability of the underlying compute and storage systems, and the network bandwidth between them. A service can fail entirely or partially due to any of these factors. To ensure a required level of availability, you must verify at regular intervals that your service performs correctly. Your service level agreement (SLA) might specify the level that you need to meet.

Solution

Implement health monitoring by sending requests to an endpoint on your application. The application should perform the necessary checks and then return an indication of its status.

A health monitoring check typically combines two factors:

- The checks (if any) that the application or service performs in response to the request to the health verification endpoint
- The analysis of the results by the tool or framework that performs the health verification check

The response code indicates the status of the application. Optionally, the response code also provides the status of components and services that the app uses. The monitoring tool or framework performs the latency or response time check.

The health monitoring code in the application might also run other checks to determine:

- The availability and response time of cloud storage or a database.
- The status of other resources or services that the application uses. These resources and services might be in the application or outside it.

Typical checks that monitoring tools perform include:

- Validating the response code. For example, an HTTP response of 200 (OK) indicates that the application responded without error. The monitoring system might also check for other response codes to give more comprehensive results.
- Checking the content of the response to detect errors, even when the status code is 200 (OK). By checking the content, you can detect errors that affect only a section of the returned web page or service response. For example, you might check the title of a page or look for a specific phrase that indicates that the app returned the correct page.
- Measuring the response time. The value includes the network latency and the time that the application took to issue the request. An increasing value can indicate an emerging problem with the application or network.
- Checking resources or services that are located outside the application. An example is a content delivery network that the application uses to deliver content from global caches.
- Checking for the expiration of TLS certificates.
- Measuring the response time of a DNS lookup for the URL of the application. This check measures DNS latency and DNS failures.
- Validating the URL that a DNS lookup returns. By validating, you can ensure that entries are correct. You can also help prevent malicious request redirection that might result after an attack on your DNS server.

Issues and considerations

Consider the following points when you decide how to implement this pattern:

- Think about how to validate the response. For example, determine whether a 200 (OK) status code is sufficient to verify that the application is working correctly. Checking the status code is the minimum implementation of this pattern. A status code provides a basic measure of application availability. But a code supplies little information about the operations, trends, and possible upcoming issues in the application.
- Determine the number of endpoints to expose for an application. One approach is to expose at least one endpoint for the core services that the application uses and another for lower-priority services. With this approach, you can assign different levels of importance to each monitoring result. Also consider exposing extra endpoints. You can expose one for each core service to increase monitoring granularity. For example, a health verification check might check the database, the storage, and an external geocoding service that an application uses. Each might require a different level of uptime and response time. The geocoding service or some other background task might be unavailable for a few minutes. But the application might still be healthy.
- Decide whether to use the same endpoint for monitoring and for general access. You can use the same endpoint for both but design a specific path for health verification checks. For example, you can use /health on the general access endpoint.
- Determine the type of information to collect in the service in response to monitoring requests. You also need to determine how to return this information. Most existing tools and frameworks look only at the HTTP status code that the endpoint returns.
- Figure out how much information to collect. Performing excessive processing during the check can overload the application and affect other users. The processing time might also exceed the timeout of the monitoring system. As a result, the system might mark the application as unavailable. Most applications include instrumentation such as error handlers and performance counters.
- Consider caching the endpoint status. Running the health check frequently might be expensive. For example, if the health status is reported through a dashboard, you don't want every request to the dashboard to trigger a health check. Instead, periodically check the system health, and cache the status. Expose an endpoint that returns the cached status.
- Plan how to configure security for the monitoring endpoints. By configuring security, you can help protect the endpoints from public access, which might:
    - Expose the application to malicious attacks.
    - Risk the exposure of sensitive information.
    - Attract denial of service (DoS) attacks.

When to use this pattern

This pattern is useful for:

- Monitoring websites and web applications to verify availability.
- Monitoring websites and web applications to check for correct operation.
- Monitoring middle-tier or shared services to detect and isolate failures that can disrupt other applications.
- Complementing existing instrumentation in the application, such as performance counters and error handlers. Health verification checking doesn't replace application requirements for logging and auditing. Instrumentation can provide valuable information for an existing framework that monitors counters and error logs to detect failures or other issues. But instrumentation can't provide information if an application is unavailable.
