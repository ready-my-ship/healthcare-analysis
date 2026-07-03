-- ======================
-- create silver schema
-- ======================
USE DATABASE HEALTHCARE_DB;
USE SCHEMA SILVER;

-- =============================
-- view data for transformations
-- =============================
select *
from bronze.survey
limit 10;

-- ====================
--  check questions
-- ====================
SELECT DISTINCT QUESTION
FROM BRONZE.SURVEY
ORDER BY QUESTION;

-- ==========================
-- create silver survey layer
-- ==========================
CREATE OR REPLACE TABLE SURVEY AS
SELECT
    PROVIDER_ID,
    HOSPITAL_NAME,
    ADDRESS,
    CITY,
    STATE,
    ZIP_CODE,
    COUNTY_NAME,
    PHONE_NUMBER,
    MEASURE_ID,
    QUESTION,
    CASE 
        WHEN QUESTION IN (
            'Patients who reported that their nurses "Always" communicated well',
            'Patients who reported that their nurses "Usually" communicated well',
            'Patients who reported that their nurses "Sometimes" or "Never" communicated well'
    )
    THEN 'NURSE_COMMUNICATION'
        WHEN QUESTION IN (
            'Patients who reported that their doctors "Always" communicated well',
            'Patients who reported that their doctors "Usually" communicated well',
            'Patients who reported that their doctors "Sometimes" or "Never" communicated well'
    )
    THEN 'DOCTOR_COMMUNICATION'
        WHEN QUESTION IN (
            'Patients who reported that their room and bathroom were "Always" clean',
            'Patients who reported that their room and bathroom were "Usually" clean',
            'Patients who reported that their room and bathroom were "Sometimes" or "Never" clean'
    )
    THEN 'CLEANLINESS'
    ELSE NULL
    END AS QUESTION_CATEGORY,
    ANSWER_DESCRIPTION,
    PATIENT_SURVEY_STAR_RATING,
    PATIENT_SURVEY_STAR_RATING_FOOTNOTE,
    ANSWER_PERCENT,
    ANSWER_PERCENT_FOOTNOTE,
    LINEAR_MEAN_VALUE,
    NUMBER_OF_COMPLETED_SURVEYS,
    NUMBER_OF_COMPLETED_SURVEYS_FOOTNOTE,
    SURVEY_RESPONSE_RATE_PERCENT,
    SURVEY_RESPONSE_RATE_PERCENT_FOOTNOTE,
    MEASURE_START_DATE,
    MEASURE_END_DATE,
    LOCATION
FROM BRONZE.SURVEY;



















