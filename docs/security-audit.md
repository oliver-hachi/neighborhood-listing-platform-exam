# Security Audit — Row-Level Security

## 1. RLS Activation

Row-Level Security is enabled on all five database tables:

- profiles
- service_categories
- services
- service_category_mappings
- bookings

## 2. Authorization Test Matrix

| User Role | Test Scenario | Expected Result | Actual Result |
|---|---|---|---|
| Anonymous | Read approved services | PASS — Allowed | Pending verification |
| Anonymous | Read draft services | FAIL — Denied | Pending verification |
| Provider A | Update Provider A draft service | PASS — Allowed | Pending verification |
| Provider A | Update Provider B service | FAIL — Denied | Pending verification |
| Client | Submit a booking | PASS — Allowed | Pending verification |
| Client | Read existing bookings | FAIL — Denied | Pending verification |
| Admin | Read and write across all schemas using elevated server execution | PASS — Allowed | Pending verification |

## 3. Security Controls

- Public visitors can read approved services and active service categories.
- Providers can access their own services using `auth.uid()`.
- Provider modifications are restricted to draft and suspended services.
- Visitors can submit bookings.
- Clients do not receive permission to read bookings.
- Provider booking visibility is restricted to bookings for their own services.
- Elevated service-role access must remain server-side.

## 4. Verification Status

The RLS migration file has been created and committed. Database execution and authorization tests have not yet been verified in Supabase.

**Current status:** Pending Supabase execution and role-based testing.
