/*
------------------------------------------------------------------------------
File:        05_verify_classification_tags.sql
Purpose:     Verify classification tags applied to USERS table columns
Author:      Malaya Padhi (Malay)
Context:     Snowflake PII Governance Lab
------------------------------------------------------------------------------
*/

SELECT
    *
FROM
    TABLE(
        PII_GOV_LAB.information_schema.tag_references_all_columns('PII_GOV_LAB.RAW.USERS', 'table')
    );