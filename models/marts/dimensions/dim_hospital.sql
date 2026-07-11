SELECT DISTINCT
    PROVIDER_ID,
    HOSPITAL_NAME,
    ADDRESS,
    CITY,
    STATE,
    ZIP_CODE,
    COUNTY_NAME,
    PHONE_NUMBER,
    LOCATION
FROM {{ ref('stg_patient_survey') }}