SELECT DISTINCT
    MEASURE_ID,
    QUESTION,
    ANSWER_DESCRIPTION
FROM {{ ref('stg_patient_survey') }}