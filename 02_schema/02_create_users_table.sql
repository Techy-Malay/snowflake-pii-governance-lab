/*
------------------------------------------------------------------------------
File:        02_create_users_table.sql
Purpose:     Create sample USERS table containing PII for governance demo
Author:      Malaya Padhi (Malay)
Context:     Snowflake PII Governance Lab
Design Notes:
- Table intentionally mixes PII and non-PII columns
- Enables demonstration of column-level classification and masking
------------------------------------------------------------------------------
*/

CREATE OR REPLACE TABLE PII_GOV_LAB.RAW.USERS (
    USER_ID     NUMBER          COMMENT 'Surrogate user identifier',
    FULL_NAME   VARCHAR         COMMENT 'User full name (personal data)',
    EMAIL       VARCHAR         COMMENT 'User email address (PII)',
    SSN         VARCHAR         COMMENT 'Social Security Number (highly sensitive PII)',
    CREATED_AT  TIMESTAMP_NTZ   COMMENT 'Record creation timestamp'
);


