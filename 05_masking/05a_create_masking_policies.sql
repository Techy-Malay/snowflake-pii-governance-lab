/*
------------------------------------------------------------------------------
File:        05a_create_masking_policies.sql
Purpose:     Create dynamic masking policies using Snowflake system tags
Author:      Malaya Padhi (Malay)
Context:     Snowflake PII Governance Lab
Design Notes:
- Policies reference Snowflake CORE tags (SEMANTIC_CATEGORY, PRIVACY_CATEGORY)
- Admin sees clear values; Analyst sees masked values
------------------------------------------------------------------------------
*/
USE DATABASE PII_GOV_LAB;
USE SCHEMA RAW;
-- Mask EMAIL values
CREATE OR REPLACE MASKING POLICY mask_email_by_role
AS (val STRING) RETURNS STRING ->
  CASE
    WHEN CURRENT_ROLE() IN ('PII_ADMIN') THEN val
    ELSE REGEXP_REPLACE(val, '(^.).*(@.*$)', '\\1*****\\2')
  END;

-- Mask NAME values
CREATE OR REPLACE MASKING POLICY mask_name_by_role
AS (val STRING) RETURNS STRING ->
  CASE
    WHEN CURRENT_ROLE() IN ('PII_ADMIN') THEN val
    ELSE 'REDACTED'
  END;

-- Mask NATIONAL IDENTIFIER values (e.g., SSN)
CREATE OR REPLACE MASKING POLICY mask_national_id_by_role
AS (val STRING) RETURNS STRING ->
  CASE
    WHEN CURRENT_ROLE() IN ('PII_ADMIN') THEN val
    ELSE 'XXX-XX-XXXX'
  END;
