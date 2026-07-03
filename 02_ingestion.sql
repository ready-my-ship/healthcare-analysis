-- ================================
-- initialize set up
-- ================================
USE ROLE ACCOUNTADMIN;
USE WAREHOUSE HEALTHCARE_WH;
USE DATABASE HEALTHCARE_DB;
USE SCHEMA BRONZE;

-- ================================
-- set up storage integration
-- ================================
CREATE OR REPLACE STORAGE INTEGRATION HEALTHCARE_S3_INT
  TYPE = 'EXTERNAL_STAGE'
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::501000278160:role/healthcare_analysis_2026'
  STORAGE_ALLOWED_LOCATIONS = ('S3://healthcare-analysis-2026-501000278160-us-east-1-an/');

-- ====================
-- create file format 
-- =====================
CREATE OR REPLACE FILE FORMAT HEALTHCARE_CSV_FORMAT
  TYPE = CSV
  FIELD_DELIMITER = ','
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
  SKIP_HEADER = 1
  NULL_IF = ('NULL', 'null')
  EMPTY_FIELD_AS_NULL = true;

-- ================
-- create stage
-- ================
CREATE OR REPLACE STAGE HEALTHCARE_STG
  STORAGE_INTEGRATION = HEALTHCARE_S3_INT
  URL = 'S3://healthcare-analysis-2026-501000278160-us-east-1-an/'
  FILE_FORMAT = HEALTHCARE_CSV_FORMAT;

SHOW STAGES;
SHOW FILE FORMATS;

-- =========================
-- verify CSV loaded to S3
-- =========================
list @HEALTHCARE_STG



