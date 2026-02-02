/*
------------------------------------------------------------------------------
File:        03_insert_sample_users.sql
Purpose:     Insert controlled sample data into USERS table for PII demo
Author:      Malaya Padhi (Malay)
Context:     Snowflake PII Governance Lab
Data Policy:
- All data is fictitious
- Used only for governance and masking demonstrations
------------------------------------------------------------------------------
*/

INSERT INTO PII_GOV_LAB.RAW.USERS
(USER_ID, FULL_NAME, EMAIL, SSN, CREATED_AT)
VALUES
    (1, 'John Carter',   'john.carter@example.com',   '123-45-6789', CURRENT_TIMESTAMP()),
    (2, 'Emily Watson',  'emily.watson@example.com',  '987-65-4321', CURRENT_TIMESTAMP()),
    (3, 'Michael Brown', 'michael.brown@example.com', '555-66-7777', CURRENT_TIMESTAMP()),
    (4, 'Sarah Miller',  'sarah.miller@example.com',  '111-22-3333', CURRENT_TIMESTAMP());


SELECT * FROM PII_GOV_LAB.RAW.USERS;