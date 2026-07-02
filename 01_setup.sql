USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;
-- ===============================================================================
-- change from accountadmin to healthcare_dev (reflecting true employee privilege)
-- ===============================================================================
CREATE OR REPLACE ROLE HEALTHCARE_DEV;

CREATE OR REPLACE WAREHOUSE HEALTHCARE_WH
WAREHOUSE_SIZE = 'XSMALL'
AUTO_SUSPEND = 60
AUTO_RESUME = TRUE;
USE WAREHOUSE HEALTHCARE_WH;
CREATE OR REPLACE DATABASE HEALTHCARE_DB;
USE DATABASE HEALTHCARE_DB;
CREATE OR REPLACE SCHEMA BRONZE;
CREATE OR REPLACE SCHEMA SILVER;
CREATE OR REPLACE SCHEMA GOLD;

-- =========================================
-- RBAC permissions to healtchare_dev role--
-- =========================================
-- warehouse 
GRANT USAGE
ON WAREHOUSE HEALTHCARE_WH
TO ROLE HEALTHCARE_DEV;

-- database
GRANT USAGE
ON DATABASE HEALTHCARE_DB
TO ROLE HEALTHCARE_DEV;

-- schema bronze
GRANT ALL PRIVILEGES
ON SCHEMA HEALTHCARE_DB.BRONZE
TO ROLE HEALTHCARE_DEV;

-- schema silver
GRANT ALL PRIVILEGES
ON SCHEMA HEALTHCARE_DB.SILVER
TO ROLE HEALTHCARE_DEV;

-- schema gold
GRANT ALL PRIVILEGES
ON SCHEMA HEALTHCARE_DB.GOLD
TO ROLE HEALTHCARE_DEV;

-- =======================================================
-- switch usage from accountadmin to healthcare_dev
-- =======================================================

GRANT ROLE HEALTHCARE_DEV TO USER SNOWFLAKE;
USE ROLE HEALTHCARE_DEV;
USE WAREHOUSE HEALTHCARE_WH;
USE DATABASE HEALTHCARE_DB;
