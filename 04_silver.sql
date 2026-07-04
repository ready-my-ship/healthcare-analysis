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

    -- Nurse Communication
    WHEN QUESTION IN (
        'Patients who reported that their nurses "Always" communicated well',
        'Patients who reported that their nurses "Usually" communicated well',
        'Patients who reported that their nurses "Sometimes" or "Never" communicated well'
    )
    THEN 'NURSE_COMMUNICATION'

    -- Doctor Communication
    WHEN QUESTION IN (
        'Patients who reported that their doctors "Always" communicated well',
        'Patients who reported that their doctors "Usually" communicated well',
        'Patients who reported that their doctors "Sometimes" or "Never" communicated well'
    )
    THEN 'DOCTOR_COMMUNICATION'

    -- Staff Responsiveness
    WHEN QUESTION IN (
        'Patients who reported that they "Always" received help as soon as they wanted',
        'Patients who reported that they "Usually" received help as soon as they wanted',
        'Patients who reported that they "Sometimes" or "Never" received help as soon as they wanted'
    )
    THEN 'STAFF_RESPONSIVENESS'

    -- Room & Bathroom Cleanliness
    WHEN QUESTION IN (
        'Patients who reported that their room and bathroom were "Always" clean',
        'Patients who reported that their room and bathroom were "Usually" clean',
        'Patients who reported that their room and bathroom were "Sometimes" or "Never" clean'
    )
    THEN 'ROOM_AND_BATHROOM_CLEANLINESS'

    -- Quietness
    WHEN QUESTION IN (
        'Patients who reported that the area around their room was "Always" quiet at night',
        'Patients who reported that the area around their room was "Usually" quiet at night',
        'Patients who reported that the area around their room was "Sometimes" or "Never" quiet at night'
    )
    THEN 'QUIETNESS'

    -- Medication Communication
    WHEN QUESTION IN (
        'Patients who reported that staff "Always" explained about medicines before giving it to them',
        'Patients who reported that staff "Usually" explained about medicines before giving it to them',
        'Patients who reported that staff "Sometimes" or "Never" explained about medicines before giving it to them'
    )
    THEN 'MEDICATION_COMMUNICATION'

    -- Home Recovery Information
    WHEN QUESTION IN (
        'Patients who reported that YES, they were given information about what to do during their recovery at home',
        'Patients who reported that NO, they were not given information about what to do during their recovery at home'
    )
    THEN 'HOME_RECOVERY_INFORMATION'

    -- Understood Care
    WHEN QUESTION IN (
        'Patients who "Strongly Agree" they understood their care when they left the hospital',
        'Patients who "Agree" they understood their care when they left the hospital',
        'Patients who "Disagree" or "Strongly Disagree" they understood their care when they left the hospital'
    )
    THEN 'UNDERSTOOD_CARE'

    -- Recommend Hospital
    WHEN QUESTION IN (
        'Patients who reported YES, they would definitely recommend the hospital',
        'Patients who reported YES, they would probably recommend the hospital',
        'Patients who reported NO, they would probably not or definitely not recommend the hospital'
    )
    THEN 'RECOMMEND_HOSPITAL'

    -- Overall Hospital Rating
    WHEN QUESTION IN (
        'Patients who gave their hospital a rating of 9 or 10 on a scale from 0 (lowest) to 10 (highest)',
        'Patients who gave their hospital a rating of 7 or 8 on a scale from 0 (lowest) to 10 (highest)',
        'Patients who gave their hospital a rating of 6 or lower on a scale from 0 (lowest) to 10 (highest)'
    )
    THEN 'HOSPITAL_RATING'

    -- Star Ratings
    WHEN QUESTION IN (
        'Nurse communication - star rating',
        'Doctor communication - star rating',
        'Staff responsiveness - star rating',
        'Quietness - star rating',
        'Communication about medicines - star rating',
        'Cleanliness - star rating',
        'Discharge information - star rating',
        'Care transition - star rating',
        'Recommend hospital - star rating',
        'Overall hospital rating - star rating',
        'Summary star rating'
    )
    THEN 'STAR_RATING'

    -- Linear Mean Scores
    WHEN QUESTION IN (
        'Nurse communication - linear mean score',
        'Doctor communication - linear mean score',
        'Staff responsiveness - linear mean score',
        'Quietness - linear mean score',
        'Communication about medicines - linear mean score',
        'Cleanliness - linear mean score',
        'Discharge information - linear mean score',
        'Care transition - linear mean score',
        'Overall hospital rating - linear mean score',
        'Recommend hospital - linear mean score'
    )
    THEN 'LINEAR_MEAN_SCORE'
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

-- see if table is there
SHOW TABLES;

--VERIFY SCHEMA (COLUMNS AND DATATYPES)
DESC TABLE SILVER.SURVEY

-- shows if CASE worked
SELECT DISTINCT QUESTION_CATEGORY
FROM SURVEY
ORDER BY QUESTION_CATEGORY;

-- verify
SELECT *
FROM SILVER.SURVEY
LIMIT 10;

SELECT DISTINCT QUESTION
FROM BRONZE.SURVEY
WHERE QUESTION LIKE '%clean%';
-- see all things null
SELECT DISTINCT 
    QUESTION,
    QUESTION_CATEGORY,
FROM SILVER.SURVEY
WHERE QUESTION_CATEGORY IS NULL;


SELECT QUESTION
FROM BRONZE.SURVEY
WHERE QUESTION = 'Summary star rating'


SELECT DISTINCT
    QUESTION,
    QUESTION_CATEGORY
FROM SILVER.SURVEY
WHERE QUESTION_CATEGORY IS NULL;


