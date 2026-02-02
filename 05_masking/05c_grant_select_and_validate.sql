/*
------------------------------------------------------------------------------
File:        05c_grant_select_and_validate.sql
Purpose:     Grant access and demonstrate how to validate masking behavior
Author:      Malaya Padhi (Malay)
Context:     Snowflake PII Governance Lab

How to use this file:
1. Run this file once to grant access.
2. Validate masking using the SELECT statements below.
3. Validation MUST be done using a clean analyst user.
------------------------------------------------------------------------------
*/

USE DATABASE PII_GOV_LAB;
USE SCHEMA RAW;

-- ---------------------------------------------------------------------------
-- Step 1: Grant SELECT access to roles
-- ---------------------------------------------------------------------------

GRANT SELECT ON TABLE USERS TO ROLE PII_ADMIN;
GRANT SELECT ON TABLE USERS TO ROLE PII_ANALYST;

-- ---------------------------------------------------------------------------
-- Step 2: Validation instructions
-- ---------------------------------------------------------------------------
-- Masking depends on effective role privileges.
-- ACCOUNTADMIN sessions are NOT suitable for validation
-- because they inherit privileged roles and bypass masking.
--
-- Validation persona:
--   User: analyst_demo_user
--   Role: PII_ANALYST
--
-- Expected results:
--   PII_ADMIN   -> Unmasked data
--   PII_ANALYST -> Masked data
-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------
-- Step 3: Validation queries
-- ---------------------------------------------------------------------------

-- Run as PII_ADMIN
-- USE ROLE PII_ADMIN;
-- SELECT USER_ID, FULL_NAME, EMAIL, SSN
-- FROM PII_GOV_LAB.RAW.USERS;

-- ---------------------------------------------------------------------------

-- Run as clean analyst user (PII_ANALYST)
-- USE ROLE PII_ANALYST;
-- SELECT USER_ID, FULL_NAME, EMAIL, SSN
-- FROM PII_GOV_LAB.RAW.USERS;

-- ---------------------------------------------------------------------------
-- End of validation
-- ---------------------------------------------------------------------------
