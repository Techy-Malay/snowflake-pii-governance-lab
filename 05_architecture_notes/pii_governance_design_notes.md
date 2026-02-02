# PII Governance – Architecture Design Notes

## Context

This document captures the **architectural decisions, trade-offs, and rationale** behind the *Snowflake PII Governance Lab*.

The goal is not to document Snowflake features exhaustively, but to explain **why specific governance patterns were chosen** and how they align with real-world enterprise environments.

---

## Core Design Objective

> **Enforce PII governance at query time without duplicating data.**

This project demonstrates how sensitive data can be protected while preserving:
- A single source of truth
- Analytics usability
- Role-based least privilege access

---

## Governance Model Overview

The governance model is built on three layers:

1. **Discovery** – Identify sensitive data
2. **Decision** – Define who can see what
3. **Enforcement** – Apply controls at query execution time

Snowflake Horizon Catalog enables the discovery layer, while dynamic masking policies enforce governance at runtime.

---

## PII Discovery Strategy

### Automatic Classification (Horizon Catalog)

- `SYSTEM$CLASSIFY` was used to automatically identify sensitive columns
- Snowflake applied system tags under:
  - `SNOWFLAKE.CORE.PRIVACY_CATEGORY`
  - `SNOWFLAKE.CORE.SEMANTIC_CATEGORY`

Detected classifications included:
- NAME
- EMAIL
- NATIONAL_IDENTIFIER

Automatic classification was validated using:

```
<DB>.INFORMATION_SCHEMA.TAG_REFERENCES_ALL_COLUMNS
```

This approach provides fast feedback and avoids reliance on UI-only validation.

---

## Why System Tags Were Preferred

System-applied tags were used instead of custom tags because:

- They are Snowflake-native
- They reduce custom governance logic
- They align directly with Horizon metadata
- They are easier to explain and maintain

Custom tags remain a valid fallback but were not required in this scope.

---

## Masking Strategy (Query-Time Enforcement)

Dynamic masking policies were applied directly to table columns.

Key characteristics:
- No masked copies of data
- No security views
- Enforcement occurs during query execution

This ensures that:
- Analysts see masked values
- Administrators see clear values
- The same SQL returns different results based on role

---

## Role Evaluation Design

### Why `IS_ROLE_IN_SESSION()` Was Used

Initial masking logic based on `CURRENT_ROLE()` was insufficient due to Snowflake role inheritance.

In Snowflake:
- Roles can inherit other roles
- Admin roles often activate multiple privileges

Using:

```
IS_ROLE_IN_SESSION('PII_ADMIN')
```

ensures masking logic correctly evaluates the **entire role hierarchy**, not just the active role.

This is a **production-grade Snowflake RBAC pattern**.

---

## Manual vs Automatic Classification (Fallback Strategy)

Automatic classification may not be fully enabled in all accounts.

This project documents a fallback approach using manual tags when:
- Horizon metadata is restricted
- Account-level governance features vary

The masking architecture remains unchanged regardless of classification method.

---

## Custom Classification (Out of Scope)

Snowflake supports custom classifiers for domain-specific identifiers.

This project intentionally excludes custom classifiers because:
- Built-in classifiers covered all PII in scope
- Custom classifiers increase complexity
- They are typically owned by centralized governance teams

Custom classification is better introduced as an advanced extension.

---

## Key Architectural Takeaways

- Classification without enforcement does not protect data
- Governance should live **inside the data platform**
- Query-time masking scales better than data duplication
- Native platform features should be preferred over custom logic
- Fallback designs are essential for real-world environments

---

## Author

**Malaya Padhi (Malay)**  
Senior / Principal Data Architect Track

---

## Final Note

This document is intended to support architectural discussions, interviews, and design reviews.
It reflects practical Snowflake governance experience rather than theoretical feature coverage.

