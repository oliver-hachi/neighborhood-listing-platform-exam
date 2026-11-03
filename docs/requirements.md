# Local Merchant Services & Client Appointment Subsystem

## Story 1: Service Provider / Merchant

**User Story:** As an authenticated local service provider, I want to submit service listing drafts with hourly rates so that clients can book appointments after administrators verify my services.

**Scope Estimate:** Medium

### Acceptance Criteria 1: Submit a Service Draft

- **Given:** An authenticated merchant.
- **When:** The merchant submits a valid service offering with a name, description, category, and hourly rate.
- **Then:** The system saves the service with `status = 'draft'` and links it to the merchant's authenticated `auth.uid()`.

### Acceptance Criteria 2: Validate Hourly Rates

- **Given:** An authenticated merchant submitting a service.
- **When:** The merchant submits a missing, zero, or negative hourly rate.
- **Then:** The system rejects the submission and returns a validation error.

### Acceptance Criteria 3: Protect Ownership

- **Given:** An authenticated merchant.
- **When:** The merchant attempts to submit a service using another user's ID.
- **Then:** The system associates the service with the authenticated merchant and prevents unauthorized ownership.

**Traceability:**
- Database migration: To be linked to the actual service migration created in Part 3.
- Route handler: To be linked to the actual service submission handler created in Part 4.

---

## Story 2: Neighborhood Client / Resident

**User Story:** As a neighborhood resident, I want to browse approved services by neighborhood district and request appointments without accessing other clients' bookings or private contact information.

**Scope Estimate:** Large

### Acceptance Criteria 1: Browse Approved Services

- **Given:** An anonymous visitor.
- **When:** The visitor requests available services.
- **Then:** The system returns only services with `status = 'approved'` and active neighborhood coverage zones.

### Acceptance Criteria 2: Filter by District

- **Given:** A resident browsing approved services.
- **When:** The resident selects a neighborhood district.
- **Then:** The system returns only approved services available in that district.

### Acceptance Criteria 3: Request an Appointment

- **Given:** An authenticated resident and an approved service with active coverage.
- **When:** The resident submits a valid appointment request.
- **Then:** The system creates a booking linked to the resident's authenticated user ID and the selected service.

### Acceptance Criteria 4: Protect Client Privacy

- **Given:** A resident who has submitted an appointment request.
- **When:** The resident attempts to access another client's booking or private contact information.
- **Then:** The system denies access.

**Traceability:**
- Database migration: To be linked to the actual booking and service migrations created in Part 3.
- Route handler: To be linked to the actual service browsing and appointment booking handlers created in Part 4.

---

## Story 3: Platform Administrator

**User Story:** As a platform administrator, I want to approve service listings, deactivate problematic service providers, and audit all client bookings to maintain a safe and trustworthy platform.

**Scope Estimate:** Large

### Acceptance Criteria 1: Approve Services

- **Given:** An authenticated administrator with administrative privileges.
- **When:** The administrator approves a draft service listing.
- **Then:** The system changes the service status to `approved` and records the action.

### Acceptance Criteria 2: Deactivate a Provider

- **Given:** An authenticated administrator.
- **When:** The administrator deactivates a service provider.
- **Then:** The system marks the provider as inactive and prevents new bookings for that provider's services.

### Acceptance Criteria 3: Audit Bookings

- **Given:** An authenticated administrator with appropriate permissions.
- **When:** The administrator requests booking audit records.
- **Then:** The system returns authorized booking records.

### Acceptance Criteria 4: Prevent Unauthorized Administration

- **Given:** An authenticated user without administrator privileges.
- **When:** The user attempts to approve a service, deactivate a provider, or access administrative booking records.
- **Then:** The system denies the request.

**Traceability:**
- Database migration: To be linked to the actual administrator-related schema or migrations created in Part 3.
- Route handler: To be linked to the actual administrator endpoints created in Part 4.