/*
------------------------------------------------------------------------------
File:        06_create_validation_users.sql
Purpose:     Create a dedicated analyst user for validating PII masking
Author:      Malaya Padhi (Malay)
Context:     Snowflake PII Governance Lab
Design Notes:
- Masking must be validated using a clean consumer persona
- ACCOUNTADMIN / admin users are not suitable due to role inheritance
------------------------------------------------------------------------------
*/

USE ROLE ACCOUNTADMIN;

-- ---------------------------------------------------------------------------
-- Create clean analyst user (no admin role inheritance)
-- ---------------------------------------------------------------------------

CREATE USER IF NOT EXISTS analyst_demo_user
  PASSWORD = 'Temp@123'
  MUST_CHANGE_PASSWORD = FALSE
  COMMENT = 'Dedicated analyst user for validating PII masking behavior';

-- ---------------------------------------------------------------------------
-- Grant ONLY analyst role
-- ---------------------------------------------------------------------------

GRANT ROLE PII_ANALYST TO USER analyst_demo_user;
