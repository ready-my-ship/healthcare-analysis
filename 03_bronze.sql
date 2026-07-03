-- ========================
-- create the bronze table
-- ========================
USE DATABASE HEALTHCARE_DB;
USE SCHEMA BRONZE;
CREATE OR REPLACE TABLE SURVEY
(
    PROVIDER_ID                             VARCHAR,
    HOSPITAL_NAME                           VARCHAR,
    ADDRESS                                 VARCHAR,
    CITY                                    VARCHAR,
    STATE                                   VARCHAR,
    ZIP_CODE                                VARCHAR,
    COUNTY_NAME                             VARCHAR,
    PHONE_NUMBER                            VARCHAR,
    MEASURE_ID                              VARCHAR,
    QUESTION                                VARCHAR,
    ANSWER_DESCRIPTION                      VARCHAR,
    PATIENT_SURVEY_STAR_RATING              VARCHAR,
    PATIENT_SURVEY_STAR_RATING_FOOTNOTE     VARCHAR,
    ANSWER_PERCENT                          VARCHAR,
    ANSWER_PERCENT_FOOTNOTE                 VARCHAR,
    LINEAR_MEAN_VALUE                       VARCHAR,
    NUMBER_OF_COMPLETED_SURVEYS             VARCHAR,
    NUMBER_OF_COMPLETED_SURVEYS_FOOTNOTE    VARCHAR,
    SURVEY_RESPONSE_RATE_PERCENT            VARCHAR,
    SURVEY_RESPONSE_RATE_PERCENT_FOOTNOTE   VARCHAR,
    MEASURE_START_DATE                      DATE,
    MEASURE_END_DATE                        DATE,
    LOCATION                                VARCHAR
);

SHOW TABLES;
DESC TABLE SURVEY;

LIST @HEALTHCARE_STG;

COPY INTO SURVEY
FROM @HEALTHCARE_STG
