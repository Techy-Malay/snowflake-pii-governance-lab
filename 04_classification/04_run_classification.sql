/*
------------------------------------------------------------------------------
File:        04_run_classification.sql
Purpose:     Trigger automatic classification of PII columns
Author:      Malaya Padhi (Malay)
Context:     Snowflake PII Governance Lab
Notes:
- Uses Snowflake system classification
- Results stored as column tags
------------------------------------------------------------------------------
*/

-- Switch to correct context
USE DATABASE PII_GOV_LAB;
USE SCHEMA RAW;

-- Run classification on the USERS table
CALL SYSTEM$CLASSIFY( 'PII_GOV_LAB.RAW.USERS',  {auto_tag': true});
