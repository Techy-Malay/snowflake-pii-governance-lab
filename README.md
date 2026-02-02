# Snowflake PII Governance Lab  
### Horizon Catalog, Classification & Role-Based Masking

## Overview

This project demonstrates **PII governance in Snowflake** using
**Horizon Catalog**, automatic classification, tagging, and
**query-time masking policies**.

The key idea is simple but powerful:

> **The same table returns different results based on user role,
> without duplicating data or creating separate masked tables.**

This lab is designed from a **data architect perspective** and focuses on
practical, interview-ready governance patterns.

---

## Problem Statement

PII rarely lives in a single place.  
In most analytics platforms, the real risk is **uncontrolled access**, not storage.

Common anti-patterns include:
- Creating duplicate masked tables
- Hardcoding security logic into views
- Managing governance outside the data platform

This project demonstrates how Snowflake enforces **governance at query time**
using native SQL policies.

---

## What This Lab Covers

- Role-based access design (`PII_ADMIN`, `PII_ANALYST`)
- Automatic PII classification using Snowflake Horizon
- System-applied column tags
- Dynamic data masking policies
- Same table, different query results based on role
- Governance aligned with **least privilege** principles

## Validation Notes

Dynamic data masking is validated using a dedicated analyst user that does not
inherit any administrative roles.

Snowflake evaluates masking policies based on effective role privileges at
query execution time. As a result, sessions using ACCOUNTADMIN (or users
inheriting privileged roles) are not suitable for validating masking behavior,
because they bypass masking by design.

## Validation Results

When queried using different personas:

- **PII_ADMIN**
  - Full PII visible
  - Used for governance administration

- **PII_ANALYST**
  - PII masked (EMAIL, FULL_NAME, SSN)
  - Represents a real data consumer

Screenshots in the `/screenshots` folder demonstrate this behavior.

---

## Repository Structure

```
.
├── 01_setup_environment.sql
├── 02_table_design.sql
├── 03_sample_data.sql
├── 04_classification_and_tagging.sql
├── 05_masking/
│   ├── 05a_create_masking_policies.sql
│   ├── 05b_apply_masking_using_system_tags.sql
│   └── 05c_grant_select_and_validate.sql
├── 06_validation_users/
│   └── 06_create_validation_users.sql
├── screenshots/
│   ├── admin_unmasked.png
│   └── analyst_masked.png
└── README.md
```

---

## How to Run (Quick Start)

1. Run setup and table scripts (01–03)
2. Run classification and tagging (04)
3. Create masking policies (05a)
4. Apply masking policies (05b)
5. Grant access and review validation steps (05c)
6. Create validation analyst user (06)
7. Validate masking using the analyst user

---
---

## What This Lab Intentionally Excludes

To keep the project **focused and high-signal**, the following Horizon features
are intentionally out of scope:

- Data lineage and access history dashboards
- Row access policies
- Data quality monitoring
- Governance metrics and dashboards

These features are valuable but not required to demonstrate
**core PII governance design**.

---

## Scope and Design Choice

Snowflake Horizon provides a broad governance framework.
This project intentionally focuses on **PII classification and query-time masking**
because these are the most common real-world data protection requirements.

The goal is to demonstrate:
- Clear architectural intent
- Minimal but effective governance
- Patterns that scale across teams

---
## Note on Custom Classification

Snowflake Horizon supports **custom classifiers** that allow teams to
extend automatic data classification using domain-specific patterns
(e.g., payment card numbers, proprietary identifiers).

This project does **not** implement custom classification intentionally.

**Reasoning:**
- Built-in classification reliably detected all PII in scope
- Custom classifiers are typically introduced by centralized
  governance teams
- Including them here would increase complexity without improving
  the core governance outcome

Custom classification is recommended for domains with
business-specific identifiers or regulatory requirements,
and is best introduced as an advanced, follow-on capability.


---

## Further Exploration

For readers who want to explore the **full Horizon governance workflow**,
including personas, lineage, access history, and advanced monitoring,
refer to Snowflake’s official guide:

- *Getting Started with Horizon for Data Governance in Snowflake*

This project should be viewed as a **focused architectural subset**
of the broader Horizon platform.

---

## Author

**Malaya Padhi (Malay)**  
Senior / Principal Data Architect Track

---

## Final Note

This lab is not a feature checklist.
It is a **design demonstration** showing how governance can be enforced
*close to the data*, at scale, and without operational complexity.

