/*
------------------------------------------------------------------------------
File:        01_setup_environment.sql
Purpose:     Initial environment setup for Snowflake PII Governance Lab
Author:      Malaya Padhi (Malay)
Context:     Snowflake PII Governance Lab
Includes:
  - Role creation
  - Database & schema creation
  - Base grants
Design Rationale:
  - Single entry point for clean lab setup
  - Easy to execute and explain in interviews
------------------------------------------------------------------------------
*/


-- Expected execution role: ACCOUNTADMIN (or equivalent)


-- SECTION 1: Create roles
CREATE ROLE IF NOT EXISTS PII_ADMIN;
CREATE ROLE IF NOT EXISTS PII_ANALYST;

-- SECTION 2: Create database & schema
CREATE DATABASE IF NOT EXISTS PII_GOV_LAB;
CREATE SCHEMA IF NOT EXISTS PII_GOV_LAB.RAW;

-- SECTION 3: Grant base access
-- Note: No table-level privileges granted at this stage.
-- Data access will be controlled via masking policies.

GRANT USAGE ON DATABASE PII_GOV_LAB TO ROLE PII_ADMIN;
GRANT USAGE ON DATABASE PII_GOV_LAB TO ROLE PII_ANALYST;

GRANT USAGE ON SCHEMA PII_GOV_LAB.RAW TO ROLE PII_ADMIN;
GRANT USAGE ON SCHEMA PII_GOV_LAB.RAW TO ROLE PII_ANALYST;
