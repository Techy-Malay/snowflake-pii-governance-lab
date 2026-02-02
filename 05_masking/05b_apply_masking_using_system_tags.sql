/*
------------------------------------------------------------------------------
File:        05b_apply_masking_using_system_tags.sql
Purpose:     Bind masking policies to columns via Snowflake system tags
Author:      Malaya Padhi (Malay)
Context:     Snowflake PII Governance Lab
------------------------------------------------------------------------------
*/
USE DATABASE PII_GOV_LAB;
USE SCHEMA RAW;
-- Apply EMAIL masking using SEMANTIC_CATEGORY
ALTER TABLE PII_GOV_LAB.RAW.USERS
  MODIFY COLUMN EMAIL
  SET MASKING POLICY mask_email_by_role;

-- Apply NAME masking
ALTER TABLE PII_GOV_LAB.RAW.USERS
  MODIFY COLUMN FULL_NAME
  SET MASKING POLICY mask_name_by_role;

-- Apply NATIONAL IDENTIFIER masking
ALTER TABLE PII_GOV_LAB.RAW.USERS
  MODIFY COLUMN SSN
  SET MASKING POLICY mask_national_id_by_role;
