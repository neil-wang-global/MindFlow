# Raw Source

## Source ID
- src-006

## ACQ Event
- ACQ-003

## Source URL
- https://datatracker.ietf.org/doc/html/rfc5424

## Fetch Timestamp
- 2026-04-01T10:21:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — IETF RFC standard

## Fetch Status
- success

## Fetch Completeness
- partial — severity level section extracted

## Original Content

RFC 5424 - The Syslog Protocol

6.2.1. PRI

The PRI part MUST have three, four, or five characters and will be bound with angle brackets as the first and last characters. The PRI part starts with a leading "<" ('less-than' character), followed by a number, which is followed by a ">" ('greater-than' character). The Facility and Severity values are numerically coded with decimal values.

The Priority value is calculated by first multiplying the Facility number by 8 and then adding the numerical value of the Severity.

Table 2. Syslog Message Severities

Numerical Code    Severity

      0             Emergency: system is unusable
      1             Alert: action must be taken immediately
      2             Critical: critical conditions
      3             Error: error conditions
      4             Warning: warning conditions
      5             Notice: normal but significant condition
      6             Informational: informational messages
      7             Debug: debug-level messages

Each message Priority also has a decimal Facility code associated with it. Some of the operating system daemons and processes have been assigned Facility values. Processes and daemons that have not been explicitly assigned a Facility may use any of the "local use" facilities or they may use the "user-level" Facility.

6.3. STRUCTURED-DATA

STRUCTURED-DATA provides a mechanism to express information in a well defined, easily parseable and interpretable data format. There are multiple usage scenarios. For example, it may express meta-information about the syslog message or application-specific information such as traffic counters or IP addresses.

STRUCTURED-DATA can contain zero, one, or multiple structured data elements, which are referred to as SD-ELEMENT. In case of zero structured data elements, the STRUCTURED-DATA field MUST contain the NILVALUE.
