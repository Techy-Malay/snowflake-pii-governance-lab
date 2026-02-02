/*
------------------------------------------------------------------------------
File:        05c_grant_select_and_validate.sql
Purpose:     Grant SELECT and validate role-based masking behavior
Author:      Malaya Padhi (Malay)
Context:     Snowflake PII Governance Lab
------------------------------------------------------------------------------
*/
USE DATABASE PII_GOV_LAB;
USE SCHEMA RAW;


---- select current user
SELECT CURRENT_USER();
-- In my case current user is SFTRAINING


-- Grant roles to your user
GRANT ROLE PII_ADMIN   TO USER SFTRAINING;
GRANT ROLE PII_ANALYST TO USER SFTRAINING;

-- Grant SELECT to both roles
GRANT SELECT ON TABLE PII_GOV_LAB.RAW.USERS TO ROLE PII_ADMIN;
GRANT SELECT ON TABLE PII_GOV_LAB.RAW.USERS TO ROLE PII_ANALYST;

-- Validate as ADMIN
USE ROLE PII_ADMIN;
SELECT USER_ID, FULL_NAME, EMAIL, SSN FROM PII_GOV_LAB.RAW.USERS;





-- Validate as ANALYST
USE ROLE PII_ANALYST;
SELECT USER_ID, FULL_NAME, EMAIL, SSN FROM PII_GOV_LAB.RAW.USERS;
